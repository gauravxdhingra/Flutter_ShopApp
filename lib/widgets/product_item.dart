import 'package:flutter/material.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({Key key}) : super(key: key);

  final String id;
  final String title;
  final double price;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ProductDetailsScreen(),
            ),
          ),
        ),
        header: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
          backgroundColor: Colors.black87,
          title: Text(
            '\$ $price',
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
