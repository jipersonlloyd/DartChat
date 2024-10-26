import 'dart:typed_data';

import 'package:full_stack_practice/Database/tblProducts.dart';

class ProductModel{

  int? id;
  String? productName;
  double? price;
  int? sold;
  int? stocks;
  Uint8List? imageString;

  ProductModel({
    this.id,
    this.productName,
    this.price,
    this.sold,
    this.stocks,
    this.imageString
  });


  static ProductModel getDataFromLocal(var json) {
    ProductModel productModel = ProductModel(
      id: json[TblProducts.id],
      productName: json[TblProducts.productName],
      price: double.parse(json[TblProducts.price]),
      stocks: int.parse(json[TblProducts.stocks]),
      sold: int.parse(json[TblProducts.sold]),
      imageString: json[TblProducts.image]
    );
    return productModel;
  }

  static Map<String,dynamic> insertDataToLocal(ProductModel productModel){
    Map<String,dynamic> result = {
      TblProducts.id: productModel.id,
      TblProducts.productName: productModel.productName,
      TblProducts.price: productModel.price,
      TblProducts.stocks: productModel.stocks,
      TblProducts.image: productModel.imageString,
      TblProducts.sold: productModel.sold
    };
    return result;
  }
}