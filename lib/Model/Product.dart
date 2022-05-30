class Product{
  int? id;
  String name;
  String des;
  String imageUrl;
  double price;
  bool stok;

  Product({ this.id,required  this.name,required  this.des,required  this.imageUrl,required  this.price,required  this.stok});


  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      id: json["id"]!=null?int.parse(json["id"]):0,
      name: json["name"] as String,
      des: json["des"]??"",
      stok: json["stok"]!=null?json["stok"].toLowerCase() == 'true':false,
      price: json["price"]!=null?double.parse(json["price"]):0.0,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'des': des,
    'name': name,
    'price':price.toString(),
    'imageUrl':imageUrl,
    'stok':stok.toString()
  };

}