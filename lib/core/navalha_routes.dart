import 'package:flutter/material.dart';
import 'package:navalha/approved_schedule/approved_schedule_page.dart';
import 'package:navalha/web/appointment/reset_page/reset_page.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/forget_password_page_web.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import 'package:navalha/web/appointment/widgets/professional_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_social_network_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_web.dart';
import 'package:navalha/web/appointment/widgets/resume_page_web.dart';
import 'package:navalha/web/appointment/widgets/select_hours_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';

class NavalhaRoutes {
  NavalhaRoutes({required this.barberShopId});
  final String barberShopId;

  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => ServicesPageWeb(barberShopId: barberShopId),
      '/select-professional': (context) => ProfessionalPageWeb(),
      '/select-hour': (context) => const SelectHoursPageWeb(),
      '/resume': (context) => const ResumePageWeb(),
      '/login': (context) => const LoginPageWeb(),
      '/calendar': (context) => const CalendarPageWeb(),
      '/forget': (context) => const ForgetPasswordPageWeb(),
      '/register': (context) => const RegistrationPageClientWeb(),
      '/register-social': (context) => const RegistrationSocialNetworksWeb(),
      '/reset-password': (context) => ResetPasswordPage(),
      '/approved': (context) =>
          const ApprovedSchedulePage(page: CalendarPageWeb()),
    };
  }
}
