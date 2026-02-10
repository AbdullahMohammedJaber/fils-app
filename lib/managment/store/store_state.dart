part of 'store_cubit.dart';

@immutable
class StoreState {
  // All Store
  final bool loading;
  final String? error;
  final bool hasMore;
  final List<Store>? items;

  // TabBar
  final String? errorTabBar;
  final List<TabBarStore>? listTabBar;
  final bool loadingTabBar;
  final TabBarStore? tabBarSelect;

  // All Product in Store
  final bool getProductLoading;
  final List<ProductListModel>? listProductInStore;
  final String? errorListAllProductStore;
  final bool hasMoreListAllProductStore;

  // All Store in category
  final bool loadingStoreCategory;
  final String? errorStoreCategory;
  final bool hasMoreStoreCategory;
  final List<Store>? itemsStoreCategory;

  StoreState({
    // All Store
    this.loading = true,
    this.items,
    this.error,
    this.hasMore = false,
    this.loadingStoreCategory = true,
    this.itemsStoreCategory,
    this.errorStoreCategory,
    this.hasMoreStoreCategory = false,
    // TabBar
    this.errorTabBar,
    this.loadingTabBar = true,
    this.tabBarSelect,
    this.listTabBar,
    // All Product in Store
    this.getProductLoading = false,
    this.listProductInStore,
    this.errorListAllProductStore,
    this.hasMoreListAllProductStore = false,
  });

  StoreState copyWith({
    bool? loading,
    String? error,
    List<Store>? items,
    bool? hasMore,
    bool? loadingStoreCategory,
    String? errorStoreCategory,
    List<Store>? itemsStoreCategory,
    bool? hasMoreStoreCategory,
    // All Product in Store
    bool? getProductLoading,
    String? errorListAllProductStore,
    List<ProductListModel>? listProductInStore,
    bool? hasMoreListAllProductStore,
    // TabBar
    bool? loadingTabBar,
    String? errorTabBar,
    List<TabBarStore>? listTabBar,
    TabBarStore? tabBarSelect,
  }) {
    return StoreState(
      error: error,
      errorStoreCategory: errorStoreCategory,
      errorListAllProductStore: errorListAllProductStore,
      getProductLoading: getProductLoading ?? this.getProductLoading,
      errorTabBar: errorTabBar,
      loading: loading ?? this.loading,
      loadingStoreCategory: loadingStoreCategory ?? this.loadingStoreCategory,
      loadingTabBar: loadingTabBar ?? this.loadingTabBar,
      hasMore: hasMore ?? this.hasMore,
      hasMoreStoreCategory: hasMoreStoreCategory ?? this.hasMoreStoreCategory,
      hasMoreListAllProductStore:
          hasMoreListAllProductStore ?? this.hasMoreListAllProductStore,
      items: items ?? this.items,
      itemsStoreCategory: itemsStoreCategory ?? this.itemsStoreCategory,
      listProductInStore: listProductInStore,
      tabBarSelect: tabBarSelect ?? this.tabBarSelect,
      listTabBar: listTabBar ?? this.listTabBar,
    );
  }
}
