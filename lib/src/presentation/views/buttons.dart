import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/exit.dart';

/// An [ElevatedButton] whose styling signifies that its action is dangerous in some way.
class DangerButton extends ElevatedButton {
  DangerButton({
    super.key,
    this.active = true,
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
           backgroundColor: WidgetStateProperty.all<Color>(
             active ? Colors.red.shade900 : Colors.grey,
           ),
           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
             RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(18.0),
               side: BorderSide(
                 color: active ? Colors.red.shade900 : Colors.grey,
               ),
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

  final bool active;
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

class RefreshButton extends StatelessWidget {
  RefreshButton({super.key, required this.onRefresh});

  final Color backgroundColour = Colors.blue.shade900;

  final void Function()? onRefresh;

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
          if (onRefresh != null) {
            onRefresh!();
          }
        },
        icon: const Icon(Symbols.refresh),
      ),
    );
  }
}

// TODO move to a file with tactical widgets
class FireTorpedoesButton extends StatelessWidget {
  const FireTorpedoesButton({
    super.key,
    required this.data,
    required this.remainingTorpedoes,
    required this.send,
    required this.setRemainingTorpedoes,
  });

  final Map<String, dynamic> data;

  final int remainingTorpedoes;

  final void Function(String) send;

  final void Function(int) setRemainingTorpedoes;

  void firePhotonTorpedoes() {
    debugPrint('\nFiring photon torpedoes!');
    send('fire_torpedoes');
  }

  bool get torpedoesAvailable => remainingTorpedoes > 0;

  @override
  Widget build(BuildContext context) {
    String displayValue;

    try {
      String key = 'torpedoes_remaining';
      if (data.containsKey(key)) {
        setRemainingTorpedoes(data[key]);
      }

      displayValue = remainingTorpedoes.toString();
    } on FormatException {
      displayValue = 'Unknown';
    }

    return SizedBox(
      height: 100,
      child: DangerButton(
        active: remainingTorpedoes > 0,
        context: () => context,
        text: 'Fire Photon Torpedoes\n($displayValue remaining)',
        onPressed: torpedoesAvailable ? firePhotonTorpedoes : null,
      ),
    );
  }
}
