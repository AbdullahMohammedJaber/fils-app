import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/widget/image_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/const.dart';
 
import '../../../../../utils/theme/color_manager.dart';
import '../../../core/data/response/haraj/details_haraj.dart';
import '../../../utils/widget/flip_view.dart';

class HeaderDetailsProductOpenMarket extends StatefulWidget {
  final DetailsOpenMarketResponseDatum details;

  const HeaderDetailsProductOpenMarket({super.key, required this.details});

  @override
  State<HeaderDetailsProductOpenMarket> createState() =>
      _HeaderDetailsProductOpenMarketState();
}

class _HeaderDetailsProductOpenMarketState
    extends State<HeaderDetailsProductOpenMarket> {
  dynamic selectIndexImage = 0;

  addImage() {
    widget.details.photos!.data!.add(
      MetaImageDatum(
        id: 0,
        type: "",
        extension: '',
        fileName: "",
        fileOriginalName: DateTime.now(),
        fileSize: 0,
        url: widget.details.thumbnailImage!.data![0].url,
      ),
    );
  }

  @override
  void initState() {
    addImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          color: Colors.transparent,
          height: heigth * 0.4,
          width: width,
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
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      List<String> images = [];
                      for (var element in widget.details.photos!.data!) {
                        images.add(element.url!);
                      }
                      /* ToWithFade(
                        context,
                        ImageView(
                          images: images,
                          initialIndex: selectIndexImage,
                        ),
                      );*/
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(image: widget.details.photos!.data![selectIndexImage].url!),));
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.details.photos!.data![selectIndexImage].url!,
                          placeholder: (context, url) => const LoadingUi(),
                          errorWidget:
                              (context, url, error) =>
                                  Image.asset('assets/test/abaya.png'),
                          fit: BoxFit.cover,
                          height: heigth,
                          width: width,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,

                  margin: EdgeInsetsDirectional.only(
                    top: heigth * 0.05,
                    start: width * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(end: width * 0.04),
          child: Column(
            children: [
              ...List.generate(
                min(widget.details.photos!.data!.length, 3),
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
                            imageUrl: widget.details.photos!.data![index].url!,
                            placeholder: (context, url) => const LoadingUi(),
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
