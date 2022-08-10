import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_ecom/data/model/product.dart';

abstract class ProductRepository {
  Future<List<Datum>> getProducts({
    required int page,
  });
}

class ProductRepositoryImp extends ProductRepository {
  int _perPage = 5;
  @override
  Future<List<Datum>> getProducts({
    required int page,
  }) async {
    var url =
        "http://205.134.254.135/~mobile/MtProject/public/api/product_list.php?page=$page&per_page=$_perPage";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Datum> productData = Product.fromJson(data).data;
      return productData;
    } else {
      throw Exception('Failed');
    }
  }
}
