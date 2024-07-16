import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String textField;
  final TextEditingController controller;

  const CustomTextfield(
      {super.key, required this.textField, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textField, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0x00E5E4E2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
