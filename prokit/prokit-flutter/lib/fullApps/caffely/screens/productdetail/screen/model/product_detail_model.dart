class ProductDetailModel {
  String productName;
  String productPrize;
  String availableIn;
  String size;
  String totalPrize;

  // Constructor with default values
  ProductDetailModel({
    required this.productName,
    required this.productPrize,
    required this.availableIn,
    required this.size,
    required this.totalPrize,
  });

  @override
  String toString() {
    return 'ProductDetailModel{productName: $productName, productPrize: $productPrize, availableIn: $availableIn, size: $size, totalPrize: $totalPrize}';
  }
}
