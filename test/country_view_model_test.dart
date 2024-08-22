import 'package:flutter_coding_task/model/country_model.dart';
import 'package:flutter_coding_task/view_model/country_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test_mocks.mocks.dart';



void main() {
  late CountryViewModel viewModel;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    viewModel = CountryViewModel(mockApiClient);
  });

  group('CountryViewModel Tests', () {
    test('Initial state should be idle', () {
      expect(viewModel.state, ViewState.init);
      expect(viewModel.countries, []);
    });

    test('fetchCountries should set state to loading and then loaded on success', () async {
      final countries = [
        Country(
          flags: Flags(png: '', svg: '', alt: ''),
          name: Name(common: 'Germany', official: 'Federal Republic of Germany'),
          capital: ['Berlin'],
          region: 'Europe',
          languages: {'deu': 'German'},
          population: 83166711,
        ),
        Country(
          flags: Flags(png: '', svg: '', alt: ''),
          name: Name(common: 'France', official: 'French Republic'),
          capital: ['Paris'],
          region: 'Europe',
          languages: {'fra': 'French'},
          population: 67348000,
        ),
      ];
      when(mockApiClient.getEuropeanCountries()).thenAnswer((_) async => countries);

      await viewModel.fetchCountries();

      expect(viewModel.state, ViewState.loaded);
      expect(viewModel.countries, countries);
    });

    test('fetchCountries should set state to error on failure', () async {
      when(mockApiClient.getEuropeanCountries()).thenThrow(Exception('Failed to fetch countries'));

      await viewModel.fetchCountries();

      expect(viewModel.state, ViewState.error);
      expect(viewModel.countries, []);
    });
  });
}
