 import 'package:fils/features/coustamer/home/home_screen.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:fils/managment/home/home_cubit.dart';
 import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRoot extends StatefulWidget {
  const HomeRoot({super.key});

  @override
  State<HomeRoot> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeRoot> {
  var scrollController = ScrollController();
  final GlobalKey shopKey = GlobalKey();
  final GlobalKey scrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
    await  context.read<HomeCubit>().getHomeRequest();
    if(isLogin()){
    await  context.read<FavoritesCubit>().getListFavorites(refresh: true);

    }

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingUi();
        }

        if (state is HomeSuccess) {
          return HomeScreen(homeResponse: state.homeResponse);
        }

        if (state is HomeNoInternet) {
          return NeonNoInternetView(
            onRetry: () => context.read<HomeCubit>().getHomeRequest(),
            error: StringApp.noInternet,
          );
        } else if (state is HomeUnknownError) {
          return NeonNoInternetView(
            onRetry: () => context.read<HomeCubit>().getHomeRequest(),
            error: StringApp.noInternet,
          );
        }

        return SizedBox();
      },
    );
  }
}
