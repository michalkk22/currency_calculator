import 'package:currencycalculatorapp/currency/currency.dart';

abstract class CurrencyCollection {
  void addCurrency(Currency currency);
  // void removeCurrency(String code);
  Currency? getCurrency(String code);
  Set<Currency> getAllCurrencies();
}
