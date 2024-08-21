import 'package:flutter/cupertino.dart';
import 'package:flutter_coding_task/model/country_model.dart';
import 'package:flutter_coding_task/service/api_service.dart';

enum ViewState { idle, loading, error }


class CountryViewModel with ChangeNotifier{
  List<Country> _countries = [];
  List<Country> get countries => _countries;

  String _sortCriteria = 'name';
  String get sortCriteria => _sortCriteria;

  final ApiClient apiClient;
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  CountryViewModel(this.apiClient);

  Future<void> fetchCountries() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final countries = await apiClient.getEuropeanCountries();
      _countries = countries;
      _sortCountries();
      _state = ViewState.idle;
    } catch (e) {
      _state = ViewState.error;
      print('Failed to fetch countries: $e');
    } finally {
      notifyListeners();
    }
  }

  void setSortCriteria(String criteria) {
    _sortCriteria = criteria;
    _sortCountries();
    notifyListeners();
  }

  void _sortCountries() {
    if (_countries.isNotEmpty) {
      switch (_sortCriteria) {
        case 'population':
          _countries.sort((a, b) => a.population.compareTo(b.population));
          break;
        case 'capital':
          _countries.sort((a, b) => a.capital.first.compareTo(b.capital.first));
          break;
        default:
          _countries.sort((a, b) => a.name.common.compareTo(b.name.common));
          break;
      }
    }
  }
}