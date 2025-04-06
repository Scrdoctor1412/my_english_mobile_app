import 'package:englens/src/data/models/user_internal.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/home/home_screen.dart';
import 'package:englens/src/ui/screens/home/home_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/login/forget_password/forget_password_screen.dart';
import 'package:englens/src/ui/screens/login/forget_password/forget_password_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/login/login_screen.dart';
import 'package:englens/src/ui/screens/login/login_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/settings/settings_screen.dart';
import 'package:englens/src/ui/screens/settings/settings_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/study/study_screen.dart';
import 'package:englens/src/ui/screens/study/study_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen_viewmodel.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouter {
  static String INITIAL = TabsScreen.routeName;

  static navigateDefaultScreen() async {
    UserInternal userInternal = UserInternal();
    AuthService authController = Get.put(AuthService());
    if (authController.user.value != null) {
      AppRouter.INITIAL = TabsScreen.routeName;
    } else {
      AppRouter.INITIAL = LoginScreen.routeName;
    }
  }

  static final List<GetPage> routes = [
    GetPage(
      name: LoginScreen.routeName,
      page: () => LoginScreen(),
      binding: GetBinding(LoginScreen.routeName),
    ),
    GetPage(
      name: ForgetPasswordScreen.routeName,
      page: () => ForgetPasswordScreen(),
      binding: GetBinding(ForgetPasswordScreen.routeName),
    ),
    GetPage(
      name: TabsScreen.routeName,
      page: () => TabsScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: EnglishHandbookScreen.routeName,
      page: () => EnglishHandbookScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => HomeScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: ScanToTranslateScreen.routeName,
      page: () => ScanToTranslateScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: SettingsScreen.routeName,
      page: () => SettingsScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: StudyScreen.routeName,
      page: () => StudyScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: WordSearchScreen.routeName,
      page: () => WordSearchScreen(),
      binding: GetBinding(WordSearchScreen.routeName),
    )
  ];
}

class GetBinding extends Bindings {
  final String routeName;

  GetBinding(this.routeName);

  @override
  void dependencies() {
    // TODO: implement dependencies
    switch (routeName) {
      case LoginScreen.routeName:
        Get.lazyPut(() => LoginScreenViewmodel());
        Get.lazyPut(() => AuthService());
        break;
      case ForgetPasswordScreen.routeName:
        Get.lazyPut(() => ForgetPasswordScreenViewmodel());
        break;
      case TabsScreen.routeName:
        Get.lazyPut(() => TabsScreenViewmodel());
        Get.lazyPut(() => EnglishHandbookScreenViewmodel());
        Get.lazyPut(() => HomeScreenViewmodel());
        Get.lazyPut(() => ScanToTranslateScreenViewmodel());
        Get.lazyPut(() => SettingsScreenViewmodel());
        Get.lazyPut(() => StudyScreenViewmodel());
        break;
      case WordSearchScreen.routeName:
        Get.lazyPut(() => WordSearchScreenViewmodel());
        break;
    }
  }
}

// class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
//   static String routeCurrentName = '';

//   void _sendScreenView(PageRoute<dynamic> route) {
//     routeCurrentName = route.settings.name!;
//     var screenName = route.settings.name;
//     print('screenName $screenName');
//     if (route.settings.name != '/') {
//       if (route.settings.name == TabsScreen.routeName)
//         // GuideLineManager().get(HomePage.routeName);
//         GuideLineManager
//       else
//         GuideLineManager().get(route.settings.name);
//     }
//     // do something with it, ie. send it to your analytics service collector
//   }

//   @override
//   void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//     // hide keyboard
//     FocusManager.instance.primaryFocus?.unfocus();
//     super.didPush(route, previousRoute);
//     if (route is PageRoute) {
//       _sendScreenView(route);
//     }
//   }

//   @override
//   void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//     if (newRoute is PageRoute) {
//       _sendScreenView(newRoute);
//     }
//   }

//   @override
//   void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
//     // hide keyboard
//     FocusManager.instance.primaryFocus?.unfocus();
//     super.didPop(route, previousRoute);
//     if (previousRoute is PageRoute && route is PageRoute) {
//       _sendScreenView(previousRoute);
//     }
//   }
// }
