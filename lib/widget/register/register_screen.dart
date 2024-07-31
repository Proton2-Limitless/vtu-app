import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import 'package:vtu_client/widget/register/register_password.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _enteredFullname = TextEditingController();
  final _enteredNumber = TextEditingController();
  final _enteredEmail = TextEditingController();

  @override
  void dispose() {
    _enteredFullname.dispose();
    _enteredNumber.dispose();
    _enteredEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;

    Map<String, String> bioInfoReg = {};

    void nextRegisterScreen() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        bioInfoReg = {
          "enteredFullname": _enteredFullname.text,
          "enteredNumber": _enteredNumber.text,
          "enteredEmail": _enteredEmail.text,
        };
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterPassword(bioInfoReg: bioInfoReg),
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
                          children: [
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Full name",
                              keyboardType: TextInputType.name,
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your full name';
                                }
                                if (!RegExp(r'^[a-zA-Z]+\s[a-zA-Z]+$')
                                    .hasMatch(value.trim())) {
                                  return 'Please enter a valid full name';
                                }
                                return null;
                              },
                              controller: _enteredFullname,
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Phone Number",
                              keyboardType: TextInputType.number,
                              icon: Icons.phone,
                              validator: (value) {
                                const pattern = r'^(091|070|080|090|081)\d{8}$';
                                final regExp = RegExp(pattern);

                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              controller: _enteredNumber,
                            ),
                            CustomFormField(
                              sizedbox: height * 0.05,
                              label: "Email",
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.email,
                              validator: (value) {
                                const pattern =
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                final regExp = RegExp(pattern);

                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              controller: _enteredEmail,
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "By registering, I agree to RechargeNow ",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontStyle: GoogleFonts.latoTextTheme()
                                          .bodyLarge!
                                          .fontStyle,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Terms & Conditions and Privacy Policy",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontStyle: GoogleFonts.latoTextTheme()
                                          .bodyLarge!
                                          .fontStyle,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
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
