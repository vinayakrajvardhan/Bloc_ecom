import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ecom/bloc/bloc/product_bloc.dart';

import '../elements/error.dart';
import '../elements/list.dart';
import '../elements/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, req}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductBloc? productBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc?.add(FetchProductEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loadingData = true;
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductInitial) {
          loadingData = true;
        } else if (state is ProductLoadingState) {
          loadingData = true;
        } else if (state is ProductLoadedState) {
          loadingData = false;
        }
        if (state is ItemAddedcartState) {
          loadingData = false;
        }
        if (state is ItemDeletedCartEvent) {
          loadingData = false;
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductInitial) {
          return buildLoading();
        } else if (state is ProductLoadingState) {
          return buildLoading();
        } else if (state is ProductLoadedState) {
          return SafeArea(
              child: OrientationBuilder(builder: (context, orientation) {
            return Scaffold(
              appBar: MediaQuery.of(context).orientation == Orientation.portrait
                  ? AppBar(
                      centerTitle: true,
                      title: Text("Shopping Mall"),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                        )
                      ],
                    )
                  : AppBar(
                      centerTitle: true,
                      title: Text("Shopping Mall"),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                        )
                      ],
                    ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildHintsList(state.dataProduct),
              ),
            );
          }));
        } else if (state is ProductErrorState) {
          return buildError(state.message);
        }
        return Container();
      }),
    );
  }
}
