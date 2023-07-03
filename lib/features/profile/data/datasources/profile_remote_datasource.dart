import 'dart:convert';

import 'package:aumall/core/utilities/file_store.dart';

import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getUserDetails();
  Future<ProfileModel> updateProfile(UpdateProfileParams params);
  Future<ProfileModel> updatePassword(UpdatePassParnms parnms);
}

class ProfileDataSourceImpl implements ProfileDatasource {
  final APIProvider apiProvider;

  ProfileDataSourceImpl(this.apiProvider);
  @override
  Future<ProfileModel> getUserDetails() async {
    final response = await apiProvider.get(
      endPoint: profileEndPoint,
      // endPoint: profileAuMall,
      token: PreferenceHelper.getDataFromSharedPreference(
                            key: 'token') ?? '',
    );
    print("getUserDetails ${response.data}");
    // await FileStorage.writeCounter(jsonEncode(response.data).toString(), 'user.txt');
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<ProfileModel> updateProfile(UpdateProfileParams params) async {
    final response = await apiProvider.put(
      endPoint: updateProfileEndPoint,
      data: {
        "avatar": params.avatar,
        "name": params.name,
        "email": params.email,
      },
      token: PreferenceHelper.getDataFromSharedPreference(
                            key: 'token') ?? '',
    );
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<ProfileModel> updatePassword(UpdatePassParnms params) async {
    final response = await apiProvider.put(
      endPoint: updatePasswordEndPoint,
      data: {
        'oldPassword': params.oldPassword,
        'newPassword': params.newPassword,
        'confirmPassword': params.confirmPassword,
      },
      token: PreferenceHelper.getDataFromSharedPreference(
                            key: 'token') ?? '',
    );
    return ProfileModel.fromJson(response.data);
  }
}
