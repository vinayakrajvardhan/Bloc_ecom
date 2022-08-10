import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ecom/bloc/bloc/product_bloc.dart';
import 'package:task_ecom/database_provider/database_service.dart';
import '../data/model/product.dart';

class MyCartPage extends StatefulWidget {
  final Datum productData;

  const MyCartPage({super.key, required this.productData});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  int _quantity = 1;
  List<Datum> cartItems = [];
  double totalAmount = 0;
  late DBProvider dbProvider;

  void calculateTotalAmount(List<Datum> list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * _quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    List<Datum> _data = [];

    final _size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(builder: ((context, state) {
      if (state is ItemAddedcartState) {
        cartItems = state.dataProduct;
        calculateTotalAmount(cartItems);
      }

      if (state is ItemDeletingCartState) {
        cartItems = state.dataProduct;
        calculateTotalAmount(cartItems);
      }

      if (state is ItemAddingCartState) {
        cartItems = state.dataProduct;
        calculateTotalAmount(cartItems);
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => HomePage())));
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          title: Text("My Cart"),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          height: 68,
          decoration: BoxDecoration(
              color: Colors.lightBlue[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              )),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Total Quantity :'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(_quantity.toString()),
                    Spacer(),
                    Text('Grand Total :'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('\$${widget.productData.price.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Dismissible(
          direction: DismissDirection.endToStart,
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              dbProvider.deleteCart(widget.productData.id);
            });
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Delete Confirmation"),
                  content:
                      const Text("Are you sure you want to delete this item?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _quantity = 0;
                          });
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Delete")),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: _size.height * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Image.network(
                            widget.productData.featuredImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.productData.title),
                                _rowWidget(
                                  widget: widget,
                                  text: "Price",
                                  value: widget.productData.price,
                                ),
                                Row(
                                  children: [
                                    Text("Quantity"),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        calculateTotalAmount(_data);
                                        if (_quantity > 1)
                                          setState(() {
                                            _quantity--;
                                          });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 30,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5)),
                                        child: Text(
                                          _quantity.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        calculateTotalAmount(_data);
                                        setState(() {
                                          _quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

class _rowWidget extends StatelessWidget {
  final String text;
  final num value;
  const _rowWidget({
    Key? key,
    required this.text,
    required this.value,
    required this.widget,
  }) : super(key: key);

  final MyCartPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        Spacer(),
        Text("\$${value}"),
      ],
    );
  }
}
