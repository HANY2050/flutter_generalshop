import 'package:flutter/material.dart';
import 'package:generalshops/modelcart1/cart1.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart1>(builder: (context, cart, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("  RY.${cart.totalPrice} الاجمالي "),
        ),
        body: cart.basketItems.length == 0
            ? Text("no items")
            : ListView.builder(
                itemCount: cart.basketItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(cart.basketItems[index].product_title),
                      subtitle: Text(
                          cart.basketItems[index].product_price.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cart.remove(cart.basketItems[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
