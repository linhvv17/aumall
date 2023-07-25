import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String ? id;
  final String? name;
  final String? mobile;
  final String? address;
  final bool? defaultAddress;

  const AddressEntity(
      { this.id,
       this.name,
       this.mobile,
       this.address,
       this.defaultAddress,
       });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      mobile,
      address,
      defaultAddress
    ];
  }
}
