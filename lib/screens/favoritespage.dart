import 'package:flutter/material.dart';
import '../models/quote.dart';
import 'package:hive/hive.dart';

class FavoritesPage extends StatelessWidget {
  final Box<Quote> quoteBox;

  FavoritesPage({required this.quoteBox});

  @override
  Widget build(BuildContext context) {
    final favoriteQuotes =
        quoteBox.values.where((quote) => quote.isFavorite).toList();

    if (favoriteQuotes.isEmpty) {
      return Center(
        child: Text('No favorite quotes.'),
      );
    }

    return ListView.builder(
      itemCount: favoriteQuotes.length,
      itemBuilder: (context, index) {
        final quote = favoriteQuotes[index];

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
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      quote.isFavorite =
                          false; // Mengubah status favorit menjadi false
                      quote.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Quote removed from favorites.'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
