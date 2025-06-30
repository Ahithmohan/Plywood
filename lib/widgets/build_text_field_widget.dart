import 'package:flutter/material.dart';

class BuildTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon? icon;
  final String? Function(String?)? validator;

  const BuildTextFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.validator,
    this.icon,
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
                style: const TextStyle(color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                  icon: icon,
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
