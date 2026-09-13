import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

abstract class ApplicationConfig extends Config {}

class AppInitializer {
  AppInitializer(this._applicationConfig);

  final ApplicationConfig _applicationConfig; // tính năng khởi tạo 1 lần ở class cha

  Future<void> init() async {
    EnvConstants.init();
    await SharedConfig.getInstance().init();  // từng packae
    await DataConfig.getInstance().init();
    await DomainConfig.getInstance().init();
    await _applicationConfig.init();
  }
}
