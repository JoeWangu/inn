// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
// class CartNotifier extends Notifier<Set<Product>> {
class CartNotifier extends _$CartNotifier {
  @override
  Set<Product> build() {
    return const {};
  }

  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier();
// });

@riverpod
int cartTotal(Ref ref) {
  final cartProducts = ref.watch(cartProvider);

  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }

  return total;
}
