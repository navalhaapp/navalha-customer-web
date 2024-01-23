// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:navalha/web/appointment/appointment_page.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import 'package:navalha/web/appointment/widgets/professional_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_second_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_third_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_password_web.dart';
import 'package:navalha/web/appointment/widgets/resume_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import '../mobile/calendar/calendar_page.dart';
import '../mobile/change_location/change_location.dart';
import '../mobile/change_password/change_password_page.dart';
import '../mobile/customer_registration/customer_registration.dart';
import '../mobile/drawer/drawer_page.dart';
import '../mobile/edit_profile/edit_profile_page.dart';
import '../mobile/faq/faq_page.dart';
import '../mobile/forget_password/forget_password_page.dart';
import '../mobile/home/home_page.dart';
import '../mobile/login/login_page.dart';
import '../mobile/my_packages/my_packages_page.dart';
import '../mobile/register/registration_page_client.dart';
import '../mobile/register/registration_page_client_second.dart';
import '../mobile/register/registration_page_client_third.dart';
import '../mobile/register/registration_password.dart';
import '../mobile/splash/splash_page.dart';
import '../web/appointment/widgets/register_web/registration_page_client_web.dart';

var appRoutes = {
  SplashPage.route: (context) => const SplashPage(),
  AppointmentWebPage.route: (context) => const AppointmentWebPage(),
  CustomerRegistrationPage.route: (context) => const CustomerRegistrationPage(),
  ChangePasswordPage.route: (context) => ChangePasswordPage(),
  HomePage.route: (context) => const HomePage(),
  RegistrationPageClient.route: (context) => const RegistrationPageClient(),
  RegistrationPageClientSecond.route: (context) =>
      const RegistrationPageClientSecond(),
  RegistrationPageClientThird.route: (context) =>
      const RegistrationPageClientThird(),
  LoginPage.route: (context) => const LoginPage(),
  RegistrationPassword.route: (context) => RegistrationPassword(),
  DrawerPage.route: (context) => const DrawerPage(),
  CalendarPage.route: (context) => const CalendarPage(),
  CalendarPageWeb.route: (context) => const CalendarPageWeb(),
  EditProfilePage.route: (context) => const EditProfilePage(),
  FaqPage.route: (context) => const FaqPage(),
  ForgetPasswordPage.route: (context) => const ForgetPasswordPage(),
  ChangeLocations.route: (context) => const ChangeLocations(),
  ServicesPageWeb.route: (context) => const ServicesPageWeb(),
  LoginPageWeb.route: (context) => const LoginPageWeb(),
  ResumePageWeb.route: (context) => const ResumePageWeb(),
  RegistrationPageClientWeb.route: (context) =>
      const RegistrationPageClientWeb(),
  RegistrationPageClientSecondWeb.route: (context) =>
      const RegistrationPageClientSecondWeb(),
  RegistrationPageClientThirdWeb.route: (context) =>
      const RegistrationPageClientThirdWeb(),
  RegistrationPasswordWeb.route: (context) => RegistrationPasswordWeb(),
};

List<Widget> listPage = [
  const CalendarPage(),
  const EditProfilePage(),
  const HomePage(),
  const MyPackagesPage(),
  const FaqPage(),
];
var onUnknownRoute = (context) {
  return MaterialPageRoute(
    builder: (context) {
      return Container(
        color: Colors.amber,
        height: 50,
        width: 50,
        child: const Text('nao encontrado'),
      );
    },
  );
};
