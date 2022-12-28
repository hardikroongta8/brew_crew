import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(width: 0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.brown, width: 2),
    borderRadius: BorderRadius.circular(15)
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15)
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15)
  ),
);