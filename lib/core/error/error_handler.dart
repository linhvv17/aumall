// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';
import 'package:aumall/core/error/failure.dart';

import '../../generated/l10n.dart';
import '../utilities/strings.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return ServerFailure(
          ResponseMessage.BAD_REQUEST,
        );
      case DataSource.FORBIDDEN:
        return ServerFailure(ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return ServerFailure(ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return ServerFailure(ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return ServerFailure(ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return ServerFailure(ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return ServerFailure(ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return ServerFailure(ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return ServerFailure(ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return ServerFailure(ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return ServerFailure(ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return ServerFailure(ResponseMessage.DEFAULT);
      default:
        return ServerFailure(ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure user is not authorised
  static const int NOT_FOUND =
      404; // failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR =
      500; // failure, crash happened in server side

  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  static String SUCCESS = S.current.success; // success with data
  static String NO_CONTENT = S.current.noContent; // success with no content
  static String BAD_REQUEST =
      S.current.badRequestError; // failure, api rejected our request
  static String FORBIDDEN =
      S.current.forbiddenError; // failure,  api rejected our request
  static String UNAUTHORISED =
      S.current.unauthorizedError; // failure, user is not authorised
  static String NOT_FOUND = AppStrings
      .notFoundError; // failure, API url is not correct and not found in api side.
  static String INTERNAL_SERVER_ERROR =
      S.current.internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static String DEFAULT = S.current.defaultError; // unknown error happened
  static String CONNECT_TIMEOUT =
      S.current.timeoutError; // issue in connectivity
  static String CANCEL = S.current.defaultError; // API request was cancelled
  static String RECEIVE_TIMEOUT =
      S.current.timeoutError; //  issue in connectivity
  static String SEND_TIMEOUT = S.current.timeoutError; //  issue in connectivity
  static String CACHE_ERROR = AppStrings
      .defaultError; //  issue in getting data from local data source (cache)
  static String NO_INTERNET_CONNECTION =
      S.current.noInternetError; // issue in connectivity
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
