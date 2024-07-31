import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vtu_client/persistence.dart';
import 'package:vtu_client/screens/login.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/constants.dart';
import 'package:vtu_client/utils/custom_button.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class OTP extends StatefulWidget {
  const OTP({super.key, required this.email});

  final String email;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  int _start = 0;
  bool _isResendButtonDisabled = false;
  Timer? _timer;
  bool _isLoading = false;

  String otpCode = "";

  void resendOtp() {
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> verifyEmail() async {
    // /validate-registration-otp
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.put(
        Uri.parse('$serverUrl/user/validate-registration-otp'),
        headers: {
          "Content-type": "application/json",
        },
        body: jsonEncode({
          "token": otpCode,
          "email": widget.email,
        }),
      );

      await TokenPersistence()
          .setOtpVerification(jsonDecode(response.body)["message"]);
      setState(() {
        _isLoading = false;
      });

      showSnackBar(context, jsonDecode(response.body)["message"]);
      if (response.statusCode != 200) return;
      await Future.delayed(const Duration(milliseconds: 2500), () {});
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void startTimer() {
    _start = 60;
    _isResendButtonDisabled = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _isResendButtonDisabled = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OTP Verification",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "Enter the verification number "
                    "that was sent to your email",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // SizedBox(height: constraints.maxHeight * 0.1),
                  const SizedBox(height: 60),
                  Center(
                    child: Pinput(
                      errorText: "",
                      length: 4,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    onPress: _isResendButtonDisabled ? () => null : verifyEmail,
                    text: "Verify",
                    height: height,
                    width: width,
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator.adaptive()),
                  const SizedBox(height: 50),
                  Center(
                    child: Column(
                      children: [
                        if (_start != 0)
                          Text(
                            "Resend OTP in $_start seconds",
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        TextButton(
                          onPressed: _isResendButtonDisabled ? null : resendOtp,
                          child: Text(
                            "Resend Otp",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: _isResendButtonDisabled
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
