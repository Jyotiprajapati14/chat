import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productapp/db/db.dart';
import 'package:productapp/db/table_name.dart';
import 'package:productapp/features/product_list/model/product_mdl.dart';

class ProductDetailsState {}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  BuildContext context;
  ProductMdl productMdl;
  int currentPage = 0;
  ProductDetailsCubit({required this.context, required this.productMdl})
    : super(ProductDetailsState());

  void toggleFavorite() async {
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
    emit(ProductDetailsState());
  }

  void changePage(int index) {
    currentPage = index;
    emit(ProductDetailsState());
  }
}
