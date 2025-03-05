import 'package:flutter/material.dart';

sealed class BridgeStation extends StatelessWidget {
  const BridgeStation._({super.key});

  String get stationName => runtimeType.toString().replaceFirst('_', '');

  const factory BridgeStation.viewscreen({Key? key}) = ViewscreenBridgeStation;

  const factory BridgeStation.ops({Key? key}) = OpsBridgeStation;

  const factory BridgeStation.conn({Key? key}) = ConnBridgeStation;

  const factory BridgeStation.captainChair({Key? key}) =
      CaptainChairBridgeStation;

  const factory BridgeStation.tactical({Key? key}) = TacticalBridgeStation;

  const factory BridgeStation.scienceI({Key? key}) = ScienceIBridgeStation;

  const factory BridgeStation.scienceII({Key? key}) = ScienceIIBridgeStation;

  const factory BridgeStation.missionOps({Key? key}) = MissionOpsBridgeStation;

  const factory BridgeStation.environment({Key? key}) =
      EnvironmentBridgeStation;

  const factory BridgeStation.engineering({Key? key}) =
      EngineeringBridgeStation;

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

final class ViewscreenBridgeStation extends BridgeStation {
  const ViewscreenBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return placeholderBuildMethod(context);
  }
}

final class OpsBridgeStation extends BridgeStation {
  const OpsBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class ConnBridgeStation extends BridgeStation {
  const ConnBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class CaptainChairBridgeStation extends BridgeStation {
  const CaptainChairBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class TacticalBridgeStation extends BridgeStation {
  const TacticalBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class ScienceIBridgeStation extends BridgeStation {
  const ScienceIBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class ScienceIIBridgeStation extends BridgeStation {
  const ScienceIIBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class MissionOpsBridgeStation extends BridgeStation {
  const MissionOpsBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class EnvironmentBridgeStation extends BridgeStation {
  const EnvironmentBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

final class EngineeringBridgeStation extends BridgeStation {
  const EngineeringBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}
