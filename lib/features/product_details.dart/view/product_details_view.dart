// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocSelector;
import 'package:productapp/features/product_details.dart/cubit/product_details_cubit.dart';
import 'package:adept_log/view/adept_log.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  late ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();

  double get discountedPrice =>
      cubit.productMdl.price -
      (cubit.productMdl.price * cubit.productMdl.discountPercentage / 100);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            floating: true,
            snap: true,
            pinned: false,
            elevation: 0,
            backgroundColor: theme.appBarTheme.backgroundColor,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Container(height: 80, color: theme.colorScheme.primary),
                        Expanded(
                          child: Container(
                            color: theme.scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: cubit.productMdl.images.length,
                            onPageChanged: (index) => cubit.changePage(index),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(30),
                                child: Image.network(
                                  cubit.productMdl.images[index],
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child:
                                BlocSelector<
                                  ProductDetailsCubit,
                                  ProductDetailsState,
                                  int
                                >(
                                  selector: (state) => cubit.currentPage,
                                  builder: (context, currentPage) {
                                    AdeptLog.d(currentPage);
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        cubit.productMdl.images.length,
                                        (index) => AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          height: 8,
                                          width: currentPage == index ? 18 : 8,
                                          decoration: BoxDecoration(
                                            color: currentPage == index
                                                ? theme.colorScheme.onSurface
                                                : theme.colorScheme.onSurface
                                                      .withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child:
                    BlocSelector<
                      ProductDetailsCubit,
                      ProductDetailsState,
                      bool
                    >(
                      selector: (state) => cubit.productMdl.isFavorite,
                      builder: (context, isFavorite) {
                        AdeptLog.d(isFavorite);
                        return GestureDetector(
                          onTap: () => cubit.toggleFavorite(),
                          child: CircleAvatar(
                            backgroundColor:
                                theme.cardTheme.color ??
                                theme.colorScheme.surface,
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: theme.colorScheme.error,
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.productMdl.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cubit.productMdl.brand ?? "",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(cubit.productMdl.rating.toStringAsFixed(1)),
                      const SizedBox(width: 8),
                      Text(
                        "(${cubit.productMdl.reviews.length} reviews)",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${discountedPrice.toStringAsFixed(0)}",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (cubit.productMdl.discountPercentage > 0)
                        Text(
                          "₹ ${cubit.productMdl.price.toStringAsFixed(0)}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (cubit.productMdl.discountPercentage > 0)
                    Text(
                      "${cubit.productMdl.discountPercentage.toStringAsFixed(0)}% OFF",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 16),
                  _statusChip(
                    cubit.productMdl.stock > 0 ? "In Stock" : "Out of Stock",
                    cubit.productMdl.stock > 0
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.error,
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle("Description", theme),
                  const SizedBox(height: 8),
                  Text(
                    cubit.productMdl.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle("Product Information", theme),
                  const SizedBox(height: 10),
                  _infoTile("Category", cubit.productMdl.category, theme),
                  _infoTile("SKU", cubit.productMdl.sku, theme),
                  _infoTile("Weight", "${cubit.productMdl.weight} g", theme),
                  _infoTile(
                    "Dimensions",
                    "${cubit.productMdl.dimensions.width} x "
                        "${cubit.productMdl.dimensions.height} x "
                        "${cubit.productMdl.dimensions.depth}",
                    theme,
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle("Warranty & Shipping", theme),
                  const SizedBox(height: 10),
                  _infoTile(
                    "Warranty",
                    cubit.productMdl.warrantyInformation,
                    theme,
                  ),
                  _infoTile(
                    "Shipping",
                    cubit.productMdl.shippingInformation,
                    theme,
                  ),
                  _infoTile(
                    "Return Policy",
                    cubit.productMdl.returnPolicy,
                    theme,
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle("Tags", theme),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: cubit.productMdl.tags
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              e,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle("Customer Reviews", theme),
                  const SizedBox(height: 12),
                  ...cubit.productMdl.reviews.map(
                    (e) => Card(
                      elevation: 0,
                      color: theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(e.rating.toString()),
                                const Spacer(),
                                Text(
                                  e.date,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(e.comment),
                            const SizedBox(height: 6),
                            Text(
                              "- ${e.reviewerName}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _infoTile(String title, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
