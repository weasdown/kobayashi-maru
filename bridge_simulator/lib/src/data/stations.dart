import 'package:flutter/material.dart';

/// The various stations and consoles around the Galaxy-class bridge.
enum BridgeStationOption {
  viewscreen(widget: Viewscreen()),
  ops(widget: Ops()),
  conn(widget: Conn()),
  captainChair(widget: CaptainChair()),
  tactical(widget: Tactical()),
  scienceI(widget: ScienceI()),
  scienceII(widget: ScienceII()),
  missionOps(widget: MissionOps()),
  environment(widget: Environment()),
  engineering(widget: Engineering());

  const BridgeStationOption({required this.widget});

  final Widget widget;
}

sealed class BridgeStation extends StatelessWidget {
  const BridgeStation({super.key});

  factory BridgeStation.fromOption({required BridgeStationOption station}) {
    return switch (station) {
      // TODO: Handle this case.
      BridgeStationOption.viewscreen => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.ops => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.conn => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.captainChair => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.tactical => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.scienceI => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.scienceII => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.missionOps => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.environment => throw UnimplementedError(),

      // TODO: Handle this case.
      BridgeStationOption.engineering => throw UnimplementedError(),
    };
  }
}

final class Viewscreen extends BridgeStation {
  const Viewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final class Ops extends StatelessWidget {
  const Ops({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class Conn extends StatelessWidget {
  const Conn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class CaptainChair extends StatelessWidget {
  const CaptainChair({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class Tactical extends StatelessWidget {
  const Tactical({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class ScienceI extends StatelessWidget {
  const ScienceI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class ScienceII extends StatelessWidget {
  const ScienceII({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class MissionOps extends StatelessWidget {
  const MissionOps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class Environment extends StatelessWidget {
  const Environment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final class Engineering extends StatelessWidget {
  const Engineering({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
