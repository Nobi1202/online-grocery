import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/presentation/bloc/shop/shop_bloc.dart';
import 'package:online_grocery/presentation/bloc/shop/shop_event.dart';
import 'package:online_grocery/presentation/bloc/shop/shop_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';
import 'package:online_grocery/presentation/theme/color_schemes.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc(FailureMapper(context)),
      child: const ShopScreenView(),
    );
  }
}

class ShopScreenView extends StatefulWidget {
  const ShopScreenView({super.key});

  @override
  State<ShopScreenView> createState() => _ShopScreenViewState();
}

class _ShopScreenViewState extends State<ShopScreenView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Shop')),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  shrinkWrap: true,
                  itemCount:
                      state.categorizedProducts?.categorizedProducts.length ??
                      0,
                  itemBuilder: (context, index) {
                    final category =
                        state.categorizedProducts?.categorizedProducts[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category?.categoryName ?? '',
                          style: AppTypography.tBlack18W600,
                        ),
                        SizedBox(
                          height: 250.h,
                          width: ScreenUtil().screenWidth,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: category?.products.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    RouteName.productDetail,
                                    extra: category?.products[index].id,
                                  );
                                },
                                child: Container(
                                  width: (ScreenUtil().screenWidth - 65.w) / 2,
                                  decoration: BoxDecoration(
                                    color: AppColorSchemes.cWhite,
                                    borderRadius: BorderRadius.circular(18.r),
                                    border: Border.all(
                                      color: AppColorSchemes.cGrey3,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        width: 97.h,
                                        height: 74.h,
                                        imageUrl:
                                            category
                                                ?.products[index]
                                                .thumbnail ??
                                            '',
                                        placeholder: (context, url) =>
                                            const SizedBox.shrink(),
                                        errorWidget: (context, url, error) =>
                                            const SizedBox.shrink(),
                                      ),
                                      Text(
                                        category?.products[index].title ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.tBlack18W600,
                                      ),
                                      Text(
                                        category?.products[index].weight
                                                .toString() ??
                                            '',
                                        style: AppTypography.tBlack18W600,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            category?.products[index].price
                                                    .toString() ??
                                                '',
                                            style: AppTypography.tBlack18W600,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColorSchemes.cGreen,
                                              borderRadius:
                                                  BorderRadius.circular(18.r),
                                            ),
                                            padding: EdgeInsets.all(10.w),
                                            child: Icon(
                                              Icons.add,
                                              color: AppColorSchemes.cWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                ),
              ),
            ],
          ),
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
                context.read<ShopBloc>().add(OnClearShopErrorEvent());
              },
            );
          }
        }
      },
    );
  }
}
