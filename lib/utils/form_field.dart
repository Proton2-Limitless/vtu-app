import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    required this.validator,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String? value) validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
