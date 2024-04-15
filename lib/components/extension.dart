import 'package:flutter/material.dart';

extension ThemeControl on BuildContext {
  ThemeData get theme => Theme.of(this);
}
