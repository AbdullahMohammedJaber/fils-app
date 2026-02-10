


import 'package:fils/core/data/response/reel/reel_response.dart';
import 'package:fils/core/domain/reposetry/reels/reels_repo.dart';
import 'package:fils/core/server/result.dart';

class ReelUseCase {
   
   ReelsRepositoryImpl reelsRepository;
   ReelUseCase( this.reelsRepository);
  
  Future<ApiResult<ReelResponse>> fetchReels({required int page}) async {
     return await reelsRepository.fetchReels(page: page);
  }
}