import 'package:dartz/dartz.dart';
import 'package:englens/src/data/models/user_internal.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/study/expressions/expressions_screen.dart';
import 'package:englens/src/ui/screens/study/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_screen.dart';
import 'package:englens/src/ui/screens/study/pronunciation/pronunciation_screen.dart';
import 'package:englens/src/ui/screens/study/vocab/vocab_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
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
    //Login Screen
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

    //Tabs screen
    GetPage(
      name: TabsScreen.routeName,
      page: () => TabsScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),

    //English handbook screen
    GetPage(
      name: EnglishHandbookScreen.routeName,
      page: () => EnglishHandbookScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),

    //Home screen
    GetPage(
      name: HomeScreen.routeName,
      page: () => HomeScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),

    //Scan to translate screen
    GetPage(
      name: ScanToTranslateScreen.routeName,
      page: () => ScanToTranslateScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),

    //Settings screen
    GetPage(
      name: SettingsScreen.routeName,
      page: () => SettingsScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),

    //Study screen
    GetPage(
      name: StudyScreen.routeName,
      page: () => StudyScreen(),
      binding: GetBinding(TabsScreen.routeName),
    ),
    GetPage(
      name: VocabScreen.routeName,
      page: () => VocabScreen(),
      binding: GetBinding(VocabScreen.routeName),
    ),
    GetPage(
      name: PronunciationScreen.routeName,
      page: () => PronunciationScreen(),
      binding: GetBinding(PronunciationScreen.routeName),
    ),
    GetPage(
      name: GrammarScreen.routeName,
      page: () => GrammarScreen(),
      binding: GetBinding(GrammarScreen.routeName),
    ),
    GetPage(
      name: FlashcardsScreen.routeName,
      page: () => FlashcardsScreen(),
      binding: GetBinding(FlashcardsScreen.routeName),
    ),
    GetPage(
      name: ExpressionsScreen.routeName,
      page: () => ExpressionsScreen(),
      binding: GetBinding(ExpressionsScreen.routeName),
    ),

    //Word search screen
    GetPage(
      name: WordSearchScreen.routeName,
      page: () => WordSearchScreen(),
      binding: GetBinding(WordSearchScreen.routeName),
    ),

    //Lesson details screen
    GetPage(
      name: LessonDetailsScreen.routeName,
      page: () => LessonDetailsScreen(),
      binding: GetBinding(LessonDetailsScreen.routeName),
    ),

    //Words details screen
    GetPage(
      name: WordDetailsScreen.routeName,
      page: () => WordDetailsScreen(),
      binding: GetBinding(WordDetailsScreen.routeName),
    ),
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
      case WordDetailsScreen.routeName:
        Get.lazyPut(() => WordDetailsScreenViewmodel());
        break;
      case LessonDetailsScreen.routeName:
        Get.lazyPut(() => LessonsDetailsScreenViewmodel());
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
