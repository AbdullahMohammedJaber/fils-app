import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/theme/color_manager.dart';
import '../../../../../utils/widget/defulat_text.dart';

class GiftSection extends StatefulWidget {
  final int id;

  const GiftSection({super.key, required this.id});

  @override
  State<GiftSection> createState() => _GiftSectionState();
}

class _GiftSectionState extends State<GiftSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuctionCubit>().fetchGift(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit , AuctionState>(
      builder: (context, state) {
        if (state.loadingGift == true) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: primaryColor,
            ),
          );
        }
        if (state.gifts.isEmpty) {
          return Center(child: DefaultText("No Gift available".tr()));
        }
        return ListView.builder(
          itemCount: state.gifts.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                children: [
                  DefaultText(
                    "${state.gifts[index]['message']} KWD ${state.gifts[index]['amount']}"
                        .tr(),
                    color: const Color(0xff433E3F),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                     /* state.acceptOrRejectGift(
                        idGift: state.gifts[index]['gift_id'],
                        senderId: state.gifts[index]['sender_id'],
                        type: 2,
                      );*/
                    },
                    child: Image.asset("assets/images/falseGift.png"),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                    /*  state.acceptOrRejectGift(
                        idGift: state.gifts[index]['gift_id'],
                        senderId: state.gifts[index]['sender_id'],
                        type: 1,
                      );*/
                    },
                    child: Image.asset("assets/images/trueGift.png"),
                  ),
                ],
              ),
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
