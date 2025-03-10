import 'package:flutter/material.dart';

class BridgeStationTile extends StatelessWidget {
  const BridgeStationTile({
    super.key,
    required this.title,
    required this.children,
  });

  /// A name that will appear at the top of the tile.
  final String title;

  /// The buttons to display within this tile.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: ListView(shrinkWrap: true, children: children),
        ),
      ),
    );
  }
}
