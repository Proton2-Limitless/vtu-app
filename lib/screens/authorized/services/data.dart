import 'package:flutter/material.dart';
import 'package:vtu_client/model/data_types.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/form_field.dart';
import 'package:vtu_client/utils/modal.dart';
import 'package:vtu_client/utils/show_custom_dialog.dart';
import 'package:vtu_client/widget/airtime/select_airtime.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final _formKey = GlobalKey<FormState>();
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  // Contact? _contact;
  String? selectedNumber;
  String? selectedFullname;
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController beneficiary = TextEditingController();

  double? dataPrice;
  String _selectedPlanLabel = "Choose a data plan";
  bool _isDataSelect = false;

  String airtime = "";
  String? networkImage;
  Color? networkColor;

  @override
  void dispose() {
    phoneNumber.dispose();
    beneficiary.dispose();
    super.dispose();
  }

  List<DataType> listOfDataType = [];

  bool isBeneficiary = false;
  void addBeneficiary() {
    setState(() {
      isBeneficiary = !isBeneficiary;
    });
  }

  @override
  Widget build(BuildContext context) {
    selectNetwork(String name, String imageStr, Color color) async {
      setState(() {
        airtime = name;
        networkImage = imageStr;
        networkColor = color;
      });
      loading(context);
      listOfDataType = await fetchDatasPackages(airtime);
      if (context.mounted) {
        Navigator.pop(context);
      }
      return;
    }

    return ServiceWidget(
      title: "Buy Data",
      children: [
        const SizedBox(height: 10),
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
                      chageIcon() {
                        setState(() {
                          _isDataSelect = false;
                        });
                        Navigator.of(context).pop();
                      }

                      tap(String value, double price) {
                        setState(() {
                          _selectedPlanLabel = value;
                          dataPrice = price;
                        });
                        chageIcon();
                      }

                      setState(() {
                        _isDataSelect = true;
                      });
                      customModal(
                        context,
                        listOfDataType,
                        tap,
                        _selectedPlanLabel,
                        chageIcon,
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
                              color: _selectedPlanLabel == "Choose a data plan"
                                  ? Colors.grey[500]
                                  : customColor(context),
                              fontWeight:
                                  _selectedPlanLabel == "Choose a data plan"
                                      ? null
                                      : FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          _isDataSelect
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined,
                        ),
                      ],
                    ),
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
            if (_selectedPlanLabel == "Choose a data plan") {
              showSnackBar(context, "Please select data plan");
              return;
            }
            if (_formKey.currentState!.validate()) {
              showCustomDialog(
                context,
                image: networkImage!,
                airtime: airtime,
                amount: dataPrice!.toStringAsFixed(2),
                phoneNumber: phoneNumber.text,
                airtimeColor: networkColor!,
                description: _selectedPlanLabel,
                height: 350,
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
        const SizedBox(height: 10),
      ],
    );
  }
}
