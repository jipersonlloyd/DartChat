import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Database/LProducts.dart';
import 'package:full_stack_practice/Model/ProductModel.dart';
import 'package:full_stack_practice/Server/SProducts.dart';
import 'package:get/get.dart';
class ProductController extends GetxController {
  List<ProductModel> productList = [];
  DatabaseController dbaseController = Get.find();

  Future<void> insertProducts() async {
    // Map<String, dynamic> result = await LProducts.checkData(dbaseController.dbase!);
    // if (result['status']) {
    //   debugPrint('update Product List');
    //   productList.clear();
    //   debugPrint('productListmustCleared: ${productList.map((e) => e.productName)}');
    //   updateProductList = result['value'];
    // } else {
      productList.clear();
      update();
      await LProducts.deleteProducts(dbaseController.dbase!);
      var res = await SProducts.getProducts();
      List<ProductModel> list = res['value'];
      updateProductList = res['value'];
      for (int i = 0; i < list.length; i++) {
        await LProducts.insertProducts(dbaseController.dbase!, list[i]);
        debugPrint('Inserting Products: $i');
      }
    // }
  }

  set updateProductList(List<ProductModel> updateList) {
    productList = updateList;
    update();
  }
}
