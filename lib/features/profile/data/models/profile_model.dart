import 'package:aumall/features/profile/data/datasources/profile_local_datasource.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel(super.success, super.user, super.message);
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      json['status'].toString(),
      json['data'] != null
          ? UserModel.fromJson(json['data'])
          : CacheManager().getItem("user-info")!.user,
      json['message'] ?? '');
}

class UserModel extends UserEntity {
  const UserModel(super.id, super.name, super.email, super.avatar, super.phone,
      super.dateOfBirth, super.address);
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      json['id'].toString(),
      json['name'],
      json['email'],
      json['avatar'],
      json['mobile'],
      json['birthday'],
      json['address']
      // != null ? AvatarModel.fromJson(json['avatar']) : null
      );
}

class AvatarModel extends AvatarEntity {
  const AvatarModel(super.publicId, super.url);
  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      AvatarModel(json['public_id'], json['url']);
}
