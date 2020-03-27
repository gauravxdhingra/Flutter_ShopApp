import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  // const CartItem({Key key}) : super(key: key);
  final String id;
  final double price;
  final int qty;
  final String title;

  const CartItem({this.id, this.price, this.qty, this.title});
  //  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Text('\$$price'),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * qty}'),
          trailing: Text('$qty X'),
        ),
      ),
    );
  }
}
