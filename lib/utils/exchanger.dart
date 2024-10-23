class Exchanger {
  Exchanger._privateConstructor();
  static final Exchanger _instance = Exchanger._privateConstructor();
  factory Exchanger() => _instance;

  double exchange(double from, double amount, double to) {
    return from * amount / to;
  }
}
