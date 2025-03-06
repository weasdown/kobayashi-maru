import 'dart:io';

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
           textAlign: TextAlign.center,
           style: Theme.of(context()).textTheme.headlineMedium!.copyWith(
             color: Colors.white,
             fontSize: fontSize,
             fontWeight: fontWeight,
           ),
         ),
       );

  static final Color colour = Colors.red.shade900;
}

Widget exitButton = Padding(
  padding: const EdgeInsets.only(right: 16.0),
  child: CircleAvatar(
    backgroundColor: Colors.red.shade900,
    child: IconButton(
      color: Colors.white,
      onPressed: exitCleanly,
      icon: Icon(Symbols.close),
    ),
  ),
);

class RefreshButton extends StatefulWidget {
  const RefreshButton({super.key});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  final Color backgroundColour = Colors.blue.shade900;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColour),
        ),

        color: Colors.white,
        onPressed: () {
          debugPrint('Refreshing');
          setState(() {});
        },
        icon: const Icon(Symbols.refresh),
      ),
    );
  }
}
