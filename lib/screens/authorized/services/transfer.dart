import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/form_field.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController recieverEmail = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController beneficiary = TextEditingController();
  String transferType = "Select transfer type";

  @override
  void dispose() {
    recieverEmail.dispose();
    amount.dispose();
    beneficiary.dispose();
    super.dispose();
  }

  bool isBeneficiary = false;
  void addBeneficiary() {
    setState(() {
      isBeneficiary = !isBeneficiary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ServiceWidget(
      title: "Transfer",
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 14,
          ),
          width: double.infinity,
          color: containerColor(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer type",
                  style: fadeTextStyle(fsize: 16, context).copyWith(
                    color: customColor(context).withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      tap(String meter) {
                        setState(() {
                          transferType = meter;
                        });

                        Navigator.pop(context);
                      }

                      List<String> providers = ["User", "Bank"];

                      showCustomModalBottomSheet(
                        context,
                        datas: providers,
                        title: "Select Transaction Type",
                        tap: tap,
                        meterType: transferType,
                        sheetHeight: 200,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            transferType != "Select transfer type"
                                ? transferType.toUpperCase()
                                : transferType,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: fadeTextStyle(context).copyWith(
                              color: transferType == "Select transfer type"
                                  ? Colors.grey[500]
                                  : customColor(context),
                              fontWeight: transferType == "Select transfer type"
                                  ? null
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down_outlined),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Reciever",
                  style: fadeTextStyle(fsize: 16, context).copyWith(
                    color: customColor(context).withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                InputFormField(
                  controller: recieverEmail,
                  keyboardType: transferType == "User"
                      ? TextInputType.emailAddress
                      : TextInputType.number,
                  validator: (value) {
                    const pattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    final regExp = RegExp(pattern);

                    final bankAccLength = recieverEmail.text.length == 10;

                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (transferType == "User") {
                      if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                    }
                    if (transferType == "Bank") {
                      if (!bankAccLength) {
                        return 'Account Number is suppose to be 10 numbers';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Amount",
                  style: fadeTextStyle(fsize: 16, context).copyWith(
                    color: customColor(context).withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                InputFormField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Amount';
                    } else if (int.parse(value.trim()) < 100) {
                      return 'Enter amount greater than 100';
                    }
                    if (transferType == "Bank" &&
                        int.parse(value.trim()) < 1000) {
                      return 'Enter amount greater than 1000';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomRadioButton(
                  addBeneficiary: addBeneficiary,
                  isBeneficiary: isBeneficiary,
                ),
                isBeneficiary
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Beneficiary name",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 5),
                          InputFormField(
                            controller: beneficiary,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (isBeneficiary) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your beneficiary name';
                                }
                                return null;
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              summaryDialog(
                context,
                [
                  {"key": "Reciever", "value": recieverEmail.text},
                  {"key": "Price", "value": amount.text},
                ],
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 10, 58, 131),
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
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
    );
  }
}
