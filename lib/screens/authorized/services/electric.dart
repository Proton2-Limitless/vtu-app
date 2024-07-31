import 'package:flutter/material.dart';
import 'package:vtu_client/model/electricity.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/form_field.dart';
// import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Electric extends StatefulWidget {
  // const Electric({super.key});

  final Future<Map<String, dynamic>> futureData;

  Electric({super.key}) : futureData = fetchAllElectricty();

  @override
  State<Electric> createState() => _ElectricState();
}

class _ElectricState extends State<Electric> {
  final _formKey = GlobalKey<FormState>();
  String _choseProvider = "Select Provider";
  String _selectMeter = "Select Meter";

  final TextEditingController meterNumber = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController beneficiary = TextEditingController();

  @override
  void dispose() {
    meterNumber.dispose();
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

  List<dynamic> identifier = [];

  @override
  Widget build(BuildContext context) {
    const String title = "Pay For ELetric";

    return FutureBuilder(
      future: widget.futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: fadeTextStyle(fsize: 20, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace_sharp,
                  color: secondaryColor(context),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: fadeTextStyle(fsize: 20, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace_sharp,
                  color: secondaryColor(context),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Center(
              child: Text("Error..."),
            ),
          );
        } else if (snapshot.hasData) {
          final electrics = snapshot.data;

          // Map<String, dynamic> selectedElectric = {};
          return ServiceWidget(
            title: title,
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
                        "Select Provider",
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
                            tap(String provider) {
                              setState(() {
                                _choseProvider = provider;
                              });
                              final selectElec = availableElectric
                                  .where((element) =>
                                      element.name == _choseProvider)
                                  .toList()[0];

                              identifier = electrics?[selectElec.identifier][0]
                                  ["PRODUCT"];
                              // print(electrics?[selectElec.identifier]);
                              Navigator.pop(context);
                            }

                            List<String> providers = [];

                            providers = availableElectric.map(
                              (val) {
                                return val.name;
                              },
                            ).toList();

                            showCustomModalBottomSheet(
                              context,
                              datas: providers,
                              title: "Select Provider",
                              tap: tap,
                              provider: _choseProvider,
                              sheetHeight: 330,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _choseProvider,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: fadeTextStyle(context).copyWith(
                                    color: _choseProvider == "Select Provider"
                                        ? Colors.grey[500]
                                        : customColor(context),
                                    fontWeight:
                                        _choseProvider == "Select Provider"
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
                      const SizedBox(height: 15),
                      Text(
                        "Select Meter",
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
                                _selectMeter = meter;
                              });

                              Navigator.pop(context);
                            }

                            List<String> providers = ["prepaid", "postpaid"];

                            showCustomModalBottomSheet(
                              context,
                              datas: providers,
                              title: "Select Meter Type",
                              tap: tap,
                              meterType: _selectMeter,
                              sheetHeight: 200,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _selectMeter != "Select Meter"
                                      ? _selectMeter.toUpperCase()
                                      : _selectMeter,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: fadeTextStyle(context).copyWith(
                                    color: _selectMeter == "Select Meter"
                                        ? Colors.grey[500]
                                        : customColor(context),
                                    fontWeight: _selectMeter == "Select Meter"
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
                      const SizedBox(height: 20),
                      Text(
                        "Meter Number",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 5),
                      InputFormField(
                        controller: meterNumber,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the meter number';
                          } else if (!RegExp(r'^[a-zA-Z0-9]{7,11}$')
                              .hasMatch(value.trim())) {
                            return 'Meter number must be between 7 to 11 characters'
                                ' long and can only contain numbers and letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Amount",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 5),
                      InputFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter amount';
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                InputFormField(
                                  controller: beneficiary,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (isBeneficiary) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                  if (_choseProvider == "Select Provider" ||
                      _choseProvider == "") {
                    showSnackBar(context, "Please select provider");
                    return;
                  }
                  if (_selectMeter == "Select Meter" || _selectMeter == "") {
                    showSnackBar(context, "Please select meter type");
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    dynamic meterProps = identifier
                        .where((element) =>
                            element["PRODUCT_TYPE"] == _selectMeter)
                        .toList()[0];
                    double min = meterProps["MINIMUN_AMOUNT"] != null
                        ? double.tryParse(meterProps["MINIMUN_AMOUNT"])!
                        : 0;
                    double max = meterProps["MAXIMUM_AMOUNT"] != null
                        ? double.tryParse(meterProps["MAXIMUM_AMOUNT"])!
                        : 0;
                    if (double.tryParse(amount.text)! < min ||
                        double.tryParse(amount.text)! > max) {
                      showSnackBar(
                        context,
                        "amount should be between ${min.toStringAsFixed(0)} and ${max.toStringAsFixed(0)}",
                      );
                      return;
                    }

                    summaryDialog(
                      context,
                      [
                        {"key": "Provider", "value": _choseProvider},
                        {"key": "Meter", "value": _selectMeter},
                        {"key": "Meter Number", "value": meterNumber.text},
                        {"key": "Price", "value": amount.text},
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
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                style: fadeTextStyle(fsize: 20, context).copyWith(
                  color: secondaryColor(context),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace_sharp,
                  color: secondaryColor(context),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Center(
              child: Text("No data..."),
            ),
          );
        }
      },
    );
  }
}
