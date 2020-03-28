import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final productsData=Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ;
            },
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: ListView.builder(itemBuilder: (ctx,i)=> , itemCount: productsData.items.length,),),
    );
  }
}
