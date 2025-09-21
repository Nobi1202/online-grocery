import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/presentation/bloc/explore/explore_bloc.dart';
import 'package:online_grocery/presentation/bloc/explore/explore_event.dart';
import 'package:online_grocery/presentation/bloc/explore/explore_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(FailureMapper(context)),
      child: const _ExploreScreenView(),
    );
  }
}

class _ExploreScreenView extends StatefulWidget {
  const _ExploreScreenView();

  @override
  State<_ExploreScreenView> createState() => _ExploreScreenViewState();
}

class _ExploreScreenViewState extends State<_ExploreScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore')),
      body: BlocConsumer<ExploreBloc, ExploreState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: state.productCategories.length,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          RouteName.exploreProducts,
                          extra: state.productCategories[index].slug,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: getRandomColor(),
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: getRandomBorderColor()),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp',
                              width: 110.w,
                              height: 74.h,
                              placeholder: (context, url) =>
                                  const SizedBox.shrink(),
                              errorWidget: (context, url, error) =>
                                  const SizedBox.shrink(),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              state.productCategories[index].name,
                              style: AppTypography.tBlack18W600,
                            ),
                          ],
                        ),
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
                  context.read<ExploreBloc>().add(OnClearErrorEvent());
                },
              );
            }
          }
        },
      ),
    );
  }

  /// Random Color
  Color getRandomColor() {
    return Color(Random().nextInt(0xFFFFFFFF));
  }

  /// Random border color
  Color getRandomBorderColor() {
    return Color(Random().nextInt(0xFFFFFFFF));
  }
}
