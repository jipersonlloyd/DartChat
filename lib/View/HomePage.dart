// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/ProductController.dart';
import 'package:full_stack_practice/View/ProductAdapter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ProductController>(
        builder: (controller) => productController.productList.isNotEmpty
        ? ListView.builder(
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            return ProductAdapter(
                productModel: productController.productList[index]);
          },
        )
        : const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
