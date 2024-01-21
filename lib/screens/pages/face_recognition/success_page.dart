import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../screens/pages/main_page.dart';
import '../../../screens/pages/login/login_page.dart';
import '../../../shared/shared.dart';
import '../../widgets/widgets.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            width: kWidthImage,
            child: Lottie.asset(success),
          ),
          const Spacer(),
          Text(
            'Post attendance successfully',
            textAlign: TextAlign.center,
            style: kRalewayBold.copyWith(fontSize: 25.sp),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: kPadding),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
              },
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(kPadding / 1.3),
                  backgroundColor: kWhite,
                  side: const BorderSide(color: kBlack, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius))),
              child: Text(
                'Okay',
                style: kRalewayRegular.copyWith(
                    color: Colors.black87, fontSize: 14.sp),
              ),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
