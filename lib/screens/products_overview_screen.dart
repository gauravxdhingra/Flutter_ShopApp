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

class ProductsOverviewScreen extends StatefulWidget {
  // const ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    // var _showOnlyFav = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedVal) {
              // if (selectedVal == FilterOptions.All) {
              //   productsContainer.showFavOnly();
              // } else {
              //   productsContainer.showAll();
              // }

              setState(() {
                if (selectedVal == FilterOptions.Favourites) {
                  _showOnlyFav = true;
                } else
                  _showOnlyFav = false;
              });
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
      body: ProductsGrid(_showOnlyFav),
    );
  }
}
