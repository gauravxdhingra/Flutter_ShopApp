import 'package:flutter/material.dart';
import 'package:flutter_udemy_shop_app/widgets/products_grid.dart';
import 'package:flutter_udemy_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

// import '../models/product.dart';
// import '../widgets/product_item.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  // const ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedVal) {
              if (selectedVal == FilterOptions.All) {
                productsContainer.showFavOnly();
              } else {
                productsContainer.showAll();
              }
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
