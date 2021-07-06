import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.maxLength = 250,
      this.hint,
      this.validator,
      this.type,
      this.onChanged,
      this.prefixIcon,
      this.isPassword = false,
      this.action = TextInputAction.next});

  final TextInputAction action;
  final String hint;
  final TextInputType type;
  final int maxLength;
  final bool isPassword;
  final Function onChanged, validator;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isPassword,
      validator: validator,
      keyboardType: type,
      textInputAction: action,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.all(10),
        //errorText: error,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
