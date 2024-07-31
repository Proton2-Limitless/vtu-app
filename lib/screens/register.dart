import 'package:flutter/material.dart';
import 'package:vtu_client/widget/register/register_screen.dart';
import 'package:vtu_client/widget/register/welcome_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String next = "WelcomeScreen";
  void onPress() {
    setState(() {
      next = "RegisterScreen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget registerActivescreen;

    if (next == "RegisterScreen") {
      registerActivescreen = RegisterScreen();
    } else {
      registerActivescreen = Welcome(onPress: onPress);
    }

    return registerActivescreen;
  }
}
