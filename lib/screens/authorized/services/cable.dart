import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/model/other_services.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/custom_dialog_package.dart';
import 'package:vtu_client/utils/form_field.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Cable extends StatefulWidget {
  const Cable({super.key});

  @override
  State<Cable> createState() => _CableState();
}

class _CableState extends State<Cable> {
  double? cablePrice;
  String _selectedPlanLabel = "Choose a Cable plan";

  String _selectedPackageLabel = "Choose a package";

  final cables = ["DStv", "GOtv", "Startimes"];
  List<Cables> cableData = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController smartCardNumber = TextEditingController();
  final TextEditingController beneficiary = TextEditingController();

  @override
  void dispose() {
    beneficiary.dispose();
    smartCardNumber.dispose();
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
      title: "TV Subscription",
      children: [
        const SizedBox(height: 10),
        Column(
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
                    Row(
                      children: [
                        Text(
                          "Select Operator",
                          style: fadeTextStyle(fsize: 16, context).copyWith(
                            color: customColor(context).withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "*",
                          style: fadeTextStyle(fsize: 20, context).copyWith(
                            color: customColor(context).withRed(255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                        onTap: () async {
                          selectCable(
                            context,
                            cables,
                            _selectedPlanLabel,
                            (value) async {
                              if (value != null) {
                                setState(() {
                                  _selectedPlanLabel = value;
                                });
                                Navigator.pop(context);
                                loading(context);

                                if (_selectedPlanLabel !=
                                        "Choose a Cable plan" &&
                                    _selectedPlanLabel != "") {
                                  cableData = await fetchCablesPackages(
                                      _selectedPlanLabel);
                                  setState(() {
                                    _selectedPackageLabel = "Choose a package";
                                  });
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  return;
                                }
                                Navigator.pop(context);
                                return;
                              }
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _selectedPlanLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: fadeTextStyle(context).copyWith(
                                  color: _selectedPlanLabel ==
                                          "Choose a Cable plan"
                                      ? Colors.grey[500]
                                      : customColor(context),
                                  fontWeight: _selectedPlanLabel ==
                                          "Choose a Cable plan"
                                      ? null
                                      : FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_drop_up_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Select Package",
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
                          if (_selectedPlanLabel == "Choose a Cable plan" ||
                              cableData.isEmpty) {
                            showSnackBar(
                                context, "Select cable plan to proceed");
                            return;
                          }
                          tap(String pckg, double? amount) {
                            setState(() {
                              cablePrice = amount;
                              _selectedPackageLabel = pckg;
                            });
                          }

                          customDialogBox(
                            context,
                            CustomDialogPackage(
                              data: cableData,
                              heading: "Choose a Package",
                              selectedPackage: _selectedPackageLabel,
                              tap: tap,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _selectedPackageLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: fadeTextStyle(context).copyWith(
                                  color: _selectedPackageLabel ==
                                          "Choose a package"
                                      ? Colors.grey[500]
                                      : customColor(context),
                                  fontWeight: _selectedPackageLabel ==
                                          "Choose a package"
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
                      "Smart Card Number",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    InputFormField(
                      controller: smartCardNumber,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        String? smartCardNumberValidator(String provider) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the smart card number';
                          }

                          int expectedLength;

                          switch (provider) {
                            case 'GOtv':
                            case 'DStv':
                              expectedLength = 10;
                              break;
                            case 'StarTimes':
                              expectedLength = 11;
                              break;
                            default:
                              return 'Unknown provider';
                          }

                          if (value.trim().length != expectedLength) {
                            return 'Smart card number must be $expectedLength digits long for $provider';
                          }

                          return null;
                        }

                        if (_selectedPackageLabel != "Choose a package") {
                          return smartCardNumberValidator(_selectedPlanLabel);
                        }
                        return null;
                      },
                    ),
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
            InkWell(
              onTap: () {
                if (_selectedPlanLabel == "Choose a Cable plan") {
                  showSnackBar(context, "Please select a cable plan");
                  return;
                }
                if (_selectedPackageLabel == "Choose a package") {
                  showSnackBar(context, "Please select a package");
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  customDialogBox(
                    context,
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 320,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 50),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipOval(
                                  child: Icon(
                                    Icons.error_sharp,
                                    size: 80,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: customColor(context),
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 17,
                                    color: customColor(context),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Confirm Transaction",
                            style: fadeTextStyle(
                              context,
                              fsize: 20,
                            ).copyWith(
                              color: customColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Operator:",
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                              Text(
                                _selectedPlanLabel,
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Package:",
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                              const SizedBox(width: 100),
                              Expanded(
                                child: Text(
                                  _selectedPackageLabel,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.aBeeZee().fontFamily,
                                    fontSize: 14,
                                    color: customColor(context),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Smart Card:",
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                              Text(
                                smartCardNumber.text,
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount:",
                                style: fadeTextStyle(
                                  context,
                                ).copyWith(color: customColor(context)),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: format.currencySymbol,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: cablePrice.toString(),
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.aBeeZee().fontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: 60,
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
                                  "Complete",
                                  style: fadeTextStyle(context).copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
        ),
      ],
    );
  }
}

selectCable(
  BuildContext context,
  List<String> cables,
  String selectedCable,
  Function(String? value) onChange,
) {
  customDialogBox(
    context,
    Container(
      padding: const EdgeInsets.all(20),
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Cable Operator",
            style: fadeTextStyle(fsize: 16, context).copyWith(
              color: customColor(context).withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cables.length,
              itemBuilder: (context, index) {
                final cable = cables[index];
                return RadioListTile(
                  value: cable,
                  groupValue: selectedCable,
                  onChanged: onChange,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    cable,
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      color:
                          selectedCable == cable ? customColor(context) : null,
                      fontWeight:
                          selectedCable == cable ? FontWeight.bold : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
