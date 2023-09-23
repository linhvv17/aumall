import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aumall/features/shopping/domain/entities/reviews_entity.dart';
import 'package:aumall/features/shopping/domain/usecases/get_all_reviews.dart';
import '../../../home/data/models/detail_product_response.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/usecases/send_review_usecase.dart';

part 'send_review_event.dart';
part 'send_review_state.dart';

class SendReviewBloc extends Bloc<SendReviewEvent, SendReviewState> {
  final SendReviewUseCase sendReviewUseCase;
  final GetReviewsUseCase getReviewsUseCase;
  SendReviewBloc(this.sendReviewUseCase, this.getReviewsUseCase)
      : super(SendReviewInitial()) {
    on<SendReview>((event, emit) async {
      emit(SendReviewLoadingState());
      final failureOrSuccess = await sendReviewUseCase(
        SendReviewUseCaseParams(
          event.productId,
          event.comment,
          event.rating,
        ),
      );

      failureOrSuccess.fold(
          (failure) => emit(SendReviewErrorState(failure.message)), (success) {
        emit(SendReviewLoadedState(success));
        add(GetReviews(event.productId));
      });
    });

    on<GetReviews>((event, emit) async {
      emit(GetAllReviewsLoadingState());

      final failureOrSuccess =
          await getReviewsUseCase(GetReviewsUseCaseParams(event.productId));
      failureOrSuccess
          .fold((failure) => emit(GetAllReviewsErrorState(failure.message)),
              (success) {
        emit(GetAllReviewsLoadedState(success.reviews));
      });
    });
  }
}
