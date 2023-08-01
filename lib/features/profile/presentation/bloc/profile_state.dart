part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileEntity data;

  const ProfileLoadedState(this.data);
}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState(this.message);
}
class UpdateProfileLoadingState extends ProfileState {}
class UploadImagesLoadingState extends ProfileState {
  
}
class ProfileUpdateState extends ProfileState {
  final ProfileEntity data;

  const ProfileUpdateState(this.data);
}
class UpdateProfileErrorState extends ProfileState {
  final String message;

  const UpdateProfileErrorState(this.message);
}
class PickedImageState extends ProfileState {
  // final CloudinaryResponse image;
  final XFile xFileToUpload;

  const PickedImageState(this.xFileToUpload);
}

class GetAddressListLoadedState extends ProfileState {
  final List<AddressEntity> data;

  const GetAddressListLoadedState(this.data);
}

class AddAddressSuccessState extends ProfileState {
  final bool isSuccess;

  const AddAddressSuccessState(this.isSuccess);
}