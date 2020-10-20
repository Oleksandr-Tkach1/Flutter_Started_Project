import 'package:flutter/material.dart';

class WidgetsStyle {

  static InputDecoration textFieldStyle(String label, String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      prefixStyle: TextStyle(color: Colors.grey[800]),
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      labelStyle: TextStyle(color: Colors.grey[800]),
      focusColor: Colors.grey[800],
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
        borderSide: new BorderSide(
          color: Colors.grey[800],
          width: 1.0,
        ),
      ),
      disabledBorder: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
        borderSide: new BorderSide(
          color: Colors.grey[800],
          width: 1.0,
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
        borderSide: new BorderSide(
          color: Colors.grey[800],
          width: 1.0,
        ),
      ),
      hintText: hint,
      labelText: label,);
  }
}