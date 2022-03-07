import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notepad/pages/home_page.dart';
import 'package:notepad/pages/new_files.dart';
import 'package:notepad/pages/trash_page.dart';

class RouterGenerator {
  static generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
    switch (settings.name) {
      case "/trash":
        return MaterialPageRoute(builder: (context)=>TrashPAge());
    }
  }
}
