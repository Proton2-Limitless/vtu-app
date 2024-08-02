import 'package:flutter/material.dart';
import 'package:vtu_client/persistence.dart';
import 'package:vtu_client/screens/home.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/screens/register.dart';
import 'package:vtu_client/theme.dart';
import 'package:vtu_client/widget/register/otp.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await TokenPersistence().clearTokens();
  final token = await TokenPersistence().getToken();
  final email = await TokenPersistence().getEmail();
  final otp = await TokenPersistence().getOtpVerification();

  runApp(MyApp(
    token: token,
    email: email,
    otp: otp,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.token,
    this.email,
    this.otp,
  });

  final String? token;
  final String? email;
  final String? otp;

  @override
  Widget build(BuildContext context) {
    bool isTokenExpired = false;
    if (token != null) {
      isTokenExpired = JwtDecoder.isExpired(token!);
    }

    Widget initialScreen() {
      if (token == null && email != null && otp == null) {
        return OTP(email: email!);
      } else if (token == null && email == null) {
        return const Register();
      } else if (token != null && !isTokenExpired) {
        return const Home();
      }
      return const Login();
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: Scaffold(
        body: initialScreen(),
      ),
    );
  }
}
