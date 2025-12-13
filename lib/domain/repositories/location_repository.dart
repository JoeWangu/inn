import 'package:inn/data/datasources/remote/houses_api.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_repository.g.dart';

@riverpod
LocationRepository locationRepository(Ref ref) {
  return LocationRepository(ref.read(housesApiProvider));
}

class LocationRepository {
  final HousesApi _api;

  LocationRepository(this._api);

  Future<List<Country>> getCountries() async {
    final response = await _api.getCountries();
    return response.results;
  }

  Future<List<StateData>> getStates(int countryId) async {
    final response = await _api.getStates(countryId);
    return response.results;
  }

  Future<List<City>> getCities(int stateId) async {
    final response = await _api.getCities(stateId);
    return response.results;
  }

  Future<List<Neighborhood>> getNeighborhoods(int cityId) async {
    final response = await _api.getNeighborhoods(cityId);
    return response.results;
  }
}
