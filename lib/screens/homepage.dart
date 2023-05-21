import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../navigator/bottom_navbar.dart';
import '../models/quote.dart';
import 'favoritespage.dart';
import 'otherpage.dart';

class ApiService {
  Future<Map<String, String>> getQuote(String category) async {
    const apiURL = 'https://api.api-ninjas.com/v1/quotes?category=';
    final response = await http.get(
      Uri.parse(apiURL + category),
      headers: {'X-Api-Key': 'hLNwH+ZEK1VLGJLM2s9vlw==PFTXCCCr3nFIgBZt'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        'quote': json[0]['quote'],
        'author': json[0]['author'],
      };
    } else {
      throw Exception('Failed to load quote');
    }
  }
}

class FetchQuotePage extends StatefulWidget {
  @override
  _FetchQuotePageState createState() => _FetchQuotePageState();
}

class _FetchQuotePageState extends State<FetchQuotePage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  List<Map<String, String>> _quotes = [];
  late Box<Quote>? quoteBox;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    quoteBox = Hive.box<Quote>('quotes');
  }

  void dispose() {
    quoteBox!.close();
    super.dispose();
  }

  void _clearQuotes() {
    setState(() {
      _quotes.clear();
    });
  }

  Future<void> _fetchQuotes() async {
    final category = _categoryController.text;
    final limit = int.tryParse(_limitController.text) ?? 0;
    final apiService = ApiService();

    try {
      _clearQuotes();
      final quotes = <Map<String, String>>[];
      for (var i = 0; i < limit; i++) {
        final quoteData = await apiService.getQuote(category);
        final quote = Quote()
          ..quote = quoteData['quote']!
          ..author = quoteData['author']!
          ..category = category;
        quote.isFavorite = quoteBox!.values.any((q) =>
            q.quote == quoteData['quote'] && q.author == quoteData['author']);
        quoteBox!.add(quote);
        quotes.add(quoteData);
      }

      setState(() {
        _quotes = quotes;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              labelText: 'Category',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _limitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Limit',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _fetchQuotes, 
            child: const Text('Fetch Quotes'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ValueListenableBuilder<Box<Quote>>(
              valueListenable: quoteBox!.listenable(),
              builder: (context, box, _) {
                final quotes = box.values.toList();
                return ListView.builder(
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category: ${quote.category}',
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                quote.quote,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '- ${quote.author}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  quote.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  quote.isFavorite = !quote.isFavorite;
                                  quote.save();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesScreen() {
    return FavoritesPage(quoteBox: quoteBox!);
  }

  Widget _buildOtherScreen() {
    return const OtherPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildHomeScreen(),
      _buildFavoritesScreen(),
      _buildOtherScreen(),
    ];

    final List<String> appBarTitles = [
      'Quote App',
      'Favorites Quotes',
      'Other',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[
            _currentIndex]), // Menggunakan judul yang sesuai dengan indeks saat ini
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
