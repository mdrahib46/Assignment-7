import 'package:flutter/material.dart';
import 'CartPage.dart';
import 'ProductList.dart';
import 'stylePage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductList(),
  ));
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  void buyNow(Product product) {
    setState(
          () {
        product.quantity++;
        if (product.quantity == 5) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Congratulations!'),
                content: Text('You\'ve bought 5 ${product.name}s !', style: kAlertTxtStyle),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name, style: kTitleStyle,),
            subtitle: Text(
              '\$${product.price.toStringAsFixed(2)}', style: kSubTitleStyle,),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: ${product.quantity}', style: kCounterTxtStyle,),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    buyNow(product);
                  },
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.blue),
                    child: const Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartPage(products: products)));
          },
          child: const Icon(Icons.shopping_cart),
    ),);
  }
}
