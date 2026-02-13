import 'package:adept_log/view/adept_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productapp/app/app_data.dart';
import 'package:productapp/common/widget.dart/scr_msg_widget.dart';
import 'package:productapp/features/product_list/cubit/product_list_cubit.dart';
import 'package:productapp/features/product_list/model/product_mdl.dart';
import 'package:productapp/features/product_list/widget/product_card.dart';
import 'package:productapp/services/app_services.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late final ProductListCubit cubit = context.read<ProductListCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1ED),
      appBar: AppBar(
        title: Text(AppData.credentialsMdl.emailId),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: AppServices.onLogout,
          ),
        ],
      ),

      body: RefreshIndicator(
        key: cubit.refreshKey,
        onRefresh: cubit.getData,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double height = constraints.maxHeight;

            return BlocSelector<
              ProductListCubit,
              ProductListState,
              List<ProductMdl>?
            >(
              selector: (state) => cubit.products,
              builder: (context, products) {
                if (products == null) {
                  return ListView(
                    children: [ScrMsgWidget("Loading....", height: height)],
                  );
                }

                if (products.isEmpty) {
                  return ListView(
                    children: [
                      ScrMsgWidget("No Products Found", height: height),
                    ],
                  );
                }
                AdeptLog.d(products.length, tag: "Product Length");
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 0,
                      ),
                      child: ProductCard(
                        product: product,
                        onTap: () => cubit.onTap(product),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
