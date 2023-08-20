import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/list_product_home_entity.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetListProductHomeUseCase
    extends BaseUsecase<ListProductHomeEntity, NoParams> {
  final HomeBaseRepository homeRepository;
  GetListProductHomeUseCase(this.homeRepository);

  @override
  Future<Either<Failure, ListProductHomeEntity>> call(NoParams params) async {
    final response = await homeRepository.getListProductHome();
    return response;
  }
}
