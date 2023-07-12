import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_detail_entity.dart';

class GetProductDetailUseCase extends BaseUsecase<ProductDetailEntity, GetProductDetailUseCaseParams>{
  final HomeBaseRepository homeRepository;
  GetProductDetailUseCase(this.homeRepository);

  @override
  Future<Either<Failure, ProductDetailEntity>> call(params) async {
    final response =  await homeRepository.getProductDetail(
      GetProductDetailParams(id: params.idProduct)
    );
    print('GetProductDetailUseCase ${response}');
    return response;
  }
}


class GetProductDetailUseCaseParams {
  final int idProduct;
  GetProductDetailUseCaseParams({required this.idProduct});
}