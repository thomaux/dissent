class Player {
  const Player({required this.name, required this.id});
  final String name;
  final int id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
