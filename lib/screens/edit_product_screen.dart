import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  // EditProductScreen({Key key}) : super(key: key);
  static const routeName = '/edit-products-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocus = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '0',
  );

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImgUrl);

    _priceFocusNode.dispose();
    _descFocus.dispose();
    _imgUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImgUrl);
    super.initState();
  }

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  void _updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') &&
              !_imageUrlController.text.startsWith('www')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    // print(_editedProduct.id);
    // print(_editedProduct.title);
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);

      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(
          context,
          listen: false,
        ).addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error Occured'),
            content: Text(
              'Something went Wrong',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   print('before pop');
      //   Navigator.of(context).pop();
      //   print('after pop');
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 4 / 5,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            initialValue: _initValues['title'],
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please provide a Title';
                              return null;
                            },
                            onSaved: (value) => _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                title: value,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl),
                          ),
                          TextFormField(
                            initialValue: _initValues['price'],
                            decoration: InputDecoration(
                              labelText: 'Price',
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.numberWithOptions(),
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (ctx) {
                              FocusScope.of(context).requestFocus(_descFocus);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please provide a Price';
                              if (double.tryParse(value) == null)
                                return 'Please enter a valid number for Price';
                              if (double.parse(value) <= 0)
                                return 'Please enter a price greater than \$0';
                              return null;
                            },
                            onSaved: (value) => _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: double.parse(value),
                                imageUrl: _editedProduct.imageUrl),
                          ),
                          TextFormField(
                            initialValue: _initValues['description'],
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descFocus,
                            // textInputAction: TextInputAction.next,
                            // // },

                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please provide a Product Description';
                              if (value.length < 10)
                                return 'Should be atleast 10 characters long';
                              return null;
                            },

                            onSaved: (value) => _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: value,
                                isFavorite: _editedProduct.isFavorite,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(
                                  top: 8,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: _imageUrlController.text.isEmpty
                                      ? Text('Enter a URL')
                                      : Stack(
                                          fit: StackFit.expand,
                                          alignment: Alignment.bottomCenter,
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            FittedBox(
                                              fit: BoxFit.cover,
                                              child: Image.network(
                                                _imageUrlController.text,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 3,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    ' Image Preview ',
                                                    textScaleFactor: 0.8,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      // fontSize: 150,
                                                      backgroundColor:
                                                          Colors.black54,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),

                              // ),
                              Expanded(
                                child: TextFormField(
                                  // initialValue: _initValues['imageUrl'],
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  focusNode: _imgUrlFocusNode,
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },

                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'Please provide an Image URL';
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https') &&
                                        !value.startsWith('www'))
                                      return 'Please provide a valid URL';
                                    if (!value.endsWith('.png') &&
                                        !value.endsWith('.jpg') &&
                                        !value.endsWith('.jpeg'))
                                      return 'Please enter a valid Image URL';
                                    return null;
                                  },
                                  onSaved: (value) => _editedProduct = Product(
                                      id: _editedProduct.id,
                                      isFavorite: _editedProduct.isFavorite,
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price,
                                      imageUrl: value),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: FlatButton(
                        padding: EdgeInsets.all(8),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => _saveForm(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      // extendBody: FlatButton(onPressed: (){_saveForm();}, child: null),
    );
  }
}
