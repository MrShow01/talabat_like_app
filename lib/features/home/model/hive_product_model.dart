import 'package:hive_ce/hive.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? price;
  @HiveField(4)
  double? rating;
  @HiveField(5)
  String? category;
  @HiveField(6)
  int? ratingsCount;
  @HiveField(7)
  String? image;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.rating,
    this.category,
    this.ratingsCount,
    this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    category = json['category'];
    ratingsCount = json['ratingsCount'];
    image = json['image'];
  }
}
