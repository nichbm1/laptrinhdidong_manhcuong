import 'package:app_sv/model/profile.dart';
import 'package:app_sv/provides/addressmodel.dart';
import 'package:app_sv/provides/courseviewmodel.dart';
import 'package:app_sv/provides/forgotviewmodel.dart';
import 'package:app_sv/provides/loginviewmodel.dart';
import 'package:app_sv/provides/mainviewmidel.dart';
import 'package:app_sv/provides/menubarviewmodel.dart';
import 'package:app_sv/provides/registerviewmodel.dart';
import 'package:app_sv/services/api_services.dart';
import 'package:app_sv/ui/page_forgot_password.dart';
import 'package:app_sv/ui/page_login.dart';
import 'package:app_sv/ui/page_main.dart';
import 'package:app_sv/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provides/profileviewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ApiServices api = ApiServices();
  api.initialize();
  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(),
      ),
      ChangeNotifierProvider<ForgotViewModel>(
        create: (context) => ForgotViewModel(),
      ),
      ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel(),
      ),
      ChangeNotifierProvider<MenuBarViewModel>(
        create: (context) => MenuBarViewModel(),
      ),
      ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider<AddressModel>(
        create: (context) => AddressModel(),
      ),
      ChangeNotifierProvider<CourseViewModel>(
        create: (context) => CourseViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const MainPage(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        // ignore: prefer_const_constructors
        '/forgot_password': (context) => PageForgotPassword(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
