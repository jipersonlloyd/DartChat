// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_practice/Model/ProductModel.dart';

class ProductAdapter extends StatelessWidget {
  ProductAdapter({super.key, required this.productModel});
  ProductModel productModel;

  Image convertBase64StringtoImage(Uint8List imageString) {
    String image = utf8.decode(imageString);
    Uint8List bytesImage = const Base64Decoder().convert(image);
    return Image.memory(bytesImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                offset: Offset(1, 0),
                blurRadius: 1)
          ]),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: SizedBox(
              height: 80,
              width: 80,
              child: convertBase64StringtoImage(productModel.imageString!),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      productModel.productName!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Price:'),
                      Text(productModel.price!.toStringAsFixed(2)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Stocks:'),
                      Text('${productModel.stocks}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
