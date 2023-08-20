part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {}

class LogOut extends ProfileEvent {}

class GetListAddress extends ProfileEvent {}

class AddAddress extends ProfileEvent {
  final String name;
  final String mobile;
  final String address;
  final bool isDefault;

  const AddAddress(this.name, this.mobile, this.address, this.isDefault);
}

class UpdataProfileEvent extends ProfileEvent {
  final String fullName;
  final String name;
  final String mobile;
  final File avatar;
  final String dateOfBirth;
  final String address;

  const UpdataProfileEvent(this.name, this.avatar, this.fullName, this.mobile,
      this.dateOfBirth, this.address);
}

class UploadImage extends ProfileEvent {}
