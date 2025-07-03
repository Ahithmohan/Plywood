import 'package:flutter/material.dart';

class BuildTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  final String hintText;
  final Icon? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const BuildTextFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.validator,
    this.icon,
    this.keyboardType,
    this.suffixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (FormFieldState field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xff131D4F).withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: field.hasError ? Colors.red : Colors.grey,
                  width: field.hasError
                      ? 1.0
                      : 1.0, // Increased border width on error
                ),
              ),
              child: TextField(
                focusNode: focusNode,
                style: const TextStyle(color: Colors.white),
                keyboardType: keyboardType,
                controller: controller,
                decoration: InputDecoration(
                  icon: icon,
                  suffix: suffixIcon,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none, // Removed border from TextFormField
                ),
                onChanged: (value) {
                  field.didChange(value);
                },
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
