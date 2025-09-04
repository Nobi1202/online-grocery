import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/presentation/bloc/explore_products/explore_products_bloc.dart';
import 'package:online_grocery/presentation/bloc/explore_products/explore_products_event.dart';
import 'package:online_grocery/presentation/bloc/explore_products/explore_products_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';
import 'package:online_grocery/presentation/theme/color_schemes.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class ExploreProductsScreen extends StatelessWidget {
  const ExploreProductsScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreProductsBloc(FailureMapper(context))
            ..add(OnGetAllProductsByCategoryEvent(category)),
      child: const _ExploreProductsScreenView(),
    );
  }
}

class _ExploreProductsScreenView extends StatefulWidget {
  const _ExploreProductsScreenView();

  @override
  State<_ExploreProductsScreenView> createState() =>
      _ExploreProductsScreenViewState();
}

class _ExploreProductsScreenViewState
    extends State<_ExploreProductsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Products'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<ExploreProductsBloc, ExploreProductsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount:
                      state
                          .productCategoryDetails
                          ?.listOfProductCategoryDetail
                          .length ??
                      0,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final product = state
                        .productCategoryDetails
                        ?.listOfProductCategoryDetail[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColorSchemes.cWhite,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: AppColorSchemes.cGrey3),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CachedNetworkImage(
                            imageUrl: product?.thumbnail ?? '',
                            placeholder: (context, url) =>
                                const SizedBox.shrink(),
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            product?.title ?? '',
                            style: AppTypography.tBlack18W600,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            product?.weight.toString() ?? '',
                            style: AppTypography.tBlack18W600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                product?.price.toString() ?? '',
                              ),
                              Icon(Icons.add, color: AppColorSchemes.cBlack1),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.isLoading) {
            CommonDialogs.showLoadingDialog(context);
          } else {
            CommonDialogs.hideLoadingDialog(context);
            if (state.apiError != null) {
              CommonDialogs.showErrorDialog(
                context: context,
                title: 'Error',
                message: state.apiError!,
                onTap: () {
                  context.read<ExploreProductsBloc>().add(
                    OnClearExploreProductsErrorEvent(),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
