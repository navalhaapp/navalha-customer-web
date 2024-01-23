// import 'dart:html';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/splash/splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var fBTokenController = ref.watch(fBTokenProvider.state);

      fBTokenController.state = await initializeFcm();
    });
    super.initState();
  }

  Future<String> initializeFcm() async {
    final token = await messaging.getToken();
    return token!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.transparent,
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        cupertinoOverrideTheme:
            MaterialBasedCupertinoThemeData(materialTheme: ThemeData()),
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.dark(background: Colors.transparent),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
      ),
      color: Colors.black,
      // builder: DevicePreview.appBuilder,
      initialRoute: kIsWeb ? AppRoutes.servicesPageWeb : AppRoutes.splashPage,
      onGenerateRoute: (settings) {
        if (kIsWeb) {
          // final url = Uri.dataFromString(window.location.href);
          // Map<String, String> params = url.queryParameters;
          // var origin = params['id'];
          // return MaterialPageRoute(
          //   // builder: (context) => LoginPageWeb(),
          //   builder: (context) => ServicesPageWeb(url: origin),
          // );
        } else {
          return MaterialPageRoute(
            builder: (context) => const SplashPage(),
          );
        }
      },
      // routes: appRoutes,÷
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('pt_BR')],
      locale: const Locale('pt', 'BR'),
    );
  }
}

class AppRoutes {
  static const String servicesPageWeb = '/services-page-web';
  static const String splashPage = '/splash';
}
