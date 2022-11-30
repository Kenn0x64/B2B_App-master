import 'package:flutter/material.dart';

abstract class Decoration {
  static dynamic deco(String lt, String ht, IconData ico) {
    return InputDecoration(
      labelText: lt,
      border:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      hintText: ht,
      icon: Icon(ico),
    );
  }
}
