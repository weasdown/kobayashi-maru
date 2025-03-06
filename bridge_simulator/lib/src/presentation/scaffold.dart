import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'buttons.dart';

class DefaultScaffold extends Scaffold {
  DefaultScaffold({
    super.key,
    super.body,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.drawer,
    super.drawerDragStartBehavior,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture,
    super.drawerScrimColor,
    super.endDrawer,
    super.endDrawerEnableOpenDragGesture,
    super.extendBody,
    super.extendBodyBehindAppBar,
    super.floatingActionButton,
    super.floatingActionButtonAnimator,
    super.floatingActionButtonLocation,
    super.onDrawerChanged,
    super.onEndDrawerChanged,
    super.persistentFooterAlignment,
    super.persistentFooterButtons,
    super.primary,
    super.resizeToAvoidBottomInset,
    super.restorationId,
  }) : super(backgroundColor: Colors.black, appBar: defaultAppBar);
}

final PreferredSizeWidget defaultAppBar = PreferredSize(
  preferredSize: const Size.fromHeight(50),
  child: DragToMoveArea(
    child: AppBar(
      backgroundColor: Colors.black,
      actions: [RefreshButton(), exitButton],
    ),
  ),
);
