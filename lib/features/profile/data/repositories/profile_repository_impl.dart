import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource profileDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(this.profileDatasource, this.networkInfo);
  @override
  Future<Either<Failure, ProfileEntity>> getUserDetail() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.getUserDetails();
        CacheManager().putItem(data);
        return right(data);
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      final profile = CacheManager().getItem("user-info");
      if (profile != null) return right(profile);

      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
      UpdateProfileParams updateProfileParams) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.updateProfile(updateProfileParams);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updatePassword(
      UpdatePassParnms params) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.updatePassword(params);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddressList() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.getAddressList();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> addAddress(AddAddressParams addAddressParams) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.addAddress(addAddressParams);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await profileDatasource.logOut();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }
}
