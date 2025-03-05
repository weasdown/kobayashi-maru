import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

void exitCleanly() {
  debugPrint('Exiting cleanly');
  exit(0);
}

/// An [ElevatedButton] whose styling signifies that its action is dangerous in some way.
class DangerButton extends ElevatedButton {
  DangerButton({
    super.key,
    required BuildContext Function() context,
    required super.onPressed,
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    super.autofocus,
    super.clipBehavior,
    super.focusNode,
    super.onFocusChange,
    super.onHover,
    super.onLongPress,
    super.statesController,
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
           style: Theme.of(context()).textTheme.headlineMedium!.copyWith(
             color: Colors.white,
             fontSize: fontSize,
             fontWeight: fontWeight,
           ),
         ),
       );

  static final Color colour = Colors.red.shade900;
}
