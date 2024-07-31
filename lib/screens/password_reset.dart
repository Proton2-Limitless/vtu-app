import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/screens/register.dart';
import 'package:vtu_client/screens/request_password.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/constants.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import "package:http/http.dart" as http;

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key, required this.activity});

  final String activity;

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    showLoadingDialog(context);
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('$serverUrl/user/reset-password'),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode({
          "value": "habeebllah70@gmail.com",
          "token": "444494",
          "password": _passwordController.text
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
          builder: (context) => Login(),
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
                      "Reset ${widget.activity}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    CustomFormField(
                      sizedbox: height * 0.007,
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
                      sizedbox: height * 0.007,
                      label: "Confirm Password",
                      keyboardType: TextInputType.name,
                      icon: Icons.password_outlined,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your password';
                        } else if (_passwordController.text != value.trim()) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                    ),
                    SizedBox(height: height * 0.12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPress: _resetPassword,
                          text: "Reset ${widget.activity}",
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
            )
          ],
        ),
      ),
    );
  }
}
