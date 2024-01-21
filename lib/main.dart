import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data/models/karyawan_model.dart';
import 'screens/pages/main_page.dart';
import 'bloc/absen/absen_bloc.dart';
import 'bloc/account/account_bloc.dart';
import 'bloc/change_password/change_password_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/kordinat/kordinat_bloc.dart';
import 'bloc/map/map_bloc.dart';
import 'bloc/log_absen/log_absen_bloc.dart';
import 'shared/shared.dart';
import 'screens/pages/login/login_page.dart';
import 'utility/prefs_data.dart';
import 'utility/app_observer.dart';
import 'screens/pages/welcome/welcome_page.dart';
import 'data/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsData.instance.init();
  // PrefsData.instance.clear();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = AppObserver();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  final KaryawanRepository _karyawanRepository = KaryawanRepository();
  final KordinatRepository _kordinatRepository = KordinatRepository();
  final AbsenRepository _absenRepository = AbsenRepository();

  final isFirstInstall = PrefsData.instance.isFirstInstall;
  final userData = PrefsData.instance!.user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return ScreenUtilInit(
      designSize: const Size(360, 390),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(_karyawanRepository)),
            BlocProvider<KordinatBloc>(
                create: (context) => KordinatBloc(_kordinatRepository)),
            BlocProvider<AbsenBloc>(
                create: (context) => AbsenBloc(_absenRepository)),
            BlocProvider<MapBloc>(create: (context) => MapBloc()),
            BlocProvider<LogAbsenBloc>(
                create: (context) => LogAbsenBloc(_absenRepository)),
            BlocProvider<AccountBloc>(
                create: (context) => AccountBloc(_karyawanRepository)),
            BlocProvider<ChangePasswordBloc>(
                create: (context) => ChangePasswordBloc(_karyawanRepository))
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  fontFamily: 'Raleway',
                  appBarTheme: const AppBarTheme(
                      color: kWhite,
                      centerTitle: true,
                      titleTextStyle: TextStyle(color: Colors.black87)),
                  scaffoldBackgroundColor: kLightGrey),
              home: routePage(isFirstInstall, userData)),
        );
      },
    );
  }
}

Widget routePage(bool isFirstInstall, KaryawanModel? userData) {
  if (isFirstInstall) {
    return const WelcomePage();
  } else {
    if (userData == null) {
      return const LoginPage();
    } else {
      return const MainPage();
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
