import json

from server.ship_model.bridge.bridge_station import BridgeStation


class Tactical(BridgeStation):
    def __init__(self, websocket):
        """Models the Tactical bridge station."""
        super().__init__(websocket)
        self.phasers_firing: bool = False
        self.torpedoes_firing: bool = False

        self.torpedoes_remaining: int = 20

    async def fire_phasers(self):
        """Fires the ship's [phasers](https://memory-alpha.fandom.com/wiki/Phaser#Planetary_or_starship-mounted_phasers)."""
        echo: str = 'Firing phasers as commanded!'
        print(echo)
        self.phasers_firing = True
        # await self.websocket.send(json.dumps({'firing_phasers': True}))
        self.phasers_firing = False
        # await self.websocket.send(json.dumps({'firing_phasers': False}))

    async def fire_torpedoes(self):
        """Fires a [photon torpedo](https://memory-alpha.fandom.com/wiki/Photon_torpedo)."""
        echo: str = 'Firing torpedoes as commanded!'
        print(echo)
        self.torpedoes_firing = True
        if self.torpedoes_remaining > 0:
            self.torpedoes_remaining -= 1
            self.torpedoes_firing = False
            # await self.websocket.send(json.dumps({'torpedoes_remaining': str(self.torpedoes_remaining)}))
        else:
            self.torpedoes_firing = False
        # await self.websocket.send(json.dumps({'torpedoes_firing_failed': 'remaining == 0'}))

    def toJSON(self):
        return json.dumps({'phasers_firing': self.phasers_firing, 'torpedoes_firing': self.torpedoes_firing,
                           'torpedoes_remaining': self.torpedoes_remaining})


class Viewscreen(BridgeStation):
    def __init__(self, websocket):
        """Models the Viewscreen at the front of the Bridge."""
        super().__init__(websocket)

    @staticmethod
    def toJSON():
        return json.dumps({})
