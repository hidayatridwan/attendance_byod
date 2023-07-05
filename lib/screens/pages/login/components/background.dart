part of '../login_page.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        child: Stack(
          children: [
            Positioned(
                right: 0,
                bottom: 0,
                width: SizeConfig.screenWidth * 0.3,
                child: Image.asset(loginBottom)),
            child
          ],
        ),
      ),
    );
  }
}
