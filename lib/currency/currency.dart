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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Currency) return false;
    return code == other.code;
  }
}
