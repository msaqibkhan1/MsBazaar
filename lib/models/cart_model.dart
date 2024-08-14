class CartModel{
  String cartName;
  String cartId;
  String cartPrice;
  String cartShopName;
  String cartUnit;
  String cartImage;
  int count;

  CartModel(
      {required this.cartId,
      required this.cartImage,
      required this.cartName,
      required this.cartPrice,
      required this.cartShopName,
      required this.cartUnit,
      required this.count,});
}
