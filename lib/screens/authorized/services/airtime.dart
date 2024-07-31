import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/form_field.dart';
import 'package:vtu_client/utils/show_custom_dialog.dart';
import 'package:vtu_client/widget/airtime/select_airtime.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  final _formKey = GlobalKey<FormState>();
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  // Contact? _contact;
  String? selectedNumber;
  String? selectedFullname;
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController beneficiary = TextEditingController();

  String airtime = "";
  String? networkImage;
  Color? networkColor;

  selectNetwork(String name, String imageStr, Color color) {
    setState(() {
      airtime = name;
      networkImage = imageStr;
      networkColor = color;
    });
  }

  @override
  void dispose() {
    phoneNumber.dispose();
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
      title: "Airtime",
      children: [
        SelectNetwork(
          selectNetwork: selectNetwork,
        ),
        const SizedBox(height: 10),
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
                  "Enter Number",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                InputFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  suffixIcon: SizedBox(
                    width: 125,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: customColor(context),
                      ),
                      onPressed: () async {
                        Contact? contact = await _contactPicker.selectContact();

                        if (contact != null) {
                          setState(() {
                            // _contact = contact;
                            List<String>? phoneNumbers = contact.phoneNumbers;
                            selectedNumber =
                                phoneNumbers?[0] ?? 'Nothing selected';
                            selectedFullname = contact.fullName;
                            phoneNumber.text = selectedNumber!;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            "CONTACTS",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  validator: (value) {
                    const pattern = r'^(\+234|0)(91|70|80|90|81)\d{8}$';
                    final regExp = RegExp(pattern);

                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!regExp.hasMatch(value.trim())) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Text(
                      "Network Verification: ",
                      style: TextStyle(
                        color: customColor(context).withOpacity(0.6),
                      ),
                    ),
                    const Text(
                      "Verified",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    const Icon(
                      Icons.check_box_rounded,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
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
                      return 'Please enter Amount';
                    } else if (int.parse(value.trim()) < 100) {
                      return 'Enter amount greater than 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      "Amount To Pay: ",
                      style: TextStyle(
                        color: customColor(context).withOpacity(0.6),
                      ),
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: "240.00",
                            style: TextStyle(
                              fontFamily: GoogleFonts.aBeeZee().fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "20% Off when you purchase"
                    " a VTU airtime from us!!!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
            if (airtime.isEmpty) {
              showSnackBar(context, "Please select network type");
              return;
            }
            if (_formKey.currentState!.validate()) {
              showCustomDialog(
                context,
                image: networkImage!,
                airtime: airtime,
                amount: amount.text,
                phoneNumber: phoneNumber.text,
                airtimeColor: networkColor!,
                height: 320,
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
        const SizedBox(height: 10)
      ],
    );
  }
}
