import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../../../utils/const.dart';
import '../../../../../utils/global_function/timer_format.dart';
 import '../../../../../utils/theme/color_manager.dart';
import '../../../../../utils/widget/button_widget.dart';
import '../../../../../utils/widget/custom_validation.dart';
import '../../../../../utils/widget/defualt_text_form_faild.dart';
import '../../../../../utils/widget/defulat_text.dart';

class BidsSection extends StatefulWidget {
  final int id;

  const BidsSection({super.key, required this.id});

  @override
  State<BidsSection> createState() => _BidsSectionState();
}

class _BidsSectionState extends State<BidsSection> {
  final ScrollController _scrollController = ScrollController();
  double priceTotal = 0.0;
  bool showScrollDownButton = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_scrollController.position.atEdge) {
      showScrollDownButton = true;
    } else {
      showScrollDownButton = false;
    }
    setState(() {});
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionState>(
      builder: (context, state) {
        if (state.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: primaryColor,
            ),
          );
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.bids.isEmpty) {
          return Center(child: DefaultText("No bids available".tr()));
        }

        return SafeArea(
          child: Stack(
            children: [
              Container(
                height: heigth * 0.4,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  reverse: true,
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.bids.length,
                    itemBuilder: (context, index) {
                      final bid = state.bids[index];
                      String amount = bid.bid.customer_bid.toString();

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                DefaultText(
                                  bid.bid.user.name,
                                  color: const Color(0xff433E3F),
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                               
                              ],
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: DefaultText(
                                "KWD  $amount",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff433E3F),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                DefaultText(
                                  getTimeAgo(bid.bid.bidAt),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff726C6C),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (showScrollDownButton)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: _scrollToBottom,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class BottomSheetGift extends StatefulWidget {
  final String id_resever;
  final String auction_id;

  const BottomSheetGift({
    super.key,
    required this.id_resever,
    required this.auction_id,
  });

  @override
  State<BottomSheetGift> createState() => _BottomSheetGiftState();
}

class _BottomSheetGiftState extends State<BottomSheetGift> {
  TextEditingController giftAmount = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: heigth * 0.05, width: width),
                DefaultText(
                  "Enter the gift value".tr(),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                SizedBox(height: heigth * 0.1, width: width),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ValidateWidget(
                    validator: (value) {
                      if (giftAmount.text.isEmpty) {
                        return StringApp.requiredField;
                      } else {
                        return null;
                      }
                    },
                    child: TextFormFieldWidget(
                      controller: giftAmount,
                      textInputType: TextInputType.number,
                      hintText: "Amount gift".tr(),
                      textInputAction: TextInputAction.send,
                      onTapDoneKey: (value) async {
                        if (_key.currentState!.validate()) {
                          /* await app.sendGift(
                            id_resever: widget.id_resever,
                            auction_id: widget.auction_id,
                            price: giftAmount.text,
                          );*/
                          giftAmount.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: heigth * 0.05, width: width),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ButtonWidget(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        /*  await app.sendGift(
                          id_resever: widget.id_resever,
                          auction_id: widget.auction_id,
                          price: giftAmount.text,
                        );*/
                        giftAmount.clear();
                        Navigator.pop(context);
                      }
                    },
                    title: "Send".tr(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
