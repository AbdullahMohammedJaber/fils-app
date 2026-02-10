import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/storage.dart';
import '../../../utils/widget/defulat_text.dart';

class TapBarItemFav extends StatefulWidget {
  const TapBarItemFav({super.key});

  @override
  State<TapBarItemFav> createState() => _TapBarItemFavState();
}

class _TapBarItemFavState extends State<TapBarItemFav> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: grey3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                       context.read<FavoritesCubit>()
                           .changePageTapBar(index: 0);
                       
                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                        context.read<FavoritesCubit>().pageTapBarFav == 0
                                ? primaryDarkColor
                                : getTheme()
                                ? Colors.black
                                : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Online Product".tr(),
                          color:
                          context.read<FavoritesCubit>().pageTapBarFav == 0
                                  ? white
                                  : getTheme()
                                  ? white
                                  : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<FavoritesCubit>()
                      .changePageTapBar(index: 1);
                     
                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                        context.read<FavoritesCubit>().pageTapBarFav == 1
                                ? primaryDarkColor
                                : getTheme()
                                ? Colors.black
                                : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Auctions".tr(),
                          color:
                          context.read<FavoritesCubit>().pageTapBarFav == 1
                                  ? white
                                  : getTheme()
                                  ? white
                                  : blackColor,
                        ),
                      ),
                    ),
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
