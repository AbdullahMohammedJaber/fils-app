import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/product/item_product.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/global_function/number_format.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductListModel? productListModel;
  final bool isAuction;
  final bool isGrid;

  const ProductItemWidget(
    this.isGrid, {
    super.key,
    this.productListModel,

    required this.isAuction,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ToWithFade(
          AppRoutes.detailsProductRoot,
          arguments: widget.productListModel!.id!,
        );
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: white),
            ),
            elevation: 0.1,
            color: getTheme() ? Colors.black : white,

            child: Container(
              width: width * 0.5,
              height: heigth * 0.41,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heigth * 0.011),
                  Stack(
                    children: [
                      SizedBox(
                        height: heigth * 0.26,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),

                          child: CachedNetworkImage(
                            imageUrl: widget.productListModel!.thumbnailImage,
                            placeholder: (context, url) => const LoadingUi(),
                            errorWidget:
                                (context, url, error) => Image.asset(
                                  "assets/images/fils_logo_f.png",
                                ),

                            width: width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: heigth * 0.02,
                        right: 8,
                        child: GestureDetector(
                          onTap: () async {
                            bool fav = await context
                                .read<FavoritesCubit>()
                                .addRemoveFavorites(
                                  idProduct: widget.productListModel!.id!,
                                  is_favorite:
                                      widget.productListModel!.is_favorite!,
                                  type: widget.isAuction ? 1 : 0,
                                );
                            setState(() {
                              widget.productListModel!.is_favorite = fav;
                            });
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              widget.productListModel!.is_favorite!
                                  ? "assets/icons/fav_fill.svg"
                                  : "assets/icons/favourite_home.svg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heigth * 0.011),
                  DefaultText(
                    widget.productListModel!.name,
                    color: getTheme() ? white : blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: heigth * 0.011),
                  if (widget.productListModel!.shop_name != null)
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/store_nav.svg"),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: DefaultText(
                            widget.productListModel!.shop_name,
                            color: getTheme() ? white : textColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: heigth * 0.001),
                  widget.productListModel!.current_stock == 0 &&
                          widget.productListModel!.current_stock != null
                      ? Container(
                        width: width,
                        height: heigth * 0.05,
                        color: error.withOpacity(0.3),
                        child: Center(
                          child: DefaultText("Out of stock".tr(), color: error),
                        ),
                      )
                      : widget.isAuction
                      ? SizedBox()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultText(
                            widget.productListModel!.mainPrice,
                            color: secondColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),

          extractDouble(widget.productListModel!.discount) == 0
              ? const SizedBox()
              : PositionedDirectional(
                top: 4,
                end: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: DefaultText(
                    "${widget.productListModel!.discount}",
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
          if (widget.productListModel!.shop_logo != null)
            PositionedDirectional(
              bottom: widget.isGrid ? heigth * 0.14 : heigth * 0.14,
              end: 12,
              child: Container(
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.productListModel!.shop_logo,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Image.asset("assets/icons/fils.png"),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
