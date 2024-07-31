import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class CustomizedFormInput extends StatelessWidget {
  const CustomizedFormInput({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscuretext,
    required this.validator,
    required this.keyboardType,
    required this.label,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String? value) validator;
  final TextInputType keyboardType;
  final String label;
  final bool? obscuretext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: fadeTextStyle(fsize: 16, context).copyWith(
            color: customColor(context).withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 18,
            color: customColor(context),
          ),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
              horizontal: 20.0,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
