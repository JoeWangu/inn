import 'package:dio/dio.dart';
import 'dart:io';
import 'package:inn/core/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/network/dio_provider.dart';
import 'package:inn/data/models/paginated_response.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/data/models/create_house_request.dart';
import 'package:inn/data/models/favorite_model.dart';
import 'package:inn/data/models/rating_model.dart';
import 'package:inn/data/models/extra_image_model.dart';

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

  @GET("${Constants.rentals}{id}/")
  Future<HouseModel> getHouse(@Path('id') int id);

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

  // --- Favorites ---

  @GET(Constants.favorites)
  Future<PaginatedResponse<FavoriteModel>> getFavorites();

  @POST(Constants.favorites)
  Future<FavoriteModel> addFavorite(@Body() Map<String, dynamic> body);

  @DELETE("${Constants.favorites}{id}/")
  Future<void> deleteFavorite(@Path('id') int id);

  // --- Ratings ---

  @GET(Constants.ratings)
  Future<PaginatedResponse<RatingModel>> getRatings();

  @POST(Constants.ratings)
  Future<RatingModel> addRating(@Body() Map<String, dynamic> body);

  @PUT("${Constants.ratings}{id}/")
  Future<RatingModel> updateRating(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("${Constants.ratings}{id}/")
  Future<void> deleteRating(@Path('id') int id);

  // --- Extra Images ---

  @GET(Constants.extraImagesEndpoint)
  Future<PaginatedResponse<ExtraImageModel>> getExtraImages({
    @Query('rental') int? rentalId,
  });

  @POST(Constants.extraImagesEndpoint)
  @MultiPart()
  Future<List<ExtraImageModel>> uploadExtraImages({
    @Part(name: "rental") required int rental,
    @Part(name: "images") required List<File> images,
  });

  @DELETE("${Constants.extraImagesEndpoint}{id}/")
  Future<void> deleteExtraImage(@Path('id') int id);
}
