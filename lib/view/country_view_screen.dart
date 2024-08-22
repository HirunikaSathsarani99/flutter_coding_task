import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_coding_task/view_model/country_view_model.dart';

import 'country_details_screen.dart';

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CountryViewModel>(context, listen: false).fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        title: Text('European Countries'),
      ),
      body: SafeArea(
        child: Consumer<CountryViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Sort By :  ",style: TextStyle(fontSize: 16)),
                      DropdownButton<String>(
                        value:
                            Provider.of<CountryViewModel>(context).sortCriteria,
                        items: <String>['name', 'population', 'capital']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                '${value[0].toUpperCase() + value.substring(1)}'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            Provider.of<CountryViewModel>(context, listen: false)
                                .setSortCriteria(newValue);
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        switch (viewModel.state) {
                          case ViewState.init:
                          case ViewState.loading:
                            return Center(child: CircularProgressIndicator());
                          case ViewState.error:
                            return Center(
                                child: Text('Failed to load countries.'));

                          case ViewState.loaded:
                            if (viewModel.countries.isEmpty) {
                              return Center(
                                  child: Text('No countries available.'));
                            }
                            return ListView.builder(
                              itemCount: viewModel.countries.length,
                              itemBuilder: (context, index) {
                                final country = viewModel.countries[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenSize.height * 0.005,
                                      horizontal: ScreenSize.width * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ScreenSize.height * 0.005,
                                    ),
                                    child: ListTile(
                                      leading: Image.network(
                                        country.flags.png,
                                        width: ScreenSize.width * 0.35,
                                        height: ScreenSize.height * 0.35,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(country.name.common),
                                      subtitle: Text(
                                          'Capital: ${country.capital.first}'),
                                      trailing: Icon(Icons.more_vert),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CountryDetailScreen(
                                                    country: country),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
