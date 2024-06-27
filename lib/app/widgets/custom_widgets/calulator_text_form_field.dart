import 'package:flutter/material.dart';

class CalculatorTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  const CalculatorTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                labelText: labelText,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.backspace),
            onPressed: () {
              final text = controller.text;
              if (text.isNotEmpty) {
                final newText = text.substring(0, text.length - 1);
                controller.value =
                 TextEditingValue(
                  text: newText,
                  selection: TextSelection.collapsed(offset: newText.length),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
