class InputModelProducts {
  final int? categoryId;
  final FILTER_PRODUCTS? filterProducts;

  InputModelProducts({this.categoryId, this.filterProducts});
}

enum FILTER_PRODUCTS {
  TOP_SALE,
  NEW,
  DISCOUNT,
}
