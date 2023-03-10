//@dart=2.9

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';

class ProductService {
  String baseUrl = "http://192.168.100.10:8000/api";

  Future<List<ProductModel>> getProduct() async {
    var url = "$baseUrl/products";
    var headers = {
      "Content-Type": "application/json",
    };

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      for(var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception("Gagal Mengambil Data Product");
    }
  }
  
}