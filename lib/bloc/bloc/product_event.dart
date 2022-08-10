// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvents extends ProductEvent {}

class ItemAddingCartEvent extends ProductEvent {
  List<Datum>? cartItems;
  ItemAddingCartEvent({
    this.cartItems,
  });
}

class ItemAddedCartEvent extends ProductEvent {
  List<Datum> cartItems;
  ItemAddedCartEvent({
    required this.cartItems,
  });
}

class ItemDeletedCartEvent extends ProductEvent {
  List<Datum> cartItems;
  int index;
  ItemDeletedCartEvent({
    required this.cartItems,
    required this.index,
  });
}
