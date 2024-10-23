import 'dart:convert';

import 'package:currencycalculatorapp/constants/urls.dart';
import 'package:currencycalculatorapp/currency/currencies_provider/currencies_provider.dart';
import 'package:currencycalculatorapp/currency/currencies_provider/currencies_provider_exceptions.dart';
import 'package:currencycalculatorapp/currency/currency.dart';
import 'package:currencycalculatorapp/currency/currency_collection.dart';
import 'package:currencycalculatorapp/currency/hash_set_currency_collection.dart';
import 'package:http/http.dart' as http;

class RestJsonCurrenciesProvider implements CurrenciesProvider {
  RestJsonCurrenciesProvider._privateConstructor();
  static final RestJsonCurrenciesProvider _instance =
      RestJsonCurrenciesProvider._privateConstructor();
  factory RestJsonCurrenciesProvider() => _instance;

  @override
  Future<CurrencyCollection> fetchCurrencies() async {
    final currencies = HashSetCurrencyCollection();
    try {
      final response = await http.get(Uri.parse(currenciesXmlUrl));

      if (response.statusCode != 200) {
        throw UnableToLoadCurrenciesProviderException();
      }

      final jsonData = jsonDecode(response.body);

      final rates = jsonData[0]['rates'];

      for (final rate in rates) {
        final code = rate['code'];
        final currency = rate['currency'];
        final mid = rate['mid'];

        currencies.addCurrency(Currency(code: code, name: currency, rate: mid));
      }

      if (currencies.getCurrency('PLN') == null) {
        currencies
            .addCurrency(Currency(code: 'PLN', name: 'Polski Złoty', rate: 1));
      }

      return currencies;
    } catch (e) {
      print('rest json provider error: $e');
      return currencies;
    }
  }
}
