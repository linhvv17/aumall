
import '../../domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel(super.success, super.message);
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      ResponseModel(
          json['status'] == 200 ? true : false,
          json['message']
      );
}
