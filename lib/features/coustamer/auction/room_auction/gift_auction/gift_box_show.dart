import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/const.dart';
import '../../../../../utils/theme/color_manager.dart';
import '../../../../../utils/widget/defulat_text.dart';

class GiftBoxOverlay extends StatelessWidget {
  const GiftBoxOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (!state.showGiftBox) return const SizedBox.shrink();

        return Center(
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: primaryDarkColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black26),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<AuctionCubit>().closeGiftBox();
                        },
                        icon: Icon(Icons.close, color: white),
                      ),
                    ],
                  ),
                  Image.asset("assets/icons/box_gift.png"),
                  const SizedBox(height: 10),
                  DefaultText(
                    "${state.messageNewGift} KWD ${state.amountNewGift}",
                    color: white,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
