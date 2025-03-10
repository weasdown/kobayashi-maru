import 'package:kobayashi_maru/kobayashi_maru.dart';
import 'package:kobayashi_maru/src/application/bridge_station_model.dart';

abstract class BridgeStation {
  const BridgeStation._({required this.model, required this.widget});

  /// A more human-readable name for this [BridgeStation].
  String get name => runtimeType.toString().replaceFirst('BridgeStation', '');

  static ViewscreenBridgeStation get viewscreen => ViewscreenBridgeStation();

  static OpsBridgeStation get ops => OpsBridgeStation();

  static ConnBridgeStation get conn => ConnBridgeStation();

  static CaptainChairBridgeStation get captainChair =>
      CaptainChairBridgeStation();

  static TacticalBridgeStation get tactical => TacticalBridgeStation();

  static ScienceIBridgeStation get scienceI => ScienceIBridgeStation();

  static ScienceIIBridgeStation get scienceII => ScienceIIBridgeStation();

  static MissionOpsBridgeStation get missionOps => MissionOpsBridgeStation();

  static EnvironmentBridgeStation get environment => EnvironmentBridgeStation();

  static EngineeringBridgeStation get engineering => EngineeringBridgeStation();

  final BridgeStationModel model;

  final BridgeStationView widget;
}

final class ViewscreenBridgeStation extends BridgeStation {
  ViewscreenBridgeStation()
    : super._(
        model: ViewscreenBridgeStationModel(),
        widget: ViewscreenBridgeStationView(),
      );
}

final class OpsBridgeStation extends BridgeStation {
  OpsBridgeStation()
    : super._(model: OpsBridgeStationModel(), widget: OpsBridgeStationView());
}

final class ConnBridgeStation extends BridgeStation {
  ConnBridgeStation()
    : super._(model: ConnBridgeStationModel(), widget: ConnBridgeStationView());
}

final class CaptainChairBridgeStation extends BridgeStation {
  CaptainChairBridgeStation()
    : super._(
        model: CaptainChairBridgeStationModel(),
        widget: CaptainChairBridgeStationView(),
      );
}

final class TacticalBridgeStation extends BridgeStation {
  TacticalBridgeStation()
    : super._(
        model: TacticalBridgeStationModel(),
        widget: TacticalBridgeStationView(),
      );
}

final class ScienceIBridgeStation extends BridgeStation {
  ScienceIBridgeStation()
    : super._(
        model: ScienceIBridgeStationModel(),
        widget: ScienceIBridgeStationView(),
      );
}

final class ScienceIIBridgeStation extends BridgeStation {
  ScienceIIBridgeStation()
    : super._(
        model: ScienceIIBridgeStationModel(),
        widget: ScienceIIBridgeStationView(),
      );
}

final class MissionOpsBridgeStation extends BridgeStation {
  MissionOpsBridgeStation()
    : super._(
        model: MissionOpsBridgeStationModel(),
        widget: MissionOpsBridgeStationView(),
      );
}

final class EnvironmentBridgeStation extends BridgeStation {
  EnvironmentBridgeStation()
    : super._(
        model: EnvironmentBridgeStationModel(),
        widget: EnvironmentBridgeStationView(),
      );
}

final class EngineeringBridgeStation extends BridgeStation {
  EngineeringBridgeStation()
    : super._(
        model: EngineeringBridgeStationModel(),
        widget: EngineeringBridgeStationView(),
      );
}
