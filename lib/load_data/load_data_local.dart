import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class LoadDataLocal {
  static void load() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(DetailsAdapter());
    Hive.registerAdapter(AttributesAdapter());
    Hive.registerAdapter(ImageProductAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.openBox(CART);
  }
}