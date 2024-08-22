import 'package:flutter/cupertino.dart';
import 'package:flutter_coding_task/model/country_model.dart';
import 'package:flutter_coding_task/service/api_service.dart';

enum ViewState { init, loading,loaded, error }


class CountryViewModel with ChangeNotifier{
  List<Country> countriesList = [];
  List<Country> get countries => countriesList;

  String _sortCriteria = 'name';
  String get sortCriteria => _sortCriteria;

  final ApiClient apiClient;
  ViewState _state = ViewState.init;
  ViewState get state => _state;

  CountryViewModel(this.apiClient);

  //fetch data

  Future<void> fetchCountries() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final countries = await apiClient.getEuropeanCountries();
      countriesList = countries;
      sortCountries();
      _state = ViewState.loaded;
      print('Country list is  loaded');
    } catch (e) {
      _state = ViewState.error;
      print('Failed to fetch countries: $e');
    } finally {
      notifyListeners();
    }
  }

  void setSortCriteria(String criteria) {
    _sortCriteria = criteria;
    sortCountries();
    notifyListeners();
  }

  void sortCountries() {
    if (countriesList.isNotEmpty) {
      switch (_sortCriteria) {
        case 'population':
          countriesList.sort((a, b) => a.population.compareTo(b.population));
          break;
        case 'capital':
          countriesList.sort((a, b) => a.capital.first.compareTo(b.capital.first));
          break;
        default:
          countriesList.sort((a, b) => a.name.common.compareTo(b.name.common));
          break;
      }
    }
  }
}