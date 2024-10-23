import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:currencycalculatorapp/currency/currency.dart';
import 'package:currencycalculatorapp/currency/currency_collection.dart';

class HashSetCurrencyCollection implements CurrencyCollection {
  final HashSet<Currency> _currencies = HashSet<Currency>();

  @override
  void addCurrency(Currency currency) {
    _currencies.add(currency);
  }

  @override
  Set<Currency> getAllCurrencies() {
    return _currencies;
  }

  @override
  Currency? getCurrency(String code) {
    return _currencies.firstWhereOrNull((currency) => currency.code == code);
  }

  // @override
  // void removeCurrency(String code) {
  //   _currencies.removeWhere((currency) => currency.code == code);
  // }
}
