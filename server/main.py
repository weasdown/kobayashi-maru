# !/usr/bin/env python

# This program runs a WebSocket server that acts as the central point of the Kobayashi Maru network.
# It gathers information from and sends information to the various bridge stations (helm, tactical, etc).

import asyncio
import datetime
import json
import random

from websockets.asyncio.server import broadcast, serve, Server  # , ServerConnection

from server.ship_model.bridge import Bridge
from server.universe import ShipPosition, ShipState, Universe


async def noop(websocket):
    await websocket.wait_closed()


async def show_time(server):
    while True:
        message = datetime.datetime.now(tz=datetime.timezone.utc).isoformat()
        broadcast(server.connections, message)
        await asyncio.sleep(random.random() * 2 + 1)


def structural_integrity(sim_universe: Universe) -> int:
    return sim_universe.ship_state.structure_data.hull_integrity


async def simulate(websocket):
    bridge: Bridge = Bridge(websocket)

    while True:
        bridge_json: str = bridge.toJSON()
        print(f'bridge_json = {json.dumps(json.loads(bridge_json), indent=4)}')
        await websocket.send(bridge_json)

        data: dict = json.loads(await websocket.recv())
        print(f'Received: {data}')

        print(f'station: {data["station"]}')

        match data['station']:
            case 'Tactical':
                await bridge.tactical.process_commands(data['data'])
            # TODO add other cases


async def universe_state(server: Server, sim_universe: Universe):
    print(f'{server.sockets = }')

    while True:
        if structural_integrity(sim_universe) > 0:
            message = sim_universe.toJSON()
            broadcast(server.connections, message)

        else:
            message = '\nGAME OVER'
            print(message)
            broadcast(server.connections, message)
            break

        await asyncio.sleep(1)


async def main():
    local_only: bool = False
    host: str = 'localhost' if local_only else ''

    async with serve(simulate, host, 5678) as server:
        await server.serve_forever()


if __name__ == "__main__":
    position: ShipPosition = ShipPosition()
    ship_state: ShipState = ShipState()

    universe: Universe = Universe()

    asyncio.run(main())
