import 'package:aumall/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/payment/domain/entities/all_orders_entity.dart';
import 'package:aumall/features/payment/domain/repositories/payment_repository.dart';

class GetAllOrderesUsecase implements BaseUsecase<AllOrdersEntity, NoParams> {
  final PaymentRepository paymentRepository;

  GetAllOrderesUsecase(this.paymentRepository);
  
  @override
  Future<Either<Failure, AllOrdersEntity>> call(NoParams params)async{
 return await paymentRepository.getAllOrders(params);
  }
 

}
