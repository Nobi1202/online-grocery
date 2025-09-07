import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/data/models/params/update_a_cart_params.dart';
import 'package:online_grocery/data/models/request/cart_item_schema.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_bloc.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_event.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/shared/app_button.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';
import 'package:online_grocery/presentation/theme/color_schemes.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartBloc>(param1: FailureMapper(context)),
      child: const _CartScreenView(),
    );
  }
}

class _CartScreenView extends StatelessWidget {
  const _CartScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemCount: state.cartItems?.listOfCartItems.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = state.cartItems?.listOfCartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 27),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: item?.thumbnail ?? '',
                                height: 55.h,
                                width: 30.w,
                              ),
                              SizedBox(width: 40.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item?.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              OnDeleteCartItemEvent(
                                                item?.id ?? 0,
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text('1kg, Price')],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              OnUpdateCartItemEvent(
                                                UpdateACartParams(
                                                  id: 15,
                                                  cartItemSchema:
                                                      CartItemSchema(
                                                        merge: false,
                                                        products: [
                                                          ProductItemSchema(
                                                            id: item?.id ?? 0,
                                                            quantity:
                                                                item!.quantity -
                                                                1,
                                                          ),
                                                        ],
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 45.w,
                                            height: 45.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17.r),
                                              border: Border.all(
                                                color: AppColorSchemes.cGrey1,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '-',
                                              style: AppTypography.tBlack18W600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          item?.quantity.toString() ?? '',
                                          style: AppTypography.tBlack18W600,
                                        ),
                                        SizedBox(width: 10.w),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              OnUpdateCartItemEvent(
                                                UpdateACartParams(
                                                  id: 15,
                                                  cartItemSchema:
                                                      CartItemSchema(
                                                        merge: false,
                                                        products: [
                                                          ProductItemSchema(
                                                            id: item?.id ?? 0,
                                                            quantity:
                                                                item!.quantity +
                                                                1,
                                                          ),
                                                        ],
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 45.w,
                                            height: 45.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17.r),
                                              border: Border.all(
                                                color: AppColorSchemes.cGrey1,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+',
                                              style: AppTypography.tBlack18W600,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '\$${item?.price.toString() ?? ''}',
                                          style: AppTypography.tBlack18W600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
              Positioned(
                bottom: 30.h,
                left: 25.h,
                right: 25.h,
                child: AppButton(
                  content: "Go to Checkout",
                  onTap: () {},
                  width: context.width - 50.w,
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
                  context.read<CartBloc>().add(OnClearCartItemsErrorEvent());
                },
              );
            }
          }
        },
      ),
    );
  }
}
