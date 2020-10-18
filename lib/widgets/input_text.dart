import 'package:flutter/material.dart';

class ArrowLogInputText extends StatelessWidget {
  final String type;
  final TextEditingController controller;

  ArrowLogInputText({
    @required this.type,
    @required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white
      ),
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Theme.of(context).cursorColor,
      decoration: InputDecoration(
        hintText: 'Enter a $type',
        hintStyle: TextStyle(
          color: Colors.white54
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a $type';
        }
        return null;
      },
    );
  }
}