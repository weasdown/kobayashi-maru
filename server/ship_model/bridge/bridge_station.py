from __future__ import annotations


class BridgeStation:
    def __init__(self, websocket):
        self.websocket = websocket

    async def process_commands(self, data: dict):
        print(f'Got data: {data}')
        command: str = f'self.{data}()'
        print(f'Command: {command} in {type(self).__name__}')
        await eval(command)
