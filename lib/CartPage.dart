import 'package:flutter/material.dart';
import 'ProductList.dart';

class CartPage extends StatelessWidget {
  final List<Product> products;

  const CartPage({super.key, required this.products});

  int getTotalQuantity() {
    int totalQuantity = 0;
    for (var product in products) {
      totalQuantity += product.quantity;
    }
    return totalQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Text(
          'Total Products: ${getTotalQuantity()}',
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
