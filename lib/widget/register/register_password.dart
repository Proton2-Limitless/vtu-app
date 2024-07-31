import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import 'package:vtu_client/widget/register/register_pin.dart';

class RegisterPassword extends StatefulWidget {
  const RegisterPassword({super.key, required this.bioInfoReg});

  final Map<String, String> bioInfoReg;

  @override
  State<RegisterPassword> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;

    Map<String, String> bioPasswordReg = {};

    void nextRegisterScreen() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        bioPasswordReg = {
          ...widget.bioInfoReg,
          "enteredPassword": _passwordController.text,
        };
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterPin(bioPasswordReg: bioPasswordReg),
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
                              "Set your password",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 36,
                                  ),
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Password",
                              keyboardType: TextInputType.name,
                              icon: Icons.password,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                } else if (!RegExp(
                                        r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least one letter, one number, and one special character';
                                }
                                return null;
                              },
                              controller: _passwordController,
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Confirm Password",
                              keyboardType: TextInputType.name,
                              icon: Icons.password_outlined,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your password';
                                } else if (_passwordController.text !=
                                    value.trim()) {
                                  return "Password doesn't match";
                                }
                                return null;
                              },
                              controller: _confirmPasswordController,
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
