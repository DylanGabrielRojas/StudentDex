import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String text;
  final bool hide;
  final TextEditingController controllerParam;
  const TextFieldComponent({super.key, required this.text, required this.hide, required this.controllerParam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: TextFormField(
        decoration:  InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
        ),
        obscureText: hide,
        controller: controllerParam,
      ),
    );
  }
}
          