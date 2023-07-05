import 'package:attendance_byod/screens/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/kordinat/kordinat_bloc.dart';
import '../../../screens/pages/main_page.dart';
import '../../../utility/prefs_data.dart';
import '../../../utility/size_config.dart';
import '../../../shared/shared.dart';
import '../../widgets/widgets.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key, required this.isRegistered}) : super(key: key);
  final bool isRegistered;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final nik = PrefsData.instance.user!.nik;
    final kordinatBloc = context.read<KordinatBloc>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            width: getProportionateScreenWidth(kWidthImage),
            child: Lottie.asset(success),
          ),
          const Spacer(),
          Text(
            'Successfully ${isRegistered ? 'Registered' : 'Absent'}',
            textAlign: TextAlign.center,
            style: kRalewayBold,
          ),
          const Spacer(),
          RoundedButton(
            text: 'Okay',
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      if(isRegistered) {
                        return const LoginPage();
                      }else{
                        kordinatBloc.add(GetKordinatEvent(nik));
                        return const MainPage();
                      }
                    }
                  ));
            },
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
