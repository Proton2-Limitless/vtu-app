import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/widget/airtime/beneficiary.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
    required this.title,
    required this.children,
    this.noBeneficiary = false,
  });

  final String title;
  final bool noBeneficiary;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: fadeTextStyle(fsize: 20, context).copyWith(
            color: secondaryColor(context),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace_sharp,
            color: secondaryColor(context),
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              !noBeneficiary ? const Beneficiaries() : const SizedBox(),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
