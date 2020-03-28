import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' as si;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'ORDER NOW !',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => si.CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
