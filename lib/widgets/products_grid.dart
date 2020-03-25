import 'package:flutter/material.dart';
import 'package:flutter_udemy_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_udemy_shop_app/widgets/product_item.dart';
// import '../models/product.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            // products[i].price,
            ),
      ),
      itemCount: products.length,
    );
  }
}
