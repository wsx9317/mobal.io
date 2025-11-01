import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobal/Screen/Home.dart';
import 'package:mobal/Service/status/CheckboxProvider.dart';
import 'package:mobal/Service/status/InputProvider.dart';
import 'package:mobal/common/utils.dart';
import 'package:mobal/constants/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 사용 제거 — GitHub Pages에서는 파일 접근 불가
  const mainpage = "HOME";

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputProvider()),
        ChangeNotifierProvider(create: (_) => CheckboxProvider()),
      ],
      child: MyApp(mainPage: mainpage),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String mainPage;
  const MyApp({super.key, required this.mainPage});

  @override
  Widget build(BuildContext context) {
    PageTransitionsTheme _removeTransitions() {
      return PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values)
            platform: const _NoTransitionsBuilder(),
        },
      );
    }

    return SafeArea(
      child: MaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          },
        ),
        title: 'Mobal',
        theme: ThemeData(pageTransitionsTheme: _removeTransitions()),
        // .env 대신 직접 지정한 mainPage 사용
        initialRoute: "/$mainPage",
        debugShowCheckedModeBanner: false,
        routes: {"/$PAGE_HOME_PAGE": (context) => const Home()},
        home: Builder(
          builder: (BuildContext context) {
            ScreenUtil.init(context);
            return const Home();
          },
        ),
      ),
    );
  }
}

class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
