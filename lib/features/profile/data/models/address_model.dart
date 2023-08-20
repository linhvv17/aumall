import 'package:aumall/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import '../../domain/entities/profile_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel(
      {super.id,
      super.name,
      super.mobile,
      super.address,
      super.defaultAddress});

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      mobile: json['mobile'],
      address: json['address'] ?? '',
      defaultAddress: json['default_address'] ?? false);
}
