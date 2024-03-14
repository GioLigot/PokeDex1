import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String? hintText;
  final Function(String)? onChanged;
  final double height;
  final String? label;


  const MyTextField({
    super.key,

    required this.controller,
    this.hintText,
    this.onChanged,
    required this.height,
    this.label

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: height, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
          // Optional border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
      ),

    );
  }
}
