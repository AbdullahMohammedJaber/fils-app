import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/flip_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 
import 'package:fils/utils/const.dart';
 

class HeaderImagesSeller extends StatefulWidget {
  final AuctionSeller data;

  const HeaderImagesSeller({super.key, required this.data});

  @override
  State<HeaderImagesSeller> createState() => _HeaderImagesSellerState();
}

class _HeaderImagesSellerState extends State<HeaderImagesSeller> {
  dynamic selectIndexImage = 0;

  addImage() {
    widget.data.photos.add(widget.data.thumbnailImage);
  }

  @override
  void initState() {
    addImage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          color: Colors.transparent,
          height: heigth * 0.4,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: white,
                  ),
                  margin: EdgeInsetsDirectional.only(
                    top: heigth * 0.05,
                    start: width * 0.04,
                  ),
                  child: FlipView(
                    child: Center(
                      child: SvgPicture.asset("assets/icons/back.svg"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: GestureDetector(
                    onTap: () {
                      List<String> images = [];
                      for (var element in widget.data.photos) {
                        images.add(element);
                      }
                      
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.data.photos[selectIndexImage],
                        placeholder:
                            (context, url) =>   LoadingUi(),
                        errorWidget:
                            (context, url, error) =>
                                Image.asset('assets/test/abaya.png'),
                        fit: BoxFit.cover,
                        height: heigth,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      margin: EdgeInsetsDirectional.only(
                        top: heigth * 0.05,
                        end: width * 0.04,
                      ),
                      child: Center(
                        child: FlipView(
                          child: SvgPicture.asset(
                            "assets/icons/info_seller.svg",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(end: width * 0.04),
          child: Column(
            children: [
              ...List.generate(
                min(widget.data.photos.length, 3),
                (index) => GestureDetector(
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
                            selectIndexImage == index
                                ? primaryColor
                                : const Color(0xff898384),
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: widget.data.photos[index],
                            placeholder:
                                (context, url) =>   LoadingUi(),
                            errorWidget:
                                (context, url, error) =>
                                    Image.asset('assets/test/abaya.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
