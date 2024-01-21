import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
import 'package:timer_builder/timer_builder.dart';

import '../../../bloc/kordinat/kordinat_bloc.dart';
import '../../../bloc/map/map_bloc.dart';
import '../../../shared/shared.dart';
import '../../../utility/prefs_data.dart';
import '../face_recognition/camera_page.dart';

part './components/header.dart';

part './components/maps.dart';

part './components/info.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    final nik = PrefsData.instance.user!.nik;
    final nama = PrefsData.instance.user!.nama;
    final jabatan = PrefsData.instance.user!.jabatan;
    context.read<KordinatBloc>().add(GetKordinatEvent(nik));

    return SizedBox(
      width: double.infinity,
      height: heightScreen,
      child: Column(
        children: [
          Header(nama: nama, jabatan: jabatan),
          const Maps(),
          SizedBox(
            height: 10.h,
          ),
          const Info(),
        ],
      ),
    );
  }
}
