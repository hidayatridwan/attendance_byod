import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'bloc/absen/absen_bloc.dart';
import 'bloc/map/map_bloc.dart';
import 'shared/shared.dart';
import 'bloc/kordinat/kordinat_bloc.dart';
import 'screens/pages/login/login_page.dart';
import 'utility/prefs_data.dart';
import 'utility/app_observer.dart';
import 'screens/pages/welcome/welcome_page.dart';
import 'bloc/karyawan/karyawan_bloc.dart';
import 'data/repositories/repositories.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await PrefsData.instance.init();
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider<KaryawanBloc>(
          create: (context) => KaryawanBloc(_karyawanRepository),
        ),
        BlocProvider<KordinatBloc>(
          create: (context) => KordinatBloc(_kordinatRepository),
        ),
        BlocProvider<MapBloc>(
          create: (context) => MapBloc(),
        ),
        BlocProvider<AbsenBloc>(
          create: (context) => AbsenBloc(_absenRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Raleway',
            appBarTheme: const AppBarTheme(
                color: kWhite,
                centerTitle: true,
                titleTextStyle: TextStyle(color: Colors.black87))),
        home: isFirstInstall ? const WelcomePage() : const LoginPage(),
      ),
    );
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
