import 'dart:convert';
import 'package:full_stack_practice/Model/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SProducts {
  static Future<Map<String, dynamic>> getProducts() async {
    List<ProductModel> productList = [];
    Map<String, dynamic> result;
    try {
      String url =
          'http://jipersonlloyd-001-site1.etempurl.com/api/Product/getProducts';

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      var res = json.decode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < res.length; i++) {
          ProductModel productModel = ProductModel(
              productName: res[i]['productName'],
              price: res[i]['price'],
              sold: res[i]['sold'],
              stocks: res[i]['stocks'],
              imageString: Uint8List.fromList(utf8.encode(res[i]['imageString']))
              );
          productList.add(productModel);
        }
        result = {'status': true, 'value': productList};
        return result;
      } else {
        result = {'status': false, 'value': null};
      }
    } catch (e) {
      debugPrint('Error getting Products: $e');
      result = {'status': false, 'value': null};
    }
    return result;
  }
}
