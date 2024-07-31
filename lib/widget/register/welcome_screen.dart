import 'package:flutter/material.dart';
import 'package:vtu_client/utils/custom_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key, required this.onPress});

  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.07;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 230,
                height: 200,
                child: Image.asset(
                  "assets/images/logofull-removebg-preview.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width * 0.75,
                child: Text(
                  "Enjoy secure,"
                  "instant transactions and multiple payment options."
                  "Stay connected effortlessly, anytime, anywhere.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(18),
          child: CustomButton(
            onPress: onPress,
            text: "Start",
            height: height,
            width: width,
          ),
        )
      ],
    );
  }
}
