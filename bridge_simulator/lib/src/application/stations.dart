import 'package:bridge_simulator/bridge_simulator.dart';
import 'package:flutter/material.dart';

sealed class BridgeStation extends StatelessWidget {
  const BridgeStation._({super.key});

  String get stationName => runtimeType.toString();

  static const ViewscreenBridgeStation viewscreen = ViewscreenBridgeStation();

  static const OpsBridgeStation ops = OpsBridgeStation();

  static const ConnBridgeStation conn = ConnBridgeStation();

  static const CaptainChairBridgeStation captainChair =
      CaptainChairBridgeStation();

  static const TacticalBridgeStation tactical = TacticalBridgeStation();

  static const ScienceIBridgeStation scienceI = ScienceIBridgeStation();

  static const ScienceIIBridgeStation scienceII = ScienceIIBridgeStation();

  static const MissionOpsBridgeStation missionOps = MissionOpsBridgeStation();

  static const EnvironmentBridgeStation environment =
      EnvironmentBridgeStation();

  static const EngineeringBridgeStation engineering =
      EngineeringBridgeStation();

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

  void firePhasers() {
    debugPrint('Firing phasers!');
  }

  void firePhotonTorpedoes() {
    debugPrint('Firing photon torpedoes!');
  }

  static const double spacing = 32;

  @override
  Widget build(BuildContext context) {
    Widget firePhasersButton = DangerButton(
      context: context,
      text: 'Fire Phasers',
      onPressed: firePhasers,
    );

    Widget firePhotonTorpedoesButton = DangerButton(
      context: context,
      text: 'Fire Photon Torpedoes',
      onPressed: firePhotonTorpedoes,
    );

    return Scaffold(
      body: GridView.count(
        padding: EdgeInsets.all(spacing),
        crossAxisSpacing: spacing,
        crossAxisCount: 4,
        children: [firePhasersButton, firePhotonTorpedoesButton],
      ),
    );
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
