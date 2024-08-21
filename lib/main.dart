import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_task/service/api_service.dart';
import 'package:flutter_coding_task/view/country_view_screen.dart';
import 'package:flutter_coding_task/view_model/country_view_model.dart';
import 'package:provider/provider.dart';


void main() {
  final dio = Dio();
  final apiClient = ApiClient(dio);

  runApp(MyApp(apiClient: apiClient));
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient;

  MyApp({required this.apiClient});

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (_) => CountryViewModel(apiClient), 
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: CountryListScreen(),
      ),
    );
  }
}