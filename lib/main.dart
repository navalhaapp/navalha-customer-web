import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/approved_schedule/approved_schedule_page.dart';
import 'package:navalha/core/navalha_routes.dart';
import 'package:navalha/core/theme.dart';
import 'package:navalha/firebase_options.dart';
import 'package:navalha/web/appointment/reset_page/reset_page.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/forget_password_page_web.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_social_network_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_web.dart';
import 'package:navalha/web/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.base;
    String barberShopId = uri.queryParameters['id'] ?? '';

    return MaterialApp(
      title: 'Navalha',
      debugShowCheckedModeBanner: false,
      theme: NavalhaTheme.themeData,
      color: Colors.black,
      initialRoute: uri.path.isEmpty ? '/' : uri.path,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return animatedRoute(HomePageWeb(barberShopId: barberShopId),
                routeName: '/');
          case '/login':
            return animatedRoute(const LoginPageWeb(), routeName: '/login');
          case '/calendar':
            return animatedRoute(const CalendarPageWeb(),
                routeName: '/calendar');
          case '/forget':
            return animatedRoute(const ForgetPasswordPageWeb(),
                routeName: '/forget');
          case '/register':
            return animatedRoute(const RegistrationPageClientWeb(),
                routeName: '/register');
          case '/register-social':
            return animatedRoute(const RegistrationSocialNetworksWeb(),
                routeName: '/register-social');
          case '/reset-password':
            return animatedRoute(ResetPasswordPage(),
                routeName: '/reset-password');
          case '/approved':
            final args = settings.arguments as Map<String, dynamic>;
            return animatedRoute(
                ApprovedSchedulePage(page: '/calendar', arguments: args),
                routeName: '/approved');
          case '/approved/fit-service':
            final args = settings.arguments as Map<String, dynamic>;
            return animatedRoute(
                ApprovedSchedulePage(page: '/', arguments: args),
                routeName: '/approved/fit-service');
          default:
            return animatedRoute(HomePageWeb(barberShopId: barberShopId),
                routeName: '/');
        }
      },

      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('pt_BR')],
      locale: const Locale('pt', 'BR'),
    );
  }
}
