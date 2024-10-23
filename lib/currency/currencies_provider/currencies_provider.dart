import 'package:currencycalculatorapp/currency/currency_collection.dart';

abstract class CurrenciesProvider {
  Future<CurrencyCollection> fetchCurrencies();
}
