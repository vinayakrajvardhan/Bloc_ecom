import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ecom/bloc/bloc/product_bloc.dart';
import 'package:task_ecom/data/model/product.dart';
import 'package:task_ecom/ui/shopping_cart.dart';

Widget buildHintsList(List<Datum> data_products) {
  final ScrollController _scrollController = ScrollController();
  return OrientationBuilder(builder: (context, orientation) {
    final isLandscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (isLandscapeMode) {
      return landscapeGrid(
          _scrollController, context, orientation, data_products);
    } else {
      return potraitGrid(
          _scrollController, context, orientation, data_products);
    }
  });
}

GridView landscapeGrid(ScrollController _scrollController, BuildContext context,
    Orientation orientation, List<Datum> data_products) {
  return GridView.builder(
      controller: _scrollController..addListener(() {}),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 600,
          childAspectRatio: 1.2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: data_products.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ProductBloc>(),
                  child: MyCartPage(
                    productData: data_products[index],
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Image.network(
                      data_products[index].featuredImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(data_products[index].title),
                        ),
                        Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProductBloc>(),
                                    child: MyCartPage(
                                      productData: data_products[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

GridView potraitGrid(ScrollController _scrollController, BuildContext context,
    Orientation orientation, List<Datum> data_products) {
  return GridView.builder(
      controller: _scrollController..addListener(() {}),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: data_products.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ProductBloc>(),
                  child: MyCartPage(
                    productData: data_products[index],
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Image.network(
                      data_products[index].featuredImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(data_products[index].title),
                        ),
                        Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProductBloc>(),
                                    child: MyCartPage(
                                      productData: data_products[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
