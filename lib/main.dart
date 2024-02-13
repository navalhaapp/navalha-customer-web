import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/navalha_routes.dart';
import 'package:navalha/core/theme.dart';
import 'package:navalha/firebase_options.dart';

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
    String url = Uri.base.toString();
    String params = Uri.splitQueryString(url).values.first;

    return MaterialApp(
      title: 'Navalha',
      debugShowCheckedModeBanner: false,
      theme: NavalhaTheme.themeData,
      color: Colors.black,
      initialRoute: '/',
      routes: NavalhaRoutes(barberShopId: params).getRoutes(),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('pt_BR')],
      locale: const Locale('pt', 'BR'),
    );
  }
}
