// ignore_for_file: unnecessary_new

class ProductModel {
  List<Products>? products;

  ProductModel({this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  double? rating;
  String? category;
  int? ratingsCount;
  String? image;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.rating,
      this.category,
      this.ratingsCount,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    category = json['category'];
    ratingsCount = json['ratingsCount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['rating'] = rating;
    data['category'] = category;
    data['ratingsCount'] = ratingsCount;
    data['image'] = image;
    return data;
  }
}
