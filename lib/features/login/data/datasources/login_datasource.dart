
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domin/repositories/login_repository.dart';
import '../models/login_model.dart';

abstract class LoginDatasource {
  Future<LoginModel> login(LoginParams params);
}

class LoginDatasourceImpl implements LoginDatasource {
  final APIProvider apiProvider;

  LoginDatasourceImpl(this.apiProvider);
  @override
  Future<LoginModel> login(LoginParams params) async {
    final response = await apiProvider.post(endPoint: loginEndPoint, data: { //default
    // final response = await apiProvider.post(endPoint: loginAuMall, data: {
      "email": params.email,
      "password": params.password,
    });
    print("login ${response.data}");
    return LoginModel.fromJson(response.data);
  }
}