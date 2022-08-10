// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

//Four states while calling Api
class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Datum> dataProduct;
  const ProductLoadedState({
    required this.dataProduct,
  });
}

class ItemAddingCartState extends ProductState {
  // Product product;
  final List<Datum> dataProduct;
  ItemAddingCartState({
    required this.dataProduct,
    // required this.product,
  });
}

class ItemAddedcartState extends ProductState {
  final List<Datum> dataProduct;
  ItemAddedcartState({
    required this.dataProduct,
  });
}

class ItemDeletingCartState extends ProductState {
  final List<Datum> dataProduct;
  ItemDeletingCartState({
    required this.dataProduct,
  });
}

class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState({
    required this.message,
  });
}
