import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_bloc.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_event.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_state.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_event.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/shared/app_button.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';

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
      appBar: AppBar(title: Text('Favourite')),
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
                                    Text(
                                      item?.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('Price'),
                                  ],
                                ),
                              ),
                              Text('\$${item?.price.toString() ?? ''}'),
                              SizedBox(width: 8.w),
                              InkWell(
                                onTap: () {},
                                child: Icon(Icons.arrow_right),
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
