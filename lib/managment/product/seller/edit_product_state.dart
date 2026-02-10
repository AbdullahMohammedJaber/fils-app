part of 'edit_product_cubit.dart';

class EditProductState {
  final bool loading;
  final File? imageProduct;
  final int? idImage;
  final String? nameCategory;
  final int? idCategory;
  final List<int>? categoryIds;
  final String? nameCategores;
  final String? urlImage;
  EditProductState({
    this.loading = false,
    this.urlImage,
    this.imageProduct,
    this.idImage,
    this.nameCategory,
    this.idCategory,
    this.categoryIds,
    this.nameCategores,
  });

  EditProductState copyWith({
    bool? loading,
    File? imageProduct,
    int? idImage,
    String? nameCategory,
    int? idCategory,
    List<int>? categoryIds,
    String? nameCategores,
    String? urlImage,
  }) {
    return EditProductState(
      idCategory: idCategory ?? this.idCategory,
      idImage: idImage ?? this.idImage,
      nameCategory: nameCategory ?? this.nameCategory,
      imageProduct: imageProduct ?? this.imageProduct,
      loading: loading ?? this.loading,
      categoryIds: categoryIds ?? this.categoryIds,
      nameCategores: nameCategores ?? this.nameCategores,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  factory EditProductState.clearAttachment({
    required String? nameCategory,
   required int? idCategory,
   required List<int>? categoryIds,
   required String? nameCategores,
  }) {
    return EditProductState(imageProduct: null, idImage: null , urlImage: null , 
    categoryIds: categoryIds,
    idCategory: idCategory,
    nameCategores: nameCategores,
    nameCategory: nameCategory
    
    
    );
  }
}
