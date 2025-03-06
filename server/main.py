# !/usr/bin/env python

# This program runs a WebSocket server that acts as the central point of the Kobayashi Maru network.
# It gathers information from and sends information to the various bridge stations (helm, tactical, etc).

import asyncio
import datetime
import json
import random

from websockets.asyncio.server import broadcast, serve, Server  # , ServerConnection
# from socket import socket

# from websockets.legacy.server import WebSocketServer

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


# async def process_client_messages(websocket: socket):
#     print(f'Pretending to process for {websocket}...')
#     data = await websocket.recv()
#     # async for message in websocket:
#     #     event = json.loads(message)
#     #     if event["action"] == "minus":
#     #         VALUE -= 1
#     #         broadcast(USERS, value_event())
#     #     elif event["action"] == "plus":
#     #         VALUE += 1
#     #         broadcast(USERS, value_event())
#     #     else:
#     #         logging.error("unsupported event: %s", event)

# Original from server.py example - TODO remove
# async def hello(websocket):
#     name = await websocket.recv()
#     print(f"<<< {name}")
#
#     greeting = f"Hello {name}!"
#
#     await websocket.send(greeting)
#     print(f">>> {greeting}")

async def simulate(websocket):
    # await websocket.send('Test data')

    while True:
        data: dict = json.loads(await websocket.recv())
        print(f'Received: {data}')
        print(f'data["data"]: {data["data"]}')

        await websocket.send(data['data'])
        print(f"Sending '{data}'\n")

        # await universe_state(websocket, sim_universe)


async def universe_state(server: Server, sim_universe: Universe):
    print(f'{server.sockets = }')
    # connections: set[ServerConnection] = server.connections
    # print(f'Connections: {connections}')

    while True:
        if structural_integrity(sim_universe) > 0:
            message = sim_universe.toJSON()
            broadcast(server.connections, message)

            # sim_universe.ship_state.structure_data.hull_integrity -= 5
            # print(f'New integrity: {structural_integrity(sim_universe)}')

        else:
            message = '\nGAME OVER'
            print(message)
            broadcast(server.connections, message)
            break

        await asyncio.sleep(1)


async def main(
        # sim_universe: Universe
):
    # async with serve(noop, 'localhost', 5678) as server:
    #     print('Running')
    #     await universe_state(server, sim_universe)
    #     await simulate(server, sim_universe)

    async with serve(simulate, "localhost", 5678) as server:
        await server.serve_forever()


if __name__ == "__main__":
    position: ShipPosition = ShipPosition()
    # print(f'Initial ship position: {position}')
    # print(f'Initial ship position as a JSON: {position.toJSON()}')

    ship_state: ShipState = ShipState()
    # print(f'\nInitial ship state:\n{ship_state}')
    # print(f'\nInitial ship state as a JSON:\n{ship_state.toJSON()}')

    universe: Universe = Universe()
    # print(f'\nUniverse: {universe}')
    # print(f'\nUniverse as a JSON: {universe.toJSON()}')

    asyncio.run(main(
        # universe
    ))
