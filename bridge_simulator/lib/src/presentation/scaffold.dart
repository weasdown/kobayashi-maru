import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'buttons.dart';

class DefaultScaffold extends Scaffold {
  DefaultScaffold({
    super.key,
    super.body,
    void Function()? onRefresh,
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
  }) : super(
         backgroundColor: Colors.black,
         appBar: defaultAppBar(actions: [RefreshButton(onRefresh: onRefresh)]),
       );
}

PreferredSizeWidget defaultAppBar({List<Widget>? actions}) => PreferredSize(
  preferredSize: const Size.fromHeight(50),
  child: DragToMoveArea(
    child: AppBar(backgroundColor: Colors.black, actions: actions),
  ),
);
