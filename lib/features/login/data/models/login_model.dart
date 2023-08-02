
import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel(
      { super.id,
       super.name,
       super.email,
       super.message,
       super.role,
       super.createdAt,
       super.success,
       super.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return  LoginModel(
      id: json['data']["id"].toString() ??"",
      name: json['data']["name"]??"",
      email: json['data']["email"]??"",
      role: json["role"]??"",
      createdAt: DateTime.parse(json["createdAt"]??"2022-11-26T18:08:07.693Z") ,
      token: json["token"]??"",
      success: json["success"]??true,
      message: json["message"]??"wellcome",
    );
  }
}
