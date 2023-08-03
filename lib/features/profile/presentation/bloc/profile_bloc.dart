import 'dart:io';

import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:aumall/features/profile/domain/repositories/profile_repository.dart';
import 'package:aumall/features/profile/domain/usecases/add_address_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/getUserDetail.dart';
import '../../domain/usecases/get_address_list_usecase.dart';
import '../../domain/usecases/updateProfile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ImagePicker imagePicker = ImagePicker();
  String userName = '';
  String userEmail = '';
  final GetUserDetails getUserDetails;
  final UpdateUserDetailUsecase updateProfile;
  final GetAddressListUseCase getAddressListUseCase;
  final AddAddressUseCase addAddressUseCase;
  CloudinaryResponse? response;

  ProfileBloc(
      this.getUserDetails, this.updateProfile, this.getAddressListUseCase, this.addAddressUseCase)
      : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoadingState());
      final failureOrSuccess = await getUserDetails(NoParams());
      failureOrSuccess.fold((failure) {
        emit(ProfileErrorState(failure.message));
      }, (success) {
        userName = success.user!.name;
        userEmail = success.user!.email;
        emit(ProfileLoadedState(success));
      });
    });

    on<UpdataProfileEvent>((event, emit) async {
      emit(UpdateProfileLoadingState());
      final failureOrSuccess = await updateProfile(
          UpdateProfileUsecaseParams(
              event.fullName,
              event.avatar,
              event.fullName,
              event.mobile,
              event.dateOfBirth,
              event.address
          ));
      failureOrSuccess
          .fold((failure) => emit(UpdateProfileErrorState(failure.message)),
              (success) {
        userName = success.user!.name;
        userEmail = success.user!.email;
        emit(ProfileUpdateState(success));
      });
    });

    on<UploadImage>((event, emit) async {
      emit(UploadImagesLoadingState());
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      emit(PickedImageState(selectedImage!));

    });

    on<GetListAddress>((event, emit) async {
      emit(ProfileLoadingState());

      final failureOrSuccess = await getAddressListUseCase(NoParams());
      failureOrSuccess.fold((failure) {
        emit(ProfileErrorState(failure.message));
      }, (success) {
        emit(GetAddressListLoadedState(success));
      });
    });

    on<AddAddress>((event, emit) async {
      emit(ProfileLoadingState());

      final failureOrSuccess = await addAddressUseCase(
        AddAddressParams(
            event.name,
            event.mobile,
            event.address,
            event.isDefault ? 1 : 0
        )
      );
      failureOrSuccess.fold((failure) {
        emit(ProfileErrorState(failure.message));
      }, (success) {
        emit(AddAddressSuccessState(success));
      });
    });
  }
}
