import 'dart:io';
import 'package:inn/data/datasources/remote/houses_api.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_repository.g.dart';

@riverpod
ImageRepository imageRepository(Ref ref) {
  return ImageRepository(ref.read(housesApiProvider));
}

class ImageRepository {
  final HousesApi _api;

  ImageRepository(this._api);

  Future<List<ImageDetail>> getImages() async {
    final response = await _api.getImages();
    return response.results;
  }

  Future<ImageDetail> uploadImage(File image) => _api.uploadImage(image);
}
