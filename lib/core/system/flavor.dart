import 'package:envify/envify.dart';
import 'package:lunasea/core.dart';

part 'flavor.g.dart';

@Envify(path: '.flavor')
abstract class Flavor {
  static const flavor = _Flavor.flavor;
}

extension FlavorExtension on Flavor {
  Environment get environment {
    switch (Flavor.flavor) {
      case 'develop':
        return Environment.DEVELOP;
      case 'alpha':
        return Environment.ALPHA;
      case 'beta':
        return Environment.BETA;
      case 'production':
        return Environment.PRODUCTION;
    }
    throw Exception('Invalid Environment');
  }
}
