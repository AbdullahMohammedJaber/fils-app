// ignore_for_file: deprecated_member_use, must_be_immutable, unused_local_variable

 
 import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/reel/reel_response.dart';
import 'package:fils/managment/reels_manage/cubit/reels_cubit.dart';
 import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
 
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
 
import 'package:fils/utils/const.dart';
 
import 'package:url_launcher/url_launcher.dart';

 

class PositionAnalyze extends StatefulWidget {
  Reels data;

  PositionAnalyze({super.key, required this.data});

  @override
  State<PositionAnalyze> createState() => _PositionAnalyzeState();
}

class _PositionAnalyzeState extends State<PositionAnalyze> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 200,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
             
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.data.thumbnailImage),
              radius: 25,
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // لون الظل وشفافيته
                    blurRadius: 10, // مدى انتشاره
                    offset: const Offset(0, 4), // الاتجاه: أفقي 0، عمودي 4
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/love_reel.svg",
                  color: widget.data.isFavorite ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
          DefaultText(
            widget.data.favoriteCount.toString(),
            color: white,
            fontSize: 14,
            type: FontType.SemiBold,
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
               
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // لون الظل وشفافيته
                    blurRadius: 12, // مدى انتشاره
                    offset: const Offset(0, 4), // الاتجاه: أفقي 0، عمودي 4
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/comment_reel.svg"),
              ),
            ),
          ),
          DefaultText(
            widget.data.commentsCount.toString(),
            color: white,
            fontSize: 14,
            type: FontType.SemiBold,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              _showShareBottomSheet(context, widget.data);
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // لون الظل وشفافيته
                    blurRadius: 12, // مدى انتشاره
                    offset: const Offset(0, 4), // الاتجاه: أفقي 0، عمودي 4
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/share_reel.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget positionTitle(Reels data, BuildContext context, dynamic index) {
  return BlocConsumer<ReelsCubit, ReelsState>(
    listener: (context, state) {
      
    },
    builder: (context, app) {
      return Positioned(
        bottom: 50,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                DefaultText('@${data.shopName}', color: white),
                GestureDetector(
                  onTap: () {
                      
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: primaryDarkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DefaultText(
                      'Product request'.tr(),
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DefaultText(data.shopName, color: white),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}



void _showShareBottomSheet(BuildContext context, Reels reel) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Container(
            width: width,
            height: 50,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffE8E2F8))),
            ),
            child: Center(
              child: DefaultText(
                "Share to".tr(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: width,
            color: Colors.transparent,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              children: [
                _buildShareOption(
                  context,
                  icon: "whats.svg",
                  label: "WhatsApp".tr(),
                  onTap: () async {
                    final whatsappUrl =
                        'whatsapp://send?text=${reel.videoLink}';

                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                   
                    }

                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  context,
                  icon: "xx.svg",
                  label: "X",
                  onTap: () async {
                    final url = Uri.parse(
                      "https://twitter.com/intent/tweet?text=${Uri.encodeComponent(reel.videoLink)}",
                    );

                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      print("Could not launch Twitter");
                    }
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  context,
                  icon: "inst.svg",
                  label: "Instagram",
                  onTap: () async {
                    final uri = Uri.parse(
                      'https://www.instagram.com/?url=${Uri.encodeComponent(reel.videoLink)}',
                    );

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      await launchUrl(
                        Uri.parse(reel.videoLink),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  context,
                  icon: "massenger.svg",
                  label: "Messenger",
                  onTap: () async {
                    final encodedText = Uri.encodeComponent(reel.videoLink);
                    final messengerUrl =
                        'fb-messenger://share?link=$encodedText';

                    final fallbackUrl =
                        'https://m.me/?link=$encodedText'; // Backup for web browser

                    if (await canLaunchUrl(Uri.parse(messengerUrl))) {
                      await launchUrl(Uri.parse(messengerUrl));
                    } else {
                      await launchUrl(
                        Uri.parse(fallbackUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  context,
                  icon: "download.svg",
                  label: "Download".tr(),
                  onTap: () {
                    Navigator.pop(context);
                    
                  },
                ),
                _buildShareOption(
                  context,
                  icon: "report.svg",
                  label: "Report".tr(),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: width,
            height: 50,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffE8E2F8))),
            ),
            child: Center(
              child: DefaultText(
                "Cancel".tr(),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildShareOption(
  BuildContext context, {
  required String icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xffE8E2F8),
            child: Center(child: SvgPicture.asset("assets/icons/$icon")),
          ),
        ),
        const SizedBox(height: 8),
        DefaultText(label, fontSize: 10, fontWeight: FontWeight.w400),
      ],
    ),
  );
}
