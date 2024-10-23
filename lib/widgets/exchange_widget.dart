import 'package:currencycalculatorapp/currency/currencies_provider/currencies_provider.dart';
import 'package:currencycalculatorapp/currency/currencies_provider/rest_json_currencies_provider.dart';
import 'package:currencycalculatorapp/currency/currency.dart';
import 'package:currencycalculatorapp/currency/currency_collection.dart';
import 'package:currencycalculatorapp/utils/exchanger.dart';
import 'package:flutter/material.dart';

class ExchangeWidget extends StatefulWidget {
  const ExchangeWidget({super.key});

  @override
  State<ExchangeWidget> createState() => _ExchangeWidgetState();
}

class _ExchangeWidgetState extends State<ExchangeWidget> {
  late final CurrenciesProvider _currenciesProvider;
  late final Exchanger exchanger;
  CurrencyCollection? _currencies;
  Currency? _selectedCurrency;
  double _amount = 0;
  Currency? _otherSelectedCurrency;
  double _newAmount = 0;

  @override
  void initState() {
    exchanger = Exchanger();
    _currenciesProvider = RestJsonCurrenciesProvider();
    getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (_currencies == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const Text('Currency: '),
        currencyDropdown(
          _currencies!,
          _selectedCurrency,
          (currency) => setState(() {
            _selectedCurrency = currency;
            exchange();
          }),
        ),
        SizedBox(
          width: screenWidth * 0.5,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _amount = double.tryParse(value) ?? 0;
              exchange();
            },
          ),
        ),
        const Text('Currency: '),
        currencyDropdown(
          _currencies!,
          _otherSelectedCurrency,
          (currency) => setState(() {
            _otherSelectedCurrency = currency;
            exchange();
          }),
        ),
        Text('$_newAmount'),
      ],
    );
  }

  Future<void> getCurrencies() async {
    _currencies = await _currenciesProvider.fetchCurrencies();
    setState(() {});
  }

  void exchange() {
    setState(() {
      _newAmount = exchanger.exchange(
        _selectedCurrency!.rate,
        _amount,
        _otherSelectedCurrency!.rate,
      );
    });
  }

  DropdownButton<Currency> currencyDropdown(
    CurrencyCollection currencies,
    Currency? selectedCurrency,
    ValueChanged<Currency?> onChanged,
  ) {
    return DropdownButton<Currency>(
      value: selectedCurrency,
      items: currencies.getAllCurrencies().map((currency) {
        return DropdownMenuItem<Currency>(
          value: currency,
          child: Text('${currency.code} ${currency.name}'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
