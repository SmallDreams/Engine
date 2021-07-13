import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*

API REFERENCE: https://api.flutter.dev/flutter/services/LogicalKeyboardKey-class.html

*/

class CounterShortcuts extends StatelessWidget {
  const CounterShortcuts({
    Key? key,
    @required this.child,
    @required this.onIncrementDetected,
    @required this.onDecrementDetected,
  }) : super(key: key);
  final Widget? child;
  final VoidCallback? onIncrementDetected;
  final VoidCallback? onDecrementDetected;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        incrementKeySet: IncrementIntent(),
        decrementKeySet: DecrementIntent(),
      },
      actions: {
        IncrementIntent:
            CallbackAction(onInvoke: (e) => onIncrementDetected!.call()),
        DecrementIntent:
            CallbackAction(onInvoke: (e) => onDecrementDetected!.call()),
      },
      child: child!,
    );
  }
}

final incrementKeySet = LogicalKeySet(
  LogicalKeyboardKey.control, // Replace with control on Windows
);
final decrementKeySet = LogicalKeySet(
  LogicalKeyboardKey.space,
);

class IncrementIntent extends Intent {}

class DecrementIntent extends Intent {}
