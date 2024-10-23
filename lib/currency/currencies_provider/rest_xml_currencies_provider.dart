import 'package:currencycalculatorapp/currency/currencies_provider/currencies_provider_exceptions.dart';
import 'package:currencycalculatorapp/currency/currency.dart';
import 'package:currencycalculatorapp/currency/currency_collection.dart';
import 'package:currencycalculatorapp/currency/currencies_provider/currencies_provider.dart';
import 'package:currencycalculatorapp/constants/urls.dart';
import 'package:currencycalculatorapp/currency/hash_set_currency_collection.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class RestXmlCurrencyProvider implements CurrenciesProvider {
  @override
  Future<CurrencyCollection> fetchCurrencies() async {
    final currencies = HashSetCurrencyCollection();
    try {
      final response = await http.get(Uri.parse(currenciesXmlUrl));

      if (response.statusCode != 200) {
        throw UnableToLoadCurrenciesProviderException();
      }

      //DEBUG:
      // print('Response body: ${response.body}');

      final document = XmlDocument.parse(response.body);
      final exchangeRatesTable =
          document.findElements('ExchangeRatesTable').first;
      final ratesElement = exchangeRatesTable.findElements('Rates').first;
      for (final currencyElement in ratesElement.findAllElements('Rate')) {
        final code = currencyElement.findAllElements('Code').first.text;
        final name = currencyElement.findAllElements('Currency').first.text;
        final rate =
            double.parse(currencyElement.findAllElements('Mid').first.text);

        currencies.addCurrency(Currency(code: code, name: name, rate: rate));
      }

      return currencies;
    } catch (e) {
      print('rest xml provider error: $e');
      return currencies;
    }
  }
}
