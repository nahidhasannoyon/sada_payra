import 'package:flutter/material.dart';

InputDecoration kTextFieldWithIconDecoration(String? hint, IconData iconData) {
  return InputDecoration(
    filled: true,
    fillColor: const Color.fromRGBO(194, 231, 231, 1),
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color.fromRGBO(175, 175, 175, 1),
      fontFamily: 'MADE-Mellow',
      fontSize: 20,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Color.fromRGBO(11, 149, 149, 1),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Color.fromRGBO(11, 149, 149, 1),
      ),
    ),
    suffixIcon: Icon(
      iconData,
      color: const Color.fromRGBO(7, 128, 128, 1),
    ),
  );
}

InputDecoration kTextFieldDecoration(String? hint) {
  return InputDecoration(
    filled: true,
    fillColor: const Color.fromRGBO(194, 231, 231, 1),
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color.fromRGBO(175, 175, 175, 1),
      fontFamily: 'MADE-Mellow',
      fontSize: 20,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Color.fromRGBO(11, 149, 149, 1),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Color.fromRGBO(11, 149, 149, 1),
      ),
    ),
  );
}
