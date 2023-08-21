import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { prod, uat, stg, dev }

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    // required this.baseURLeKYC,
    required this.version,
  });

  final String baseUrl;
  // final String baseURLeKYC;
  final String version;
//Add other flavor specific values, e.g database name
}

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required FlavorValues values,
  }) {
    _singleton.flavor = flavor;
    _singleton.name = name;
    _singleton.values = values;
    return _singleton;
  }

  FlavorConfig._internal();

  late Flavor flavor;
  late String name;
  late FlavorValues values;

  static final FlavorConfig _singleton = FlavorConfig._internal();

  static FlavorConfig get instance {
    return _singleton;
  }

  static Future<FlavorConfig> setup(Flavor flavor) async {
    switch (flavor) {
      case Flavor.prod:
        await dotenv.load(fileName: '.env.prod');
        break;
      case Flavor.stg:
        await dotenv.load(fileName: '.env.stg');
        break;
      case Flavor.uat:
        await dotenv.load(fileName: '.env.uat');
        break;
      case Flavor.dev:
        await dotenv.load(fileName: '.env.dev');
        break;
    }
    final String name = dotenv.get('name');
    final FlavorValues values = FlavorValues(
      baseUrl: dotenv.get('baseUrl'),
      // baseURLeKYC: dotenv.get('baseURLeKYC'),
      version: dotenv.get('version'),
    );
    return FlavorConfig(
      flavor: flavor,
      name: name,
      values: values,
    );
  }

  bool isStaging() => flavor == Flavor.prod;
}
