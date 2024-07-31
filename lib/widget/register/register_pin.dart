import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import 'package:vtu_client/widget/register/user_type.dart';

class RegisterPin extends StatefulWidget {
  const RegisterPin({super.key, required this.bioPasswordReg});

  final Map<String, String> bioPasswordReg;

  @override
  State<RegisterPin> createState() => _RegisterPinState();
}

class _RegisterPinState extends State<RegisterPin> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;

    Map<String, String> bioPinReg = {};

    void nextRegisterScreen() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        bioPinReg = {
          ...widget.bioPasswordReg,
          "enteredPin": _pinController.text,
        };
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserType(bioPinReg: bioPinReg),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Let's sign you up",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Set your pin",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "your pin is a four digit"
                              " numerical code that is used"
                              " to authenticate every transaction",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Pin",
                              keyboardType: TextInputType.number,
                              icon: Icons.lock,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your pin';
                                } else if (value.length < 4 ||
                                    value.length > 4) {
                                  return 'pin must be 4 characters long';
                                }
                                return null;
                              },
                              controller: _pinController,
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Confirm Pin",
                              keyboardType: TextInputType.number,
                              icon: Icons.lock,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your pin';
                                } else if (_pinController.text !=
                                    value.trim()) {
                                  return "pin doesn't match";
                                }
                                return null;
                              },
                              controller: _confirmPinController,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CustomButton(
                        onPress: nextRegisterScreen,
                        text: "Next",
                        height: height,
                        width: width,
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Have an existing account? ",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontStyle: GoogleFonts.latoTextTheme()
                                    .bodyLarge!
                                    .fontStyle,
                              ),
                            ),
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: GoogleFonts.latoTextTheme()
                                    .bodyLarge!
                                    .fontStyle,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
