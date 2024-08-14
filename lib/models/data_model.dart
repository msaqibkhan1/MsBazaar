class DataModel {
  String name;
  String id;
  String price;
  String shopName;
  String category;
  String description;
  String unit;
  String image;
  bool favorite;

  DataModel(
      {required this.name,
      required this.id,
      required this.unit,
      required this.price,
      required this.image,
      required this.favorite,
      required this.category,
      required this.description,
      required this.shopName});
}
