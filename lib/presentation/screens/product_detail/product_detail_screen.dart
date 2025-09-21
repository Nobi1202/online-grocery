import 'package:cached_network_image/cached_network_image.dart';
import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/domain/entities/product_detail_entity.dart';
import 'package:online_grocery/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:online_grocery/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:online_grocery/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';
import 'package:online_grocery/presentation/shared/common_dialogs.dart';
import 'package:chottu_link/dynamic_link/cl_dynamic_link_behaviour.dart';
import 'package:chottu_link/dynamic_link/cl_dynamic_link_parameters.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.id,
    this.isFromDeepLink = false,
  });
  final int id;
  final bool isFromDeepLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(FailureMapper(context))
            ..add(OnGetProductDetailEvent(id)),
      child: _ProductDetailScreenView(id: id, isFromDeepLink: isFromDeepLink),
    );
  }
}

class _ProductDetailScreenView extends StatefulWidget {
  const _ProductDetailScreenView({
    required this.id,
    required this.isFromDeepLink,
  });
  final int id;
  final bool isFromDeepLink;

  @override
  State<_ProductDetailScreenView> createState() =>
      _ProductDetailScreenViewState();
}

class _ProductDetailScreenViewState extends State<_ProductDetailScreenView> {
  int currentImageIndex = 0;

  Future<void> _shareProduct(BuildContext context) async {
    final parameters = CLDynamicLinkParameters(
      link: Uri.parse("https://onlinegrocery.chottu.link/product/${widget.id}"),
      domain: "onlinegrocery.chottu.link",
      androidBehaviour: CLDynamicLinkBehaviour.app,
      iosBehaviour: CLDynamicLinkBehaviour.app,
      // utmCampaign: "share_product",
      // utmSource: "app",
      // utmMedium: "user_share",
      // linkName: "product_${widget.id}",
      // selectedPath: "product/${widget.id}",
      // socialTitle: product.name,
      // socialDescription: product.description,
      // socialImageUrl: product.imageUrl,
    );

    ChottuLink.createDynamicLink(
      parameters: parameters,
      onSuccess: (link) {
        debugPrint("✅ Shared Link: $link");
        SharePlus.instance.share(
          ShareParams(title: "Check out this product", uri: Uri.parse(link)),
        );
      },
      onError: (error) {
        debugPrint("❌ Error creating link: ${error.description}");
        SharePlus.instance.share(
          ShareParams(
            title: "Check out this product",
            uri: Uri.parse(
              "https://onlinegrocery.chottu.link/product/${widget.id}",
            ),
          ),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to share link")));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                if (widget.isFromDeepLink) {
                  context.goNamed(RouteName.bottomTab);
                } else {
                  context.pop();
                }
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await _shareProduct(context);
                },
                icon: const Icon(Icons.share, color: Colors.black),
              ),
            ],
          ),
          body: state.productDetail != null
              ? _buildProductDetailContent(context, state.productDetail!)
              : const Center(
                  child: Text(
                    'No product data available',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
          bottomNavigationBar: state.productDetail != null
              ? _buildBottomBar(context)
              : null,
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
                context.read<ProductDetailBloc>().add(
                  OnClearProductDetailErrorEvent(),
                );
              },
            );
          }
        }
      },
    );
  }

  Widget _buildProductDetailContent(
    BuildContext context,
    ProductDetailEntity product,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCarousel(product.images),
          _buildProductInfo(context, product),
          _buildQuantitySelector(),
          _buildProductDetailSection(product),
          _buildNutritionSection(),
          _buildReviewSection(),
          const SizedBox(height: 100), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildImageCarousel(List<String>? images) {
    final productImages = images ?? [];

    if (productImages.isEmpty) {
      return Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey[200],
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      );
    }

    return Container(
      height: 300,
      color: Colors.blueGrey,
      child: PageView.builder(
        itemCount: productImages.length,
        onPageChanged: (index) {
          setState(() {
            currentImageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(productImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (productImages.length > 1)
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(productImages.length, (index) {
                      return Container(
                        width: index == currentImageIndex ? 10 : 2,
                        height: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: index == currentImageIndex
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context, ProductDetailEntity product) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '1kg, Price',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 20),
              const SizedBox(width: 4),
              Text(
                product.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove, color: Colors.grey),
                  iconSize: 20,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.green),
                  iconSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailSection(ProductDetailEntity product) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ExpansionTile(
            title: const Text(
              'Product Detail',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.keyboard_arrow_down),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text(
          'Nutritions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '100gr',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildReviewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text(
          'Review',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: List.generate(5, (index) {
                return const Icon(Icons.star, color: Colors.orange, size: 16);
              }),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${state.productDetail?.price.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Add To Basket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
