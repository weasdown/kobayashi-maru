# !/usr/bin/env python

# This program runs a WebSocket server that acts as the central point of the Kobayashi Maru network.
# It gathers information from and sends information to the various bridge stations (helm, tactical, etc).

import asyncio
import datetime
import random

from websockets.asyncio.server import broadcast, serve

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


async def universe_state(server, sim_universe: Universe):
    while True:
        if structural_integrity(sim_universe) > 0:
            message = sim_universe.toJSON()
            broadcast(server.connections, message)

            sim_universe.ship_state.structure_data.hull_integrity -= 5
            print(f'New integrity: {structural_integrity(sim_universe)}')

        else:
            message = '\nGAME OVER'
            print(message)
            broadcast(server.connections, message)
            break

        await asyncio.sleep(1)


async def main(sim_universe: Universe):
    async with serve(noop, "localhost", 5678) as server:
        await universe_state(server, sim_universe)


if __name__ == "__main__":
    position: ShipPosition = ShipPosition()
    print(f'Initial ship position: {position}')
    print(f'Initial ship position as a JSON: {position.toJSON()}')

    ship_state: ShipState = ShipState()
    print(f'\nInitial ship state:\n{ship_state}')
    print(f'\nInitial ship state as a JSON:\n{ship_state.toJSON()}')

    universe: Universe = Universe()
    print(f'\nUniverse: {universe}')
    print(f'\nUniverse as a JSON: {universe.toJSON()}')

    asyncio.run(main(universe))
