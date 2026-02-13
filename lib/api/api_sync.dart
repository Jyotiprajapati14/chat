import 'package:adept_log/view/adept_log.dart';
import 'package:productapp/api/api_endpoint.dart';
import 'package:productapp/api/api_request.dart';
import 'package:productapp/db/db.dart';
import 'package:productapp/db/table_name.dart';
import 'package:productapp/features/product_list/model/product_mdl.dart';

class ApiSync {
  static ApiSync i = ApiSync();
  Future<List<ProductMdl>> products() async {
    try {
      var response = await ApiClient().request(
        endPoint: ApiEndpoint.products,
        method: ApiRequestType.get,
      );
      if (response.isSuccess) {
        var dbData = await DB.inst.select(tableName: TableName.favorites);
        final favoriteIds = dbData.map((e) => e['productId'] as int).toSet();
        final products = (response.data["products"] as List<dynamic>).map((e) {
          final product = ProductMdl.fromJson(e);
          product.isFavorite = favoriteIds.contains(product.id);
          return product;
        }).toList();
        return products;
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
    }
    return [];
  }
}
