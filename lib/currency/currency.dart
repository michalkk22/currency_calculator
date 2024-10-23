class Currency {
  final String code;
  final String name;
  double rate;

  Currency({
    required this.code,
    required this.name,
    required this.rate,
  });

  @override
  int get hashCode => code.hashCode;

  @override
  bool operator ==(covariant Currency other) {
    return code == other.code;
  }
}
