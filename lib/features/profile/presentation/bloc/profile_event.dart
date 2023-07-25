part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {}
class GetListAddress extends ProfileEvent {}
class AddAddress extends ProfileEvent {
  final String name;
  final String mobile;
  final String address;
  final bool isDefault;

  const AddAddress(this.name, this.mobile, this.address, this.isDefault);
}

class UpdataProfileEvent extends ProfileEvent {
  final String name;
  final String email;
  final String avatar;

  const UpdataProfileEvent(this.name, this.email, this.avatar);}

class UploadImage extends ProfileEvent {

}