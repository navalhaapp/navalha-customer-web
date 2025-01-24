import 'package:flutter/material.dart';


class NavalhaRoutes {
  NavalhaRoutes({required this.barberShopId});
  final String barberShopId;

  // Map<String, WidgetBuilder> getRoutes() {
  //   return {
  //     '/': (context) => ServicesPageWeb(barberShopId: barberShopId),
  //     '/': (context) => HomePageWeb(barberShopId: barberShopId),
  //     '/select-professional': (context) => ProfessionalPageWeb(),
  //     '/select-hour': (context) => const SelectHoursPageWeb(),
  //     '/resume': (context) => const ResumePageWeb(),
  //     '/login': (context) => const LoginPageWeb(),
  //     '/calendar': (context) => const CalendarPageWeb(),
  //     '/forget': (context) => const ForgetPasswordPageWeb(),
  //     '/register': (context) => const RegistrationPageClientWeb(),
  //     '/register-social': (context) => const RegistrationSocialNetworksWeb(),
  //     '/reset-password': (context) => ResetPasswordPage(),
  //     '/approved': (context) => const ApprovedSchedulePage(page: '/calendar'),
  //     '/approved/fit-service': (context) =>
  //         const ApprovedSchedulePage(page: '/'),
  //   };
  // }
}

PageRouteBuilder animatedRoute(Widget page, {String? routeName}) {
  return PageRouteBuilder(
    settings: RouteSettings(name: routeName),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutQuart),
      );

      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      );

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}
