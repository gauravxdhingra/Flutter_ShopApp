import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // // const name({Key key}) : super(key: key);

  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    Provider.of<Products>(context)
        .items
        .firstWhere((product) => product.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
