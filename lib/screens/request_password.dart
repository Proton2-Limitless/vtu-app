import 'dart:convert';
// import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/screens/password_reset.dart';
import 'package:vtu_client/screens/register.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/constants.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import "package:http/http.dart" as http;

class RequestPassword extends StatefulWidget {
  const RequestPassword({super.key});

  @override
  State<RequestPassword> createState() => _RequestPasswordState();
}

class _RequestPasswordState extends State<RequestPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> forgetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);

      final response = await http.put(
        Uri.parse("$serverUrl/user/request-password-reset"),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode({
          "email": _emailController.text,
        }),
      );

      if (jsonDecode(response.body)["status"] != 200) {
        showSnackBar(context, "networkProbs");
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        return;
      }

      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PasswordResetScreen(
            activity: "Password",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Forget Password",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "Enter your email address below to rest your password",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      controller: _emailController,
                    ),
                    SizedBox(height: height * 0.12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPress: () {
                            forgetPassword(context);
                          },
                          text: "Proceed",
                          height: height * 0.07,
                          width: width,
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Not your account? ",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontStyle: GoogleFonts.latoTextTheme()
                                      .bodyLarge!
                                      .fontStyle,
                                ),
                              ),
                              TextSpan(
                                text: "Sign up",
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
                                        builder: (context) => const Register(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
