import 'package:flutter/material.dart';

import '../../main.dart';
import '../application/bridge.dart';
import '../presentation/scaffold.dart';
import 'buttons.dart';

/// A generic station, console or screen on the [Bridge].
sealed class BridgeStation extends StatelessWidget {
  const BridgeStation._({super.key});

  /// The [Bridge] used throughout the simulation.
  Bridge get bridge => Home.mainBridge;

  /// A more human-readable name for this [BridgeStation].
  String get name => runtimeType.toString().replaceFirst('BridgeStation', '');

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
        child: Text(name, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => name;
}

/// Displays various views to the bridge crew, often of what's in front of the ship.
final class ViewscreenBridgeStation extends BridgeStation {
  const ViewscreenBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return placeholderBuildMethod(context);
  }
}

/// Responsible for communications, scanning and course navigation.
final class OpsBridgeStation extends BridgeStation {
  const OpsBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for piloting the ship.
final class ConnBridgeStation extends BridgeStation {
  const ConnBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Provides key information to the ship's Captain.
final class CaptainChairBridgeStation extends BridgeStation {
  const CaptainChairBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for weapons, shields, long-range sensors and communications (supporting the [OpsBridgeStation])
final class TacticalBridgeStation extends BridgeStation {
  const TacticalBridgeStation({super.key}) : super._();

  void firePhasers() {
    debugPrint('Firing phasers!');
    // TODO implement phaser firing
    bridge.send('firePhasers');
  }

  void firePhotonTorpedoes() {
    debugPrint('Firing photon torpedoes!');
    // TODO implement torpedo firing
  }

  static const double spacing = 32;

  @override
  Widget build(BuildContext context) {
    Widget firePhasersButton = DangerButton(
      context: () => context,
      text: 'Fire Phasers',
      onPressed: firePhasers,
    );

    Widget firePhotonTorpedoesButton = DangerButton(
      context: () => context,
      text: 'Fire Photon Torpedoes',
      onPressed: firePhotonTorpedoes,
    );

    return DefaultScaffold(
      body: GridView.count(
        padding: EdgeInsets.all(spacing),
        crossAxisSpacing: spacing,
        crossAxisCount: 4,
        children: [firePhasersButton, firePhotonTorpedoesButton],
      ),
    );
  }
}

/// Responsible for science investigations.
final class ScienceIBridgeStation extends BridgeStation {
  const ScienceIBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for science investigations.
final class ScienceIIBridgeStation extends BridgeStation {
  const ScienceIIBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Enables access to data about the ship's current mission (e.g. about nearby planets).
final class MissionOpsBridgeStation extends BridgeStation {
  const MissionOpsBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for controlling the life support system to maintain a habitable and comfortable environment for the crew .
final class EnvironmentBridgeStation extends BridgeStation {
  const EnvironmentBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}

/// Responsible for the ship's engines, transporters and other engineering systems.
///
/// This is a backup to the consoles found in Main Engineering.
final class EngineeringBridgeStation extends BridgeStation {
  const EngineeringBridgeStation({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return placeholderBuildMethod(context);
  }
}
