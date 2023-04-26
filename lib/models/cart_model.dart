
import 'package:flutter_ui_project/models/products_models.dart';

class CartModel {
  int? id;
  int? price;
  String? name;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;


  CartModel(
      {this.id,
        this.price,
        this.name,
        this.img,
        this.quantity,
        this.isExist,
        this.time,
        this.product
        });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);

  }

  Map<String ,dynamic> toJson(){

    return{
      'id':this.id,
      'price':this.price,
      'name':this.name,
      'img':this.img,
      'quantity':this.quantity,
      'isExist':this.isExist,
      'time':this.time,
      'product':this.product!.toJson()
    };
}

}
