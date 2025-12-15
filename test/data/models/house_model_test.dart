import 'package:flutter_test/flutter_test.dart';
import 'package:inn/data/models/house_model.dart';

void main() {
  group('HouseModel', () {
    final tHouseModel = HouseModel(
      id: 1,
      price: 1500.0,
      totalUnits: 2,
      datePosted: DateTime.parse("2023-12-01T10:00:00.000"),
      dateModified: DateTime.parse("2023-12-01T10:00:00.000"),
      available: true,
      isActive: true,
      avgRating: 4.5,
      authorDetail: const AuthorDetail(id: 1, username: 'owner'),
      title: 'Luxury Villa',
      description: 'A beautiful place',
      category: 'Villa',
      image: 123,
      country: const Country(id: 1, name: 'Country'),
      state: const StateData(id: 1, name: 'State', country: 1),
      city: const City(id: 1, name: 'City', country: 1, state: 1),
      neighborhood: const Neighborhood(id: 1, name: 'Hood', city: 1),
    );

    test('fromJson returns a valid model', () {
      final Map<String, dynamic> json = {
        "id": 1,
        "price": 1500.0,
        "total_units": 2,
        "title": "Luxury Villa",
        "description": "A beautiful place",
        "category": "Villa",
        "date_posted": "2023-12-01T10:00:00.000",
        "date_modified": "2023-12-01T10:00:00.000",
        "available": true,
        "is_active": true,
        "avg_rating": 4.5,
        "image": 123,
        "author_detail": {"id": 1, "username": "owner"},
        "country": {"id": 1, "name": "Country"},
        "state": {"id": 1, "name": "State", "country": 1},
        "city": {"id": 1, "name": "City", "country": 1, "state": 1},
        "neighborhood": {"id": 1, "name": "Hood", "city": 1},
      };

      final result = HouseModel.fromJson(json);

      expect(result, tHouseModel);
    });

    test('toJson returns a valid json map', () {
      final result = tHouseModel.toJson();

      expect(result['id'], 1);
      expect(result['price'], 1500.0);
      expect(result['total_units'], 2);
      expect(result['title'], 'Luxury Villa');
    });
  });
}
