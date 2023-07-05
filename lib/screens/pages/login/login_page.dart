import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/karyawan/karyawan_bloc.dart';
import '../../../bloc/kordinat/kordinat_bloc.dart';
import '../../widgets/widgets.dart';
import '../../../shared/shared.dart';
import '../../../utility/size_config.dart';
import '../face_recognition/camera_page.dart';
import '../main_page.dart';

part 'components/background.dart';
part 'components/body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
