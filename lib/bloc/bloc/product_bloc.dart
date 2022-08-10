import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task_ecom/data/model/product.dart';
import '../../data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  int page = 1;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchProductEvents) {
        //  yield ProductLoadingState();
        emit(ProductLoadingState());

        try {
          List<Datum> dataOfProducts =
              await productRepository.getProducts(page: page);
          // yield ProductLoadedState(dataProduct: dataOfProducts);
          emit(ProductLoadedState(dataProduct: dataOfProducts));

          page++;
        } catch (e) {
          //  yield ProductErrorState(message: e.toString());
          emit(ProductErrorState(message: e.toString()));
        }
      }
      if (event is ItemAddingCartEvent) {
        List<Datum> dataOfProducts =
            await productRepository.getProducts(page: page);
        emit(ItemAddingCartState(dataProduct: dataOfProducts, ));
      }

      if (event is ItemAddedCartEvent) {
        List<Datum> dataOfProducts =
            await productRepository.getProducts(page: page);
        emit(ItemAddedcartState(dataProduct: dataOfProducts));
      }

      if (event is ItemDeletedCartEvent) {
        List<Datum> dataOfProducts =
            await productRepository.getProducts(page: page);
        emit(ItemDeletingCartState(dataProduct: dataOfProducts));
      }
    });
  }
}
