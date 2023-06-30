
import 'dart:convert';

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
    final response = await apiProvider.post(endPoint:registerEndPoint, data: {
    // final response = await apiProvider.post(endPoint:registerAuMall, data: {
      "name": params.name,
      "email": params.email,
      "password": params.password,
      // "password_confirmation": params.password,
      // "full_name": 'trieu van toan',
      // "mobile": "029929292",
      // "address": "hn",
    });

    print('RegisterDataSourceImpl ${response.data}');
    print('RegisterDataSourceImpl ${response.statusCode}');
    // print('RegisterDataSourceImpl jsonDecode ${jsonDecode(response.data)}');

    return RegisterModel.fromJson(response.data);

    // print('RegisterDataSourceImpl register ${response.data}');
    //
    //
    return RegisterModel.fromJson(
    const {
    "_id": "649d011288622586132cd26a",
    "name": "linhvv",
    "email": "linhvv@gmail.com",
    "role": "user",
    "createdAt": "2023-06-29T03:57:06.197Z",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0OWQwMTEyODg2MjI1ODYxMzJjZDI2YSIsImlhdCI6MTY4ODAxMTAyOCwiZXhwIjoxNjkwNjAzMDI4fQ.XnG8IcJ05pm8scx8qkih1-UBXf-YJ8rEywxRHk4Dl7k"
    }
    );
  }
}
