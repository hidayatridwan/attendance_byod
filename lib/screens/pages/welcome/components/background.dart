part of '../welcome_page.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              top: 0,
              width: SizeConfig.screenWidth * 0.3,
              child: Image.asset(mainTop)),
          Positioned(
              left: 0,
              bottom: 0,
              width: SizeConfig.screenWidth * 0.3,
              child: Image.asset(mainBottom)),
          child
        ],
      ),
    );
  }
}
