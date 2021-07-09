import 'package:example/routes/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';

void main() {
  DartVLC.initialize();
  runApp(Routes());
}
