import 'package:mawidak/core/global/enums/global_enum.dart';
import 'flavor_model.dart';

abstract class Flavor {
  FlavorModel get getCurrentFlavor;
}

class DevelopmentFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor => FlavorModel()
    ..title = 'Development App'
    ..baseUrl = 'http://10.105.196.12:7052'
    ..description = 'Development Flavor'
    ..androidBundleId = 'com.ipa.edu.dev'
    ..iosBundleId = 'com.ipa.edu.dev'
    ..flavorType = FlavorsTypes.dev;
}

class StageFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor => FlavorModel()
    ..title = 'Stage App'
    ..baseUrl = 'http://10.105.196.10:7052'
    ..description = 'Stage Flavor'
    ..androidBundleId = 'com.ipa.edu.stage'
    ..iosBundleId = 'com.ipa.edu.stage'
    ..flavorType = FlavorsTypes.stage;
}

class ProductionFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor => FlavorModel()
    ..title = 'Production App'
    ..baseUrl = 'https://ics-app.haj.gov.sa'
    ..description = 'Production Flavor'
    ..androidBundleId = 'com.ipa.edu'
    ..iosBundleId = 'com.ipa.edu'
    ..flavorType = FlavorsTypes.prod;
}

class EnterpriseFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor => FlavorModel()
    ..title = 'Enterprise App'
    ..baseUrl = 'https://ics-app.haj.gov.sa'
    ..description = 'Enterprise Flavor'
    ..androidBundleId = 'com.ipa.edu.enterprise'
    ..iosBundleId = 'com.ipa.edu.enterprise'
    ..flavorType = FlavorsTypes.enterprise;
}
