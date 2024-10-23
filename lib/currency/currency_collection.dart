import 'package:currencycalculatorapp/currency/currency.dart';

abstract class CurrencyCollection {
  void addCurrency(Currency currency);
  void removeCurrency(Currency currency);
  Currency? getCurrency(String code);
  Set<Currency> getAllCurrencies();
}
