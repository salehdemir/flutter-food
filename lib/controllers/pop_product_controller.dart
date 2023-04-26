import 'package:flutter/material.dart';
import 'package:flutter_ui_project/data/repository/popular_product_repo.dart';
import 'package:flutter_ui_project/utils/colors.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/products_models.dart';
import 'card_controller.dart';

class PopProductController extends GetxController{
 final PopularProductRepo popularProductRepo;
 PopProductController({required this.popularProductRepo});
 List<ProductModel> _popularProductList =[];
//    ProductModel
List<ProductModel> get poplarProductList => _popularProductList;
late CartController _cart;

bool _isLoaded = false;
bool get isLoaded => _isLoaded;

int _quantity=0;
int get quantity=>_quantity;
int _inCardItems = 0;
 int get inCardItems => _inCardItems + _quantity;

 Future<void> getPopularProductList () async {
   Response response= await popularProductRepo.getPopularProductRepoList();
   if(response.statusCode==200 ){

     _popularProductList =[];
     _popularProductList.addAll(Product.fromJson(response.body).products);

_isLoaded = true;
     update();
   }else{}
 }

 void setQuantity(bool isIncrement){
   if(isIncrement){
     _quantity= checkQuantity(_quantity+1);
     // print('number of items '+ _quantity.toString());
   }else{
     _quantity= checkQuantity(_quantity-1);
     // print('decrement' +_quantity.toString());
   }
   update();
 }

 int checkQuantity(int quantity){
   if ((_inCardItems +quantity)<0){
     Get.snackbar('Item Count', 'You can not reduce more!',
     backgroundColor: AppColors.mainColor,
         colorText: Colors.white);

     if(_inCardItems>0){
       _quantity = -_inCardItems;
       return  _quantity;
     }

     return 0;
   }else if((_inCardItems +quantity)>20){
     Get.snackbar('Item Count', 'You can not Add more!',
         backgroundColor: AppColors.mainColor,colorText: Colors.white);
     return 20;
   }else{
     return quantity;
   }
 }

 void initProduct(ProductModel product,CartController cart){
   _quantity=0;
   _inCardItems = 0;
   _cart = cart;
   var exist = false;
   exist = _cart.existInCart(product);
   
   // print('Exist or not' + exist.toString());

   if(exist){
   _inCardItems = _cart.getQuantity(product);
   }
   // print('the quantity in the cart is ' + inCardItems.toString());
 }

 void addItem(ProductModel product){
     _cart.addItem(product, _quantity);
     _quantity=0;
     _inCardItems= _cart.getQuantity(product);

     _cart.items.forEach((key, value) {
       print('the id is '  +  value.id.toString() + ' the quantity is '  +  value.quantity.toString());
     });

     update();

 }


 int get totalItems{
   return _cart.totalItems;
 }

 List<CartModel> get getItems {
   return _cart.getItems;
 }

}