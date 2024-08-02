import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/customized_form_field.dart';
import 'package:vtu_client/utils/customized_input_field.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amount = TextEditingController();
  String payMethod = "";

  @override
  Widget build(BuildContext context) {
    String accNmbr = "813 890 7445";
    void copyreferralCode() async {
      try {
        await Clipboard.setData(ClipboardData(text: accNmbr));
        if (context.mounted) {
          showSnackBar(context, "Acc Number Copied!");
        }
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, "Failed to copy acc number.");
        }
      }
    }

    return ServiceWidget(
      title: "Deposit",
      noBeneficiary: true,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Number",
                style: fadeTextStyle(fsize: 16, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
              Row(
                children: [
                  Text(
                    accNmbr,
                    style: fadeTextStyle(fsize: 20, context).copyWith(
                      color: secondaryColor(context),
                    ),
                  ),
                  IconButton(
                    onPressed: copyreferralCode,
                    icon: const Icon(Icons.copy),
                    color: secondaryColor(context),
                  )
                ],
              ),
              Text(
                "Account Name",
                style: fadeTextStyle(fsize: 16, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
              Text(
                "Habib Yusuf-RechargeNow".toUpperCase(),
                style: fadeTextStyle(fsize: 20, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: containerColor(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fund Account",
                  style: fadeTextStyle(fsize: 24, context).copyWith(
                    color: customColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomizedFormInput(
                  controller: amount,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Amount';
                    } else if (int.parse(value.trim()) < 1000) {
                      return 'Enter amount greater than 100';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  label: "Amount",
                ),
                const SizedBox(height: 10),
                CustomizedTapToShowBottomSheet(
                  label: "Payment Method",
                  onTap: () {
                    tap(String method) {
                      setState(() {
                        payMethod = method;
                      });

                      Navigator.pop(context);
                    }

                    List<String> providers = [
                      "Automatic Transfer",
                      "Bank Transfer",
                      "Paystack",
                    ];

                    showCustomModalBottomSheet(
                      context,
                      datas: providers,
                      title: "Choose payment method",
                      tap: tap,
                      meterType: payMethod,
                      sheetHeight: 250,
                    );
                  },
                  initialBtnLbl: "Choose denomination",
                  props: payMethod,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (payMethod == "") {
                        showSnackBar(context, "Please select denomination");
                        return;
                      }
                      summaryDialog(
                        context,
                        [
                          {"key": "Payment Method", "value": payMethod},
                          {
                            "key": "Price",
                            "value": double.tryParse(amount.text)!,
                          },
                        ],
                      );
                    }
                    return;
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 10, 58, 131),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Proceed",
                        style: fadeTextStyle(context).copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
