import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productapp/api/api_sync.dart';
import 'package:productapp/db/db.dart';
import 'package:productapp/db/table_name.dart';
import 'package:productapp/features/product_list/model/product_mdl.dart';
import 'package:productapp/route/route_name.dart';

class ProductListState {}

class ProductListCubit extends Cubit<ProductListState> {
  final BuildContext context;
  ProductListCubit(this.context) : super(ProductListState());
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  List<ProductMdl>? products;

  Future<void> getData() async {
    products = await ApiSync.i.products();
    emit(ProductListState());
  }

  void toggleFavorite(ProductMdl productMdl) async {
    productMdl.isFavorite = !productMdl.isFavorite;
    if (productMdl.isFavorite) {
      await DB.inst.insert(
        tableName: TableName.favorites,
        map: {'id': productMdl.id, 'productId': productMdl.id},
      );
    } else {
      await DB.inst.delete(
        tableName: TableName.favorites,
        where: 'productId = ?',
        whereArgs: [productMdl.id],
      );
    }
    emit(ProductListState());
  }

  void onTap(ProductMdl mdl) async {
    await Navigator.pushNamed(context, RouteName.productDetail, arguments: mdl);
    emit(ProductListState());
  }
}
