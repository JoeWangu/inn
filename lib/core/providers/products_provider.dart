import 'package:inn/data/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

const List<Product> allProducts = [
  Product(
    id: '1',
    title: 'hotel1',
    price: 500,
    image: 'assets/images/hotel1.jpg',
  ),
  Product(
    id: '2',
    title: 'hotel2',
    price: 100,
    image: 'assets/images/hotel2.jpg',
  ),
  Product(
    id: '3',
    title: 'hotel3',
    price: 200,
    image: 'assets/images/hotel3.jpg',
  ),
  Product(
    id: '4',
    title: 'hotel4',
    price: 100,
    image: 'assets/images/hotel4.jpg',
  ),
  Product(
    id: '5',
    title: 'hotel5',
    price: 600,
    image: 'assets/images/hotel5.jpg',
  ),
  Product(
    id: '6',
    title: 'hotel6',
    price: 100,
    image: 'assets/images/hotel6.jpg',
  ),
  Product(
    id: '7',
    title: 'hotel7',
    price: 500,
    image: 'assets/images/hotel7.jpg',
  ),
  Product(
    id: '8',
    title: 'hotel8',
    price: 300,
    image: 'assets/images/hotel8.jpg',
  ),
];

// final productsProvider = Provider((ref) {
//   return allProducts;
// });

// final reducedProductsProvider = Provider((ref) {
//   return allProducts.where((p) => p.price < 300).toList();
// });

@riverpod
List<Product> products(Ref ref) {
  return allProducts;
}

@riverpod
List<Product> reducedProducts(Ref ref){
  return allProducts.where((p) => p.price < 300).toList();
}