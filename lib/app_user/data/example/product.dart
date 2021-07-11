import 'package:sahashop_user/app_user/const/const_image_logo.dart';
import 'package:sahashop_user/app_user/model/product.dart';

List<Product> EXAMPLE_LIST_PRODUCT = [
  Product(
    name: "Sản phẩm demo",
    indexImageAvatar: 0,
    description: "Mô tả 1",
    price: 24000000,
    barcode: "Sản phẩm demo",
    status: 0,
    quantityInStock: -1,
    view: 222,
    isNew: true,
    isTopSale: true,
    isFavorite: true,
    distributes: [],
    attributes: [],
    categories: [],
    productDiscount: ProductDiscount(
      value: 50,
      discountPrice: 12000000
    ),
    hasInDiscount: true,
    hasInCombo: true,
    images: [
      ImageProduct(imageUrl: "https://i.imgur.com/hESDRss.jpeg"),
      ImageProduct(imageUrl: "https://i.imgur.com/G4GrO0j.png"),
    ],
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: "https://i.imgur.com/hESDRss.jpeg"),
      ImageProduct(imageUrl: "https://i.imgur.com/G4GrO0j.png"),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: "https://i.imgur.com/hESDRss.jpeg"),
      ImageProduct(imageUrl: "https://i.imgur.com/G4GrO0j.png"),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: logoSahaImage),
      ImageProduct(imageUrl: logoSahaImage),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: logoSahaImage),
      ImageProduct(imageUrl: logoSahaImage),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: logoSahaImage),
      ImageProduct(imageUrl: logoSahaImage),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: logoSahaImage),
      ImageProduct(imageUrl: logoSahaImage),
    ],
    price: 200,
  ),
  Product(
    name: "Sản phẩm 1",
    description: "Mô tả 1",
    images: [
      ImageProduct(imageUrl: logoSahaImage),
      ImageProduct(imageUrl: logoSahaImage),
    ],
    price: 200,
  ),
];
