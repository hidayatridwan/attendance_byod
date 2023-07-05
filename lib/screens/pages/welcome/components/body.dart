part of '../welcome_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Background(
        child: Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Spacer(),
        SizedBox(
          width: getProportionateScreenWidth(kWidthImage),
          child: Lottie.asset(welcome),
        ),
        const Spacer(),
        Text(
          'Attendance with BYOD',
          textAlign: TextAlign.center,
          style: kRalewayBold,
        ),
        const SizedBox(
          height: kSpace,
        ),
        Text(
            'Jadikan HP anda sebagai absensi untuk masuk dan pulang kerja, supaya menatap masa depan yang lebih cerah',
            style: kRalewayRegular.copyWith(color: kDarkGrey),
            textAlign: TextAlign.center),
        const Spacer(
          flex: 3,
        ),
        RoundedButton(
          text: 'Get Started',
          press: () {
            PrefsData.instance.setFirstInstall();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
        ),
        const Spacer(),
      ]),
    ));
  }
}
