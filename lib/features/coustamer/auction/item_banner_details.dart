import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ItemBannerDetailsAuction extends StatefulWidget {
  final Auction data;

  const ItemBannerDetailsAuction({super.key, required this.data});

  @override
  State<ItemBannerDetailsAuction> createState() =>
      _ItemBannerDetailsAuctionState();
}

class _ItemBannerDetailsAuctionState extends State<ItemBannerDetailsAuction> {
  dynamic selectIndexImage = 0;

  addImage() {
    widget.data.photos.add(
      Photo(path: widget.data.thumbnailImage, variant: ''),
    );
  }

  @override
  void initState() {
    addImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth * 0.6,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () {
                List<String> images = [];
                for (var element in widget.data.photos) {
                  images.add(element.path);
                }
                print(images.length);
                /* ToWithFade(
                    context,
                    ImageView(images: images, initialIndex: selectIndexImage),
                  );*/
              },
              child: CachedNetworkImage(
                imageUrl: widget.data.photos[selectIndexImage].path,
                placeholder: (context, url) => const LoadingUi(),
                errorWidget:
                    (context, url, error) => Image.asset(
                      'assets/test/abaya.png',
                      fit: BoxFit.cover,
                      height: heigth * 0.5,
                      width: double.infinity,
                    ),
                fit: BoxFit.cover,
                height: heigth * 0.6,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: heigth * 0.05,
            left: width * 0.04,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 45,
                    width: 45,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Center(
                      child: FlipView(
                        child: SvgPicture.asset("assets/icons/back.svg"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    bool fav = await context
                        .read<FavoritesCubit>()
                        .addRemoveFavorites(
                          idProduct: widget.data.id!,
                          is_favorite: widget.data.is_favorite,
                          type: 1,
                        );
                    setState(() {
                      widget.data.is_favorite = fav;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    child: Center(
                      child: FlipView(
                        child: SvgPicture.asset(
                          widget.data.is_favorite
                              ? "assets/icons/fav_fill.svg"
                              : "assets/icons/favourite_home.svg",
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    shareAuctionLink(context ,widget.data.id);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: const Center(
                      child: Icon(Icons.share, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: heigth * 0.04,
            right: width * 0.04,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(min(widget.data.photos.length, 5), (index) {
                  final isSelected = selectIndexImage == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndexImage = index;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(bottom: heigth * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isSelected
                                  ? primaryColor
                                  : const Color(0xff898384),
                          width: isSelected ? 2 : 1,
                        ),
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: widget.data.photos[index].path,
                          placeholder: (context, url) => const LoadingUi(),
                          errorWidget:
                              (context, url, error) => Image.asset(
                                'assets/test/abaya.png',
                                fit: BoxFit.cover,
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
