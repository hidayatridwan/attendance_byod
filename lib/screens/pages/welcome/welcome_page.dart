import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';
import '../../../screens/widgets/widgets.dart';
import '../../../utility/prefs_data.dart';
import '../login/login_page.dart';

part 'components/body.dart';

part 'components/background.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
