import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobal/Screen/Home.dart';
import 'package:mobal/Service/status/CheckboxProvider.dart';
import 'package:mobal/Service/status/InputProvider.dart';
import 'package:mobal/common/utils.dart';
import 'package:mobal/constants/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  var mainpage = dotenv.env['MAIN'];
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
  final String? mainPage;
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
        title: 'Sosang',
        theme: ThemeData(pageTransitionsTheme: _removeTransitions()),
        initialRoute: "/${mainPage!}",
        debugShowCheckedModeBanner: false,
        routes: {"/$PAGE_HOME_PAGE": (context) => Home()},
        home: Builder(
          builder: (BuildContext context) {
            ScreenUtil.init(context);
            return Home();
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
