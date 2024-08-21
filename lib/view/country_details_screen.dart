import 'package:flutter/material.dart';
import '../model/country_model.dart';


class CountryDetailScreen extends StatelessWidget {
  final Country country;

  CountryDetailScreen({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name.official),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flags.png),
            SizedBox(height: 16.0),
            Text('Capital: ${country.capital.first}', style: TextStyle(fontSize: 18)),
            Text('Population: ${country.population}', style: TextStyle(fontSize: 18)),
            Text('Languages: ${country.languages.values.join(', ')}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
