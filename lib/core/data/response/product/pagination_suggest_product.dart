import 'package:fils/core/data/response/product/item_product.dart';
import 'package:fils/core/data/response/product/pagination_general.dart';

class PaginatedSuggestProductsResponse {
  final List<ProductListModel> products;
  final PaginationMeta meta;

  PaginatedSuggestProductsResponse({
    required this.products,
    required this.meta,
  });

  factory PaginatedSuggestProductsResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedSuggestProductsResponse(
      products: List<ProductListModel>.from(
        json['data']['data'].map((e) => ProductListModel.fromJson(e)),
      ),
      meta: PaginationMeta.fromJson(json['data']['meta']),
    );
  }
}
