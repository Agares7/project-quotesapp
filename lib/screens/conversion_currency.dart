import 'package:flutter/material.dart';

class ConversionCurrency extends StatefulWidget {
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<ConversionCurrency> {
  String fromCurrency = 'IDR';
  String toCurrency = 'USD';
  double amount = 0.0;
  double result = 0.0;

  List<String> currencies = ['IDR', 'USD', 'EUR'];

  void convertCurrency() {
    if (fromCurrency == 'IDR' && toCurrency == 'USD') {
      result = amount / 15000; 
    } else if (fromCurrency == 'IDR' && toCurrency == 'EUR') {
      result = amount / 17000; 
    } else if (fromCurrency == 'USD' && toCurrency == 'IDR') {
      result = amount * 15000; 
    } else if (fromCurrency == 'USD' && toCurrency == 'EUR') {
      result = amount * 0.85; 
    } else if (fromCurrency == 'EUR' && toCurrency == 'IDR') {
      result = amount * 17000; 
    } else if (fromCurrency == 'EUR' && toCurrency == 'USD') {
      result = amount / 0.85; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Conversion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: fromCurrency,
              onChanged: (newValue) {
                setState(() {
                  fromCurrency = newValue!;
                });
              },
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text('From: $currency'), 
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: toCurrency,
              onChanged: (newValue) {
                setState(() {
                  toCurrency = newValue!;
                });
              },
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text('To: $currency'), 
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                amount = double.tryParse(value) ?? 0.0;
              },
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                convertCurrency();
                setState(() {}); 
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              '$amount $fromCurrency = $result $toCurrency',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
