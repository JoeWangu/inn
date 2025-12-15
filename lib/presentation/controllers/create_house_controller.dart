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
    int? countryId,
    int? stateId,
    int? cityId,
    int? neighborhoodId,
    int? imageId,
    @Default([]) List<Country> countries,
    @Default([]) List<StateData> states,
    @Default([]) List<City> cities,
    @Default([]) List<Neighborhood> neighborhoods,

    @Default(false) bool isSubmitting,
    @Default(false) bool isLoadingLocations,
  }) = _CreateHouseFormState;
}

@riverpod
class CreateHouseController extends _$CreateHouseController {
  @override
  Future<CreateHouseFormState> build() async {
    try {
      final countries = await ref
          .read(locationRepositoryProvider)
          .getCountries();
      return CreateHouseFormState(countries: countries);
    } catch (e) {
      // print("Error fetching countries: $e");
      rethrow;
    }
  }

  void setCountry(int? id) async {
    if (id == state.value?.countryId) return;

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
        if (ref.mounted) {
          state = AsyncData(
            state.value!.copyWith(states: states, isLoadingLocations: false),
          );
        }
      } catch (e) {
        if (ref.mounted) {
          state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
        }
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
        if (ref.mounted) {
          state = AsyncData(
            state.value!.copyWith(cities: cities, isLoadingLocations: false),
          );
        }
      } catch (e) {
        if (ref.mounted) {
          state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
        }
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
        if (ref.mounted) {
          state = AsyncData(
            state.value!.copyWith(
              neighborhoods: neighborhoods,
              isLoadingLocations: false,
            ),
          );
        }
      } catch (e) {
        if (ref.mounted) {
          state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
        }
      }
    } else {
      state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
    }
  }

  void setNeighborhood(int? id) {
    state = AsyncData(state.value!.copyWith(neighborhoodId: id));
  }

  void setImage(int id) {
    state = AsyncData(state.value!.copyWith(imageId: id));
  }

  Future<void> initializeForEdit(HouseModel house) async {
    final currentState = await future;

    state = AsyncData(
      currentState.copyWith(
        countryId: house.country?.id,
        stateId: house.state?.id,
        cityId: house.city?.id,
        neighborhoodId: house.neighborhood?.id,
        imageId: house.imageDetail?.id ?? house.image,
        isLoadingLocations: true,
      ),
    );

    try {
      final repo = ref.read(locationRepositoryProvider);

      List<StateData> states = [];
      List<City> cities = [];
      List<Neighborhood> neighborhoods = [];

      if (house.country?.id != null) {
        states = await repo.getStates(house.country!.id);
      }
      if (house.state?.id != null) {
        cities = await repo.getCities(house.state!.id);
      }
      if (house.city?.id != null) {
        neighborhoods = await repo.getNeighborhoods(house.city!.id);
      }

      if (ref.mounted) {
        state = AsyncData(
          state.value!.copyWith(
            states: states,
            cities: cities,
            neighborhoods: neighborhoods,
            isLoadingLocations: false,
          ),
        );
      }
    } catch (e) {
      // print("Error initializing edit: $e");
      if (ref.mounted) {
        state = AsyncData(state.value!.copyWith(isLoadingLocations: false));
      }
    }
  }

  Future<bool> submit({
    int? houseId,
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

      if (houseId != null) {
        await ref.read(houseRepositoryProvider).updateHouse(houseId, request);
      } else {
        await ref.read(houseRepositoryProvider).createHouse(request);
      }

      if (ref.mounted) {
        state = AsyncData(s.copyWith(isSubmitting: false));
      }
      return true;
    } catch (e) {
      // print("Submit Error: $e");
      if (ref.mounted) {
        state = AsyncData(s.copyWith(isSubmitting: false));
      }
      return false;
    }
  }
}
