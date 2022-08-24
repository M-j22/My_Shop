import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1
                            ?.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(), cart.totalAmount);

                    cart.clear();
                  },
                  child: Text('ORDER NOW'),
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, i) => CartItem(
            id: cart.items.values.toList()[i].id,
            productId: cart.items.keys.toList()[i],
            title: cart.items.values.toList()[i].title,
            quantity: cart.items.values.toList()[i].quantity,
            price: cart.items.values.toList()[i].price,
          ),
          itemCount: cart.items.length,
        ))
      ]),
    );
  }
}
