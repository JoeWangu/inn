import 'package:dio/dio.dart';
import 'package:inn/core/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/network/dio_provider.dart';
import 'package:inn/data/models/paginated_response.dart';
import 'package:inn/data/models/house_model.dart';

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

  // We use @GET to fetch data
  // We use @Query to pass the '?page=1' parameter
  @GET(Constants.rentals)
  Future<PaginatedResponse<HouseModel>> fetchHouses({
    @Query('page') int page = 1,
  });
}