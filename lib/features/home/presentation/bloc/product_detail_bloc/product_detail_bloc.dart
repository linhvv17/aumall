import 'package:aumall/features/home/domain/entities/product_detail_entity.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_event.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_product_detail_usecase.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState>{
  final GetProductDetailUseCase getProductDetailUseCase;
  ProductDetailBloc(this.getProductDetailUseCase) : super(ProductDetailLoading()){
   on<GetProductDetailData>((event, emit) async {
     emit(ProductDetailLoading());

     final failureOrSuccess = await getProductDetailUseCase(
       GetProductDetailUseCaseParams(idProduct: event.idProduct)
     );

     failureOrSuccess.fold(
             (failure) => emit(ProductDetailErrorState(failure.message)),
             (success) => emit(ProductDetailLoaded(
               ProductDetailEntity(
                 success.productDetailData,
                 success.relatedProducts
               )
             ))
     );
   }) ;
  }

}