import json

from server.ship_model.bridge.bridge_station import BridgeStation
from server.ship_model.bridge.stations import Tactical, Viewscreen


class Bridge:
    def __init__(self, websocket):
        self.tactical: Tactical = Tactical(websocket)
        self.viewscreen: Viewscreen = Viewscreen(websocket)

        self.stations: list[BridgeStation] = [self.viewscreen, self.tactical]

    def toJSON(self) -> str:
        return json.dumps(
            {'tactical': json.loads(self.tactical.toJSON()), 'viewscreen': json.loads(self.viewscreen.toJSON())})
