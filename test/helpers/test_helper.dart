import 'package:mockito/annotations.dart';
import 'package:inn/data/datasources/remote/auth_api.dart';
import 'package:inn/data/datasources/remote/houses_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inn/core/database/app_database.dart';
import 'package:inn/domain/repositories/auth_repository.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/domain/repositories/location_repository.dart';
import 'package:inn/domain/repositories/ratings_repository.dart';
import 'package:inn/domain/repositories/favorites_repository.dart';

@GenerateMocks([
  AuthApi,
  HousesApi,
  FlutterSecureStorage,
  AppDatabase,
  AuthRepository,
  HouseRepository,
  LocationRepository,
  RatingsRepository,
  FavoritesRepository,
])
void main() {}
