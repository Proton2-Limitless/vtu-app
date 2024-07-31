import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/model/usertype.dart';
import 'package:vtu_client/persistence.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/constants.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/widget/register/otp.dart';
import 'package:http/http.dart' as http;

class UserType extends StatefulWidget {
  const UserType({super.key, required this.bioPinReg});

  final Map<String, String> bioPinReg;

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  String selectedType = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Map<String, String> bioTypeReg = {};

    Future<void> nextRegisterScreen() async {
      try {
        if (selectedType != "") {
          bioTypeReg = {
            ...widget.bioPinReg,
            "role": selectedType,
          };

          setState(() {
            _isLoading = true;
          });
          final response = await http.post(
            Uri.parse('$serverUrl/user/register'),
            headers: {
              "Content-type": "application/json",
            },
            body: jsonEncode({
              "role": bioTypeReg["role"],
              "email": bioTypeReg["enteredEmail"],
              "full_name": bioTypeReg["enteredFullname"],
              "password": bioTypeReg["enteredPassword"],
              "pin": bioTypeReg["enteredPin"],
              "phone_number": bioTypeReg["enteredNumber"],
            }),
          );

          await TokenPersistence().setEmail(bioTypeReg["enteredEmail"]!);
          setState(() {
            _isLoading = false;
          });

          if (jsonDecode(response.body)["status"] != 201) {
            showSnackBar(context, "something bad occur");
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTP(email: bioTypeReg["enteredEmail"]!),
            ),
          );
        } else {
          showSnackBar(context, "please select the above types");
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Let's sign you up",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How would you like to join us",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 10),
            ...usertypes.map(
              (userTy) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = userTy.usertype;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      // height: height * 0.16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: selectedType == userTy.usertype
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                          horizontal: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "As a ${userTy.usertype}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                selectedType == userTy.usertype
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            Text(
                              userTy.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (_isLoading) const CircularProgressIndicator.adaptive(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onPress: nextRegisterScreen,
                    text: "Get OTP",
                    height: height * 0.07,
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
            )
          ],
        ),
      ),
    );
  }
}
