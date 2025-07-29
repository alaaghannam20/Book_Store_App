
class Products {
    final int id;
  final String name;
  final String description;
  final double price;
  final int discount;
  final double priceAfterDiscount;
  final int stock;
  final int bestSeller;
  final String image;
  final String category;

  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.bestSeller,
    required this.image,
    required this.category,
  });

  factory Products.fromJson(Map<String, dynamic> json){
    return Products(
        id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      discount: json['discount'],
      priceAfterDiscount: json['price_after_discount'].toDouble(),
      stock: json['stock'],
      bestSeller: json['best_seller'],
      image: json['image'],
      category: json['category'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'price_after_discount': priceAfterDiscount,
      'stock': stock,
      'best_seller': bestSeller,
      'image': image,
      'category': category,
    };
  }
}

  
  
