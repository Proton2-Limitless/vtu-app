import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/customized_form_field.dart';
import 'package:vtu_client/utils/customized_input_field.dart';
import 'package:vtu_client/widget/airtime/select_airtime.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class RechargeCard extends StatefulWidget {
  const RechargeCard({super.key});

  @override
  State<RechargeCard> createState() => _RechargeCardState();
}

class _RechargeCardState extends State<RechargeCard> {
  String airtime = "";
  String? networkImage;
  Color? networkColor;
  String _props = "Choose denomination";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController quantity = TextEditingController();

  selectNetwork(String name, String imageStr, Color color) {
    setState(() {
      airtime = name;
      networkImage = imageStr;
      networkColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ServiceWidget(
      title: "Print Recharge Card",
      noBeneficiary: true,
      children: [
        SelectNetwork(selectNetwork: selectNetwork),
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 14,
            ),
            width: double.infinity,
            color: containerColor(context),
            child: Column(
              children: [
                CustomizedTapToShowBottomSheet(
                  label: "denomination",
                  onTap: () {
                    tap(String meter) {
                      setState(() {
                        _props = meter;
                      });

                      Navigator.pop(context);
                    }

                    List<String> providers = ["100", "200", "500"];

                    showCustomModalBottomSheet(
                      context,
                      datas: providers,
                      title: "Choose denomination",
                      tap: tap,
                      meterType: _props,
                      sheetHeight: 250,
                    );
                  },
                  initialBtnLbl: "Choose denomination",
                  props: _props,
                ),
                const SizedBox(height: 10),
                CustomizedFormInput(
                  controller: quantity,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  label: "Quantity",
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            if (_props == "Choose denomination" || _props == "") {
              showSnackBar(context, "Please select denomination");
              return;
            }
            if (_formKey.currentState!.validate()) {
              summaryDialog(
                context,
                [
                  {"key": "network", "value": airtime},
                  {"key": "denomination", "value": _props},
                  {"key": "Quantity", "value": quantity.text},
                  {
                    "key": "Price",
                    "value": double.tryParse(_props)! *
                        double.tryParse(quantity.text)!,
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
