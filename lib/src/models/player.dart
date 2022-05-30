class Player {
  const Player({required this.name});
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
