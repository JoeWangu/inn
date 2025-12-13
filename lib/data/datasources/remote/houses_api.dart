import 'package:dio/dio.dart';
import 'dart:io';
import 'package:inn/core/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/network/dio_provider.dart';
import 'package:inn/data/models/paginated_response.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/data/models/create_house_request.dart';

part 'houses_api.g.dart';

// 1. Provider
@riverpod
HousesApi housesApi(Ref ref) {
  final dio = ref.read(dioProvider);
  return HousesApi(dio);
}

// 2. Interface
@RestApi()
abstract class HousesApi {
  factory HousesApi(Dio dio, {String baseUrl}) = _HousesApi;

  // We use @GET to fetch data and @Query to pass the '?page=1' parameter
  @GET(Constants.rentals)
  Future<PaginatedResponse<HouseModel>> fetchHouses({
    @Query('page') int page = 1,
    @Query('search') String? search,
    @Query('min_price') num? minPrice,
    @Query('max_price') num? maxPrice,
    @Query('city') String? city,
    @Query('category') String? category,
  });

  // --- Manage Rentals ---

  @GET(Constants.manageRentals)
  Future<PaginatedResponse<HouseModel>> getMyHouses();

  @POST(Constants.manageRentals)
  Future<HouseModel> createHouse(@Body() CreateHouseRequest house);

  @PUT("${Constants.manageRentals}{id}/")
  Future<HouseModel> updateHouse(
    @Path('id') int id,
    @Body() CreateHouseRequest house,
  );

  @DELETE("${Constants.manageRentals}{id}/")
  Future<void> deleteHouse(@Path('id') int id);

  // --- Location Dropdowns ---

  @GET(Constants.countries)
  Future<PaginatedResponse<Country>> getCountries();

  @GET(Constants.states)
  Future<PaginatedResponse<StateData>> getStates(
    @Query('country') int countryId,
  );

  @GET(Constants.cities)
  Future<PaginatedResponse<City>> getCities(@Query('state') int stateId);

  @GET(Constants.neighborhoods)
  Future<PaginatedResponse<Neighborhood>> getNeighborhoods(
    @Query('city') int cityId,
  );

  // --- Images ---

  @GET(Constants.images)
  Future<PaginatedResponse<ImageDetail>> getImages();

  @POST(Constants.images)
  @MultiPart()
  Future<ImageDetail> uploadImage(@Part(name: "image") File image);
}
