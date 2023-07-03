
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/register_repository.dart';
import '../models/register_model.dart';

abstract class RegisterBaseDatasource {
  Future<RegisterModel> register(RegisterParams params);
}

class RegisterDataSourceImpl implements RegisterBaseDatasource {
  final APIProvider apiProvider;

  RegisterDataSourceImpl(this.apiProvider);
  @override
  Future<RegisterModel> register(RegisterParams params) async {
    final response = await apiProvider.post(endPoint:registerAuMall, data: {
      "full_name": params.name,
      "name": params.name,
      "email": params.email,
      "password": params.password,
      "password_confirmation": params.password,
    });
    if (kDebugMode) {
      print('RegisterDataSourceImpl ${response.data}');
    }
    return RegisterModel.fromJson(response.data);
  }
}
