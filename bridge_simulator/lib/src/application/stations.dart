import 'package:flutter/material.dart';

sealed class BridgeStation extends StatelessWidget {
  const BridgeStation._({super.key});

  String get stationName => runtimeType.toString().replaceFirst('_', '');

  const factory BridgeStation.viewscreen({Key? key}) = _Viewscreen;

  const factory BridgeStation.ops({Key? key}) = _Ops;

  const factory BridgeStation.conn({Key? key}) = _Conn;

  const factory BridgeStation.captainChair({Key? key}) = _CaptainChair;

  const factory BridgeStation.tactical({Key? key}) = _Tactical;

  const factory BridgeStation.scienceI({Key? key}) = _ScienceI;

  const factory BridgeStation.scienceII({Key? key}) = _ScienceII;

  const factory BridgeStation.missionOps({Key? key}) = _MissionOps;

  const factory BridgeStation.environment({Key? key}) = _Environment;

  const factory BridgeStation.engineering({Key? key}) = _Engineering;

  // TODO remove placeholderBuildMethod() once all subtypes have implemented build()
  Widget placeholderBuildMethod(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          stationName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

final class _Viewscreen extends BridgeStation {
  const _Viewscreen({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return placeholderBuildMethod(context);
  }
}

final class _Ops extends BridgeStation {
  const _Ops({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _Conn extends BridgeStation {
  const _Conn({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _CaptainChair extends BridgeStation {
  const _CaptainChair({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _Tactical extends BridgeStation {
  const _Tactical({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _ScienceI extends BridgeStation {
  const _ScienceI({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _ScienceII extends BridgeStation {
  const _ScienceII({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _MissionOps extends BridgeStation {
  const _MissionOps({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _Environment extends BridgeStation {
  const _Environment({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class _Engineering extends BridgeStation {
  const _Engineering({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}
