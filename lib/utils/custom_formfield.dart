import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.label,
    required this.icon,
    required this.validator,
    required this.controller,
    required this.keyboardType,
    this.isPassword,
    required this.sizedbox,
  });

  final String label;
  final TextInputType keyboardType;
  final IconData icon;
  final String? Function(String? value) validator;
  final TextEditingController controller;
  final bool? isPassword;
  final double sizedbox;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool canClickIcon;
  var obscureText = false;

  @override
  void initState() {
    canClickIcon = widget.isPassword != null ? true : false;
    if (canClickIcon) {
      obscureText = true;
    }
    super.initState();
  }

  onPressed() {
    if (canClickIcon) {
      setState(() {
        obscureText = !obscureText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.sizedbox,
        ),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextFormField(
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isPassword != null
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.remove_red_eye),
                  )
                : null,
          ),
          obscureText: obscureText,
          validator: widget.validator,
          controller: widget.controller,
        ),
      ],
    );
  }
}
