import 'package:aumall/features/profile/data/models/address_model.dart';

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
  Future<bool> addAddress();
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
  Future<bool> addAddress() async {
    final data = {

    };
    final response = await apiProvider.post(
      endPoint: shippingAddressAuMall,
      token: PreferenceHelper.getDataFromSharedPreference(
          key: 'token') ?? '',
    );

    return true;
  }
}
