from dataclasses import dataclass

import json


class ShipPosition:
    """A simple `(x, y)` representation of a ship's position."""

    def __init__(self, x: int = 0, y: int = 0):
        self.x: int = x
        self.y: int = y

    def __repr__(self):
        return f'({self.x}, {self.y})'

    def toJSON(self) -> str:
        return json.dumps(
            self,
            default=lambda o: o.__dict__,
            sort_keys=True,
            indent=4)


class ShipState:
    @dataclass
    class Navigation:
        """Data about the Enterprise's navigational state."""
        position: ShipPosition = ShipPosition(0, 0)
        in_neutral_zone: bool = False

    @dataclass
    class Structure:
        """Data about the Enterprise's structure."""
        hull_integrity: int = 100  # percent

    def __init__(self):
        """Model of the Enterprise."""
        self.structure_data: ShipState.Structure = ShipState.Structure()

        self.navigation_data: ShipState.Navigation = ShipState.Navigation()

        self.shields_up: bool = False

        self.weapons_locked: bool = False


class Universe:
    def __init__(self):
        """Model of the universe in which the simulation takes place."""
        self.ship_state: ShipState = ShipState()

        self.klingon_positions: list[ShipPosition] = []  # No Klingons initially
