
import 'package:bokashi/features/splash/controllers/splash_controller.dart';
import 'package:bokashi/features/splash/domain/models/business_pages_model.dart';
import 'package:bokashi/main.dart';
import 'package:provider/provider.dart';

class HtmlPagesHelper{

  final splashController = Provider.of<SplashController>(Get.context!, listen: false);

  BusinessPageModel? hasPrivacyPolicy = Provider.of<SplashController>(Get.context!, listen: false)
      .businessPages!.firstWhere((page) => page.slug == 'privacy-policy');

}