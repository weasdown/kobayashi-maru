import 'package:flutter/material.dart';
void exitCleanly() {
  debugPrint('Exiting cleanly');
  exit(0);
}

/// An [ElevatedButton] whose styling signifies that its action is dangerous in some way.
class DangerButton extends ElevatedButton {
  DangerButton({
    super.key,
    required BuildContext context,
    required String text,
    required super.onPressed,
  }) : super(
         style: ButtonStyle(
           backgroundColor: WidgetStateProperty.all<Color>(colour),
           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
             RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(18.0),
               side: BorderSide(color: colour),
             ),
           ),
         ),
         child: Text(
           text,
           style: Theme.of(
             context,
           ).textTheme.headlineMedium!.copyWith(color: Colors.white),
         ),
       );

  static final Color colour = Colors.red.shade900;
}
