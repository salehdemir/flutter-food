class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel>_products;
  List<ProductModel> get products => _products;

  Product({required totalSize,required typeId,required offset, required products}){
     this._totalSize = totalSize;
     this._typeId = typeId;
     this._offset = offset;
     this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];

    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        // video is product!
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  int? price;
  int? stars;
  int? typeId;
  String? name;
  String? description;
  String? img;
  String? location;
  String? createdAt;
  String? updateAt;

  ProductModel(
      {this.id,

     this.price,
      this.stars,
      this.typeId,
      this.name,
      this.description,
      this.img,
      this.location,
      this.createdAt,
      this.updateAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    stars = json['stars'];
    typeId = json['typeId'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    location = json['location'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson(){
    return{
      'id':this.id,
      'price':this.price,
      'name':this.name,
      'img':this.img,
      'location':this.location,
      'createdAt':this.createdAt,
      'updateAt':this.updateAt,
      'typeId':this.typeId,
    };
  }
}
