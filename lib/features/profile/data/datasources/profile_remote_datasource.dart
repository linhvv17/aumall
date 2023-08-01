import 'dart:io';

import 'package:aumall/features/profile/data/models/address_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getUserDetails();
  Future<ProfileModel> updateProfile(UpdateProfileParams params);
  Future<ProfileModel> updatePassword(UpdatePassParnms parnms);
  Future<List<AddressModel>> getAddressList();
  Future<bool> addAddress(AddAddressParams addAddressParams);
}

class ProfileDataSourceImpl implements ProfileDatasource {
  final APIProvider apiProvider;

  ProfileDataSourceImpl(this.apiProvider);
  @override
  Future<ProfileModel> getUserDetails() async {
    final response = await apiProvider.get(
      endPoint: profileAuMall,
      token: PreferenceHelper.getDataFromSharedPreference(
                            key: 'token') ?? '',
    );
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<ProfileModel> updateProfile(UpdateProfileParams params) async {

    // FormData formData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(params.avatar.path,
    //       filename: params.avatar.path, ),
    //   "type": "image/png"
    // });
     File file = File(params.avatar.path);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "full_name": params.name,
      "name": params.name,
      "mobile": params.mobile,
      "avatar": await MultipartFile.fromFile(file.path, filename:fileName),
      "date_or_birth": params.dateOfBirth,
      "address": params.address,
    });



    final response = await apiProvider.post(
      endPoint: updateProfileAuMall,
      // data: {
      //   "full_name": params.name,
      //   "name": params.name,
      //   "mobile": params.mobile,
      //   "avatar": formData,
      //   "date_or_birth": params.dateOfBirth,
      //   "address": params.address,
      // },
      data: formData,
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

  @override
  Future<List<AddressModel>> getAddressList() async {
    final response = await apiProvider.get(
      endPoint: shippingAddressAuMall,
      token: PreferenceHelper.getDataFromSharedPreference(
          key: 'token') ?? '',
    );
    List<AddressModel> listAddressModel
    = List<AddressModel>.from(
        response.data['data']['data'].map((x) => AddressModel.fromJson(x)));
    return listAddressModel;
  }

  @override
  Future<bool> addAddress(AddAddressParams addAddressParams) async {
    final data = {
      "name" : addAddressParams.name,
      "mobile" : addAddressParams.mobile,
      "address" : addAddressParams.address,
      "address_default" : addAddressParams.addressDefault,

    };
    final response = await apiProvider.post(
      endPoint: shippingAddressAuMall,
      data: data,
      token: PreferenceHelper.getDataFromSharedPreference(
          key: 'token') ?? '',
    );

    return true;
  }
}
