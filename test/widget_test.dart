import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 20.0),
    Product(name: 'Product 3', price: 15.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: CounterButton(
              product: products[index],
              onProductBuy: (Product product) {
                if (product.count == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You\'ve bought 5 ${product.name}!'),
                        actions: [
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int totalProducts = products.fold(0, (sum, product) => sum + product.count);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(totalProducts: totalProducts)),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CounterButton extends StatelessWidget {
  final Product product;
  final Function(Product) onProductBuy;

  CounterButton({required this.product, required this.onProductBuy});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_shopping_cart),
      onPressed: () {
        product.incrementCount();
        onProductBuy(product);
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int count;

  Product({required this.name, required this.price, this.count = 0});

  void incrementCount() {
    count++;
  }
}

class CartPage extends StatelessWidget {
  final int totalProducts;

  CartPage({required this.totalProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: $totalProducts'),
      ),
    );
  }
}
