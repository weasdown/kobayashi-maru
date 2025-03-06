/// Model of the starship as a whole.
final class Ship {
  Ship({required this.registry, required this.name});

  /// E.g. "*USS Enterprise*"
  final String name;

  /// E.g. "NCC-1701-D" for the [*Galaxy*-class Enterprise-D](https://memory-alpha.fandom.com/wiki/USS_Enterprise_(NCC-1701-D)).
  final String registry;
}
