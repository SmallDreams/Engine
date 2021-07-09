import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final error;
  UndefinedView({
    this.error,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text("Error"),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Error: $error",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Page not found.")
        ],
      )),
    );
  }
}
