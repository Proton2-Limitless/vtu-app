import 'package:flutter/material.dart';
import 'package:vtu_client/widget/airtime/service_widget.dart';

class Deposit extends StatelessWidget {
  const Deposit({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceWidget(
      title: "Deposit",
      children: [],
      noBeneficiary: true,
    );
  }
}
