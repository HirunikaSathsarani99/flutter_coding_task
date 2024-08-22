import 'package:flutter/material.dart';
import '../model/country_model.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  CountryDetailScreen({required this.country});

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name.common),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05,
          vertical:  ScreenSize.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  country.flags.png,
                  width: ScreenSize.width * 0.75,
                  height: ScreenSize.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: ScreenSize.height * 0.05,),
              Text('Official Name: ${country.name.official}',
                  style: TextStyle(fontSize: 18)),
              Text('Capital: ${country.capital.first}',
                  style: TextStyle(fontSize: 18)),
              Text('Population: ${country.population}',
                  style: TextStyle(fontSize: 18)),
              Text('Languages: ${country.languages.values.join(', ')}',
                  style: TextStyle(fontSize: 18)),

            ],
          ),
        ),
      ),
    );
  }
}
