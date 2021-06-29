import 'package:flutter/material.dart';

Widget loading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget error(String error) {
  return Container(
    child: Center(
      child: Text(
        error,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}
