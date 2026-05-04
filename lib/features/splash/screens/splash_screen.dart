import 'package:flutter/material.dart';
import 'package:bokashi/common/basewidget/bouncy_widget.dart';
import 'package:bokashi/features/splash/controllers/splash_controller.dart';
import 'package:bokashi/features/splash/domain/models/config_model.dart';
import 'package:bokashi/helper/network_info.dart';
import 'package:bokashi/helper/route_healper.dart';
import 'package:bokashi/main.dart';
import 'package:bokashi/push_notification/models/notification_body.dart';
import 'package:bokashi/features/auth/controllers/auth_controller.dart';
import 'package:bokashi/theme/controllers/theme_controller.dart';
import 'package:bokashi/utill/app_constants.dart';
import 'package:bokashi/utill/custom_themes.dart';
import 'package:bokashi/utill/dimensions.dart';
import 'package:bokashi/utill/images.dart';
import 'package:bokashi/common/basewidget/no_internet_screen_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  // late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    // bool firstTime = true;
    // _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if(!firstTime) {
    //     bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
    //     isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: isNotConnected ? Colors.red : Colors.green,
    //       duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //       content: Text(isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!,
    //         textAlign: TextAlign.center)));
    //     if(!isNotConnected) {
    //       _route();
    //     }
    //   }
    //   firstTime = false;
    // });

    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    // _onConnectivityChanged.cancel();
  }

  void _route() {
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashController>(context, listen: false).initConfig(context,
        (ConfigModel? configModel) {
      Provider.of<SplashController>(Get.context!, listen: false)
          .initSharedPrefData();
      final config = Provider.of<SplashController>(Get.context!, listen: false)
          .configModel;

      Future.delayed(const Duration(milliseconds: 0)).then((_) {
        if (config?.maintenanceModeData?.maintenanceStatus == 1 &&
            config?.maintenanceModeData?.selectedMaintenanceSystem
                    ?.customerApp ==
                1 &&
            !Provider.of<SplashController>(Get.context!, listen: false)
                .isConfigCall) {
          RouterHelper.getMaintenanceRoute(action: RouteAction.pushReplacement);
        } else if (Provider.of<AuthController>(Get.context!, listen: false)
            .isLoggedIn()) {
          Provider.of<AuthController>(Get.context!, listen: false)
              .updateToken(Get.context!);
          if (widget.body != null) {
            if (widget.body!.type == 'order') {
              RouterHelper.getOrderDetailsScreenRoute(
                action: RouteAction.pushReplacement,
                orderId: widget.body!.orderId!,
              );
            } else if (widget.body!.type == 'notification') {
              RouterHelper.getNotificationRoute(
                  action: RouteAction.pushReplacement);
            } else if (widget.body!.type == 'wallet') {
              RouterHelper.getWalletRoute(
                  action: RouteAction.pushReplacement, isBackButtonExist: true);
            } else if (widget.body!.type == 'chatting') {
              RouterHelper.getInboxScreenRoute(
                action: RouteAction.pushReplacement,
                isBackButtonExist: true,
                fromNotification: true,
                initIndex:
                    widget.body!.messageKey == 'message_from_delivery_man'
                        ? 0
                        : 1,
              );
            } else if (widget.body!.type == 'product_restock_update') {
              RouterHelper.getProductDetailsRoute(
                  action: RouteAction.pushReplacement,
                  productId: int.parse(widget.body!.productId!),
                  slug: widget.body!.slug,
                  isNotification: true);
            } else {
              RouterHelper.getNotificationRoute(
                  action: RouteAction.pushReplacement, fromNotification: true);
            }
          } else {
            // Navigator.of(Get.context!).pushReplacement(
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) => const DashBoardScreen(),
            //     transitionDuration: Duration.zero, // Removes transition duration
            //     reverseTransitionDuration: Duration.zero, // Removes reverse transition
            //     transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            //   ),
            // );

            RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);
          }
        } else if (Provider.of<SplashController>(Get.context!, listen: false)
            .showIntro()!) {
          RouterHelper.getOnboardingRoute(
            action: RouteAction.pushReplacement,
            indicatorColor: Provider.of<ThemeController>(Get.context!).darkTheme
                ? Theme.of(Get.context!).colorScheme.onTertiary
                : Theme.of(Get.context!).hintColor,
            selectedIndicatorColor: Theme.of(Get.context!).primaryColor,
          );
        } else {
          if (Provider.of<AuthController>(Get.context!, listen: false)
                      .getGuestToken() !=
                  null &&
              Provider.of<AuthController>(Get.context!, listen: false)
                      .getGuestToken() !=
                  '1') {
            // Navigator.of(Get.context!).pushReplacement(
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) => const DashBoardScreen(),
            //     transitionDuration: Duration.zero, // Removes transition duration
            //     reverseTransitionDuration: Duration.zero, // Removes reverse transition
            //     transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            //   ),
            // );

            RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);
          } else {
            Provider.of<AuthController>(Get.context!, listen: false)
                .getGuestIdUrl();
            RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);

            // Navigator.of(Get.context!).pushReplacement(
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) => const DashBoardScreen(),
            //     transitionDuration: Duration.zero, // Removes transition duration
            //     reverseTransitionDuration: Duration.zero, // Removes reverse transition
            //     transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
            //   ),
            // );
          }
        }
      });
      //  });
    }, (ConfigModel? configModel) {
      Provider.of<SplashController>(Get.context!, listen: false)
          .initSharedPrefData();
      final config = Provider.of<SplashController>(Get.context!, listen: false)
          .configModel;
      if (config?.maintenanceModeData?.maintenanceStatus == 1 &&
          config?.maintenanceModeData?.selectedMaintenanceSystem?.customerApp ==
              1 &&
          !config!.localMaintenanceMode!) {
        RouterHelper.getMaintenanceRoute(action: RouteAction.pushReplacement);
      } else if (Provider.of<AuthController>(Get.context!, listen: false)
              .isLoggedIn() &&
          !configModel!.hasLocaldb!) {
        Provider.of<AuthController>(Get.context!, listen: false)
            .updateToken(Get.context!);
        if (widget.body != null) {
          if (widget.body!.type == 'order') {
            RouterHelper.getOrderDetailsScreenRoute(
              action: RouteAction.pushReplacement,
              orderId: widget.body!.orderId!,
            );
          } else if (widget.body!.type == 'notification') {
            RouterHelper.getNotificationRoute(
                action: RouteAction.pushReplacement);
          } else if (widget.body!.type == 'wallet') {
            RouterHelper.getWalletRoute(
                action: RouteAction.pushReplacement, isBackButtonExist: true);
          } else if (widget.body!.type == 'chatting') {
            RouterHelper.getInboxScreenRoute(
              action: RouteAction.push,
              isBackButtonExist: true,
              fromNotification: true,
              initIndex: widget.body!.messageKey == 'message_from_delivery_man'
                  ? 0
                  : 1,
            );
          } else if (widget.body!.type == 'product_restock_update') {
            RouterHelper.getProductDetailsRoute(
                action: RouteAction.push,
                productId: int.parse(widget.body!.productId!),
                slug: widget.body!.slug,
                isNotification: true);
          } else {
            RouterHelper.getNotificationRoute(
                action: RouteAction.pushReplacement, fromNotification: true);
          }
        } else {
          RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);
        }
      } else if (Provider.of<SplashController>(Get.context!, listen: false)
              .showIntro()! &&
          !configModel!.hasLocaldb!) {
        RouterHelper.getOnboardingRoute(
          action: RouteAction.pushReplacement,
          indicatorColor:
              Provider.of<ThemeController>(Get.context!, listen: false)
                      .darkTheme
                  ? Theme.of(Get.context!).colorScheme.onTertiary
                  : Theme.of(Get.context!).hintColor,
          selectedIndicatorColor: Theme.of(Get.context!).primaryColor,
        );
      } else if (!configModel!.hasLocaldb! ||
          (configModel.hasLocaldb! &&
              configModel.localMaintenanceMode! &&
              !(config?.maintenanceModeData?.maintenanceStatus == 1 &&
                  config?.maintenanceModeData?.selectedMaintenanceSystem
                          ?.customerApp ==
                      1))) {
        if (Provider.of<AuthController>(Get.context!, listen: false)
                    .getGuestToken() !=
                null &&
            Provider.of<AuthController>(Get.context!, listen: false)
                    .getGuestToken() !=
                '1') {
          RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);
        } else {
          Provider.of<AuthController>(Get.context!, listen: false)
              .getGuestIdUrl();
          RouterHelper.getDashboardRoute(
              action: RouteAction.pushNamedAndRemoveUntil);
        }
      }
      // });
    }).then((bool isSuccess) {
      if (isSuccess) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      key: _globalKey,
      body: Provider.of<SplashController>(context).hasConnection
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                BouncyWidget(
                    duration: const Duration(milliseconds: 2000),
                    lift: 50,
                    ratio: 0.5,
                    pause: 0.25,
                    child: SizedBox(
                        width: 150,
                        child: Image.asset(Images.icon, width: 150.0))),
                Text(AppConstants.appName,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                        color: Colors.white)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Text(AppConstants.slogan,
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.white)))
              ]),
            )
          : const NoInternetOrDataScreenWidget(
              isNoInternet: true, child: SplashScreen()),
    );
  }
}
