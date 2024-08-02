import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/main.dart';
import 'package:vtu_client/model/user_profile.dart';
import 'package:vtu_client/persistence.dart';
import 'package:vtu_client/screens/home.dart';
import 'package:vtu_client/screens/register.dart';
import 'package:vtu_client/screens/request_password.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/constants.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'package:vtu_client/utils/custom_formfield.dart';
import "package:http/http.dart" as http;
import 'package:device_info_plus/device_info_plus.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _enteredEmail = TextEditingController();
  final _enteredPassword = TextEditingController();
  bool _isLoading = false;
  String _deviceID = '';

  Future<void> _getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _deviceID = androidInfo.id;
    });
  }

  bool isBioSet = false;
  bool trackBio = false;

  checkBio() async {
    final bio = await TokenPersistence().getBioAuth() ?? false;
    setState(() {
      trackBio = bio;
    });
    if (bio) {
      final bioVal = await authBio();
      setState(() {
        isBioSet = bioVal;
      });
      if (isBioSet) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    _getDeviceID();
    checkBio();
    super.initState();
  }

  @override
  void dispose() {
    _enteredEmail.dispose();
    _enteredPassword.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      final response = await http.post(
        Uri.parse('$serverUrl/user/login'),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode({
          "email": _enteredEmail.text,
          "password": _enteredPassword.text,
          "device_id": _deviceID
        }),
      );

      final data = jsonDecode(response.body);
      if (data["status"] != 200) {
        showSnackBar(context, data["message"]);
      }

      final jsonProfile = data["profile"];

      UserProfile profile = UserProfile(
        id: jsonProfile["id"],
        fullName: jsonProfile["bio_data"]["full_name"],
        email: jsonProfile["auth"]["email"],
        phoneNumber: jsonProfile["auth"]["phone_number"],
        accountStatus: jsonProfile["account_status"]["status"],
        role: jsonProfile["bio_data"]["role"][0],
      );

      await TokenPersistence().setToken(data["access_token"]);
      final token = await TokenPersistence().getToken();

      await TokenPersistence().setrefreshToken(data["refresh_token"]);
      await TokenPersistence().setProfile(profile);
      _isLoading = false;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyApp(
            token: token,
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Log in",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    CustomFormField(
                      sizedbox: height * 0.007,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _enteredEmail,
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
                        }
                        return null;
                      },
                      controller: _enteredPassword,
                    ),
                    if (_isLoading) const CircularProgressIndicator.adaptive(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RequestPassword(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontStyle:
                              GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPress: () {
                              _login();
                            },
                            text: "Login",
                            height: height * 0.07,
                            width: width,
                          ),
                        ),
                        trackBio
                            ? IconButton(
                                onPressed: () {
                                  checkBio();
                                },
                                icon: Icon(
                                  Icons.fingerprint_sharp,
                                  size: height * 0.07,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Not your account? ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
