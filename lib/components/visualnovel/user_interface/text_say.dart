import 'package:flutter/material.dart';

class Say {
  /// List of TextSpans to be shown in a TalkDialog.
  /// Example:
  /// ```dart
  /// [
  ///   TextSpan(text: 'New'),
  ///   TextSpan(text: ' item ', style: TextStyle(color: Colors.red)),
  ///   TextSpan(text: 'unlocked!'),
  /// ]
  /// ```
  final List<TextSpan> text;
  final BoxDecoration? boxDecoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? background;
  final Widget? header;
  final Widget? bottom;

  /// How long each character takes to be shown, in milliseconds.
  /// Defaults to 50.
  final int? speed;

  /// Create a text animation to be shown inside `TalkDialog.show`
  Say({
    required this.text,
    this.boxDecoration,
    this.padding,
    this.margin,
    this.background,
    this.header,
    this.bottom,
    this.speed,
  });
}
