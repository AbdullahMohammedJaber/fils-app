import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/haraj/widget_haraj.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';

import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/dialog_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
import '../../../utils/theme/color_manager.dart';
import '../../root/item_title_bar.dart';
import '../category/category_widget.dart';
import 'item_auction_new.dart';

class AuctionRoot extends StatefulWidget {
  const AuctionRoot({super.key});

  @override
  State<AuctionRoot> createState() => _AuctionRootState();
}

class _AuctionRootState extends State<AuctionRoot> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    context.read<AuctionCubit>().clearList();
    Future.delayed(Duration(seconds: 1), () {
      context.read<AuctionCubit>().getAllAuction(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -1,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: zaherH,
      ),
      body: Column(
        children: [
          SizedBox(height: heigth * 0.02),
          Row(
            children: [
              Expanded(
                child: ItemTitleBar(
                  title: "Public Auctions".tr(),
                  canBack: true,
                ),
              ),
 FloatingAddProductWidget(
                onTap: () {
                  if (isLogin()) {
                    if(getUser()!.user!.phone!.isEmpty){
                      showMessage("Enter your mobile number".tr(), value: false);
                    ToWithFade(AppRoutes.editPersonalInformationScreen);
                       
                    }else{
                    ToWithFade(AppRoutes.formAddAuctionCoustomer);
      
                    }
                  } else {
                    showDialogAuth(context);
                  }
                },
              ),
              SizedBox(width: width * 0.02),
            ],
          ),
          SizedBox(height: heigth * 0.03),
          CategoryWidget(classType: ClassType.auction),
          SizedBox(height: heigth * 0.02),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return context.read<AuctionCubit>().getAllAuction(
                  refresh: true,
                );
              },
              child: SingleChildScrollView(
                child: BlocConsumer<AuctionCubit, AuctionState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return LoadingUi();
                    } else if (state.error != null) {
                      return NeonNoInternetView(
                        onRetry: () {
                          context.read<AuctionCubit>().getAllAuction(
                            refresh: true,
                          );
                        },
                        error: state.error!,
                      );
                    } else if (state.auctionList != null) {
                      if (state.auctionList!.isEmpty) {
                        return EmptyDataScreen(
                          onReload: () {
                            context.read<AuctionCubit>().getAllAuction(
                              refresh: true,
                            );
                          },
                        );
                      } else {
                        final data = state.auctionList;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted &&
                              state.hasMore &&
                              state.loading == false) {
                            context.read<AuctionCubit>().getAllAuction();
                          }
                        });
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scroll) {
                            if (scroll.metrics.pixels >=
                                    scroll.metrics.maxScrollExtent - 200 &&
                                state.hasMore) {
                              context.read<AuctionCubit>().getAllAuction();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index == data.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(child: LoadingUi()),
                                );
                              } else {
                                return ItemAuctionNew(item: data[index]);
                              }
                            },
                            itemCount:
                                state.hasMore ? data!.length + 1 : data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        );
                      }
                    }
                    return SizedBox();
                  },
                  listener: (context, state) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
