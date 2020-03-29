import 'package:flutter/material.dart';
import '../providers/product.dart';

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

  void _updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    print(_editedProduct.id);
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              })
        ],
      ),
      body: Padding(
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
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide a Title';
                        return null;
                      },
                      onSaved: (value) => _editedProduct = Product(
                          id: _editedProduct.id,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl),
                    ),
                    TextFormField(
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
                        if (value.isEmpty) return 'Please provide a Price';
                        if (value == '0') return 'Price can\'t be \$0';
                        return null;
                      },
                      onSaved: (value) => _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value),
                          imageUrl: _editedProduct.imageUrl),
                    ),
                    TextFormField(
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
                        // if (value == '0') return 'Price can\'t be \$0';
                        return null;
                      },

                      onSaved: (value) => _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value,
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
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              ' Image Preview ',
                                              textScaleFactor: 0.8,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.white,
                                                // fontSize: 150,
                                                backgroundColor: Colors.black54,
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
                            decoration: InputDecoration(labelText: 'Image URL'),
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
                              // if (value == '0') return 'Price can\'t be \$0';
                              return null;
                            },
                            onSaved: (value) => _editedProduct = Product(
                                id: _editedProduct.id,
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