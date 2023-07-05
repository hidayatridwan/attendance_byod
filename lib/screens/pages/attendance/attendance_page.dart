import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
import 'package:timer_builder/timer_builder.dart';

import '../../../bloc/karyawan/karyawan_bloc.dart';
import '../../../bloc/kordinat/kordinat_bloc.dart';
import '../../../bloc/map/map_bloc.dart';
import '../../../shared/shared.dart';
import '../../../utility/size_config.dart';
import '../face_recognition/camera_page.dart';

part './components/header.dart';

part './components/maps.dart';

part './components/info.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight,
      child: const Column(
        children: [
          Header(),
          Maps(),
          Spacer(),
          Info(),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
