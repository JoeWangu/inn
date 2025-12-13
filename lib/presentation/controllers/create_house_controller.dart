import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inn/data/models/create_house_request.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/domain/repositories/location_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_house_controller.freezed.dart';
part 'create_house_controller.g.dart';

@freezed
abstract class CreateHouseFormState with _$CreateHouseFormState {
  const factory CreateHouseFormState({
    // IDs
    int? countryId,
    int? stateId,
    int? cityId,
    int? neighborhoodId,
    int? imageId, // Selected image ID
    // Dropdown Data
    @Default([]) List<Country> countries,
    @Default([]) List<StateData> states,
    @Default([]) List<City> cities,
    @Default([]) List<Neighborhood> neighborhoods,

    // Loading States
    @Default(false) bool isSubmitting,
    @Default(false) bool isLoadingLocations,
  }) = _CreateHouseFormState;
}

@riverpod
class CreateHouseController extends _$CreateHouseController {
  @override
  Future<CreateHouseFormState> build() async {
    try {
      // Initial fetch of countries
      final countries = await ref
          .read(locationRepositoryProvider)
          .getCountries();
      return CreateHouseFormState(countries: countries);
    } catch (e) {
      // Log error or rethrow safely
      print("Error fetching countries: $e");
      // Return empty state or rethrow if you want the UI to show error
      rethrow;
    }
  }

  // --- Location Setters ---

  void setCountry(int? id) async {
    if (id == state.value?.countryId) return;

    // Update ID and clear downstream, set loading
    state = AsyncData(
      state.value!.copyWith(
        countryId: id,
        stateId: null,
        cityId: null,
        neighborhoodId: null,
        states: [],
        cities: [],
        neighborhoods: [],
        isLoadingLocations: true,
      ),
    );

    if (id != null) {
      try {
        final states = await ref.read(locationRepositoryProvider).getStates(id);
        state = AsyncData(
          state.value!.copyWith(states: states, isLoadingLocations: false),
        );
      } catch (e) {
        state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
        // Handle error (maybe toast)
      }
    } else {
      state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
    }
  }

  void setStateData(int? id) async {
    if (id == state.value?.stateId) return;

    state = AsyncData(
      state.value!.copyWith(
        stateId: id,
        cityId: null,
        neighborhoodId: null,
        cities: [],
        neighborhoods: [],
        isLoadingLocations: true,
      ),
    );

    if (id != null) {
      try {
        final cities = await ref.read(locationRepositoryProvider).getCities(id);
        state = AsyncData(
          state.value!.copyWith(cities: cities, isLoadingLocations: false),
        );
      } catch (e) {
        state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
      }
    } else {
      state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
    }
  }

  void setCity(int? id) async {
    if (id == state.value?.cityId) return;

    state = AsyncData(
      state.value!.copyWith(
        cityId: id,
        neighborhoodId: null,
        neighborhoods: [],
        isLoadingLocations: true,
      ),
    );

    if (id != null) {
      try {
        final neighborhoods = await ref
            .read(locationRepositoryProvider)
            .getNeighborhoods(id);
        state = AsyncData(
          state.value!.copyWith(
            neighborhoods: neighborhoods,
            isLoadingLocations: false,
          ),
        );
      } catch (e) {
        state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
      }
    } else {
      state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
    }
  }

  void setNeighborhood(int? id) {
    state = AsyncData(state.value!.copyWith(neighborhoodId: id));
  }

  // --- Image ---

  void setImage(int id) {
    state = AsyncData(state.value!.copyWith(imageId: id));
  }

  // --- Submit ---

  Future<bool> submit({
    required String title,
    required double price,
    required String description,
    required String category,
    required int totalUnits,
    required bool available,
    required bool isActive,
  }) async {
    final s = state.value;
    if (s == null) return false;

    state = AsyncData(s.copyWith(isSubmitting: true));

    try {
      final request = CreateHouseRequest(
        title: title,
        image: s.imageId,
        price: price,
        description: description,
        category: category,
        available: available,
        totalUnits: totalUnits,
        isActive: isActive,
        country: s.countryId,
        state: s.stateId,
        city: s.cityId,
        neighborhood: s.neighborhoodId,
      );

      await ref.read(houseRepositoryProvider).createHouse(request);

      state = AsyncData(s.copyWith(isSubmitting: false));
      return true;
    } catch (e) {
      print("Submit Error: $e");
      state = AsyncData(s.copyWith(isSubmitting: false));
      return false;
    }
  }
}
