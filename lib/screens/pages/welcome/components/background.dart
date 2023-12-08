part of '../welcome_page.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1.sh,
      child: Stack(
        children: [
          Positioned(
              left: 0, top: 0, width: 0.3.sw, child: Image.asset(mainTop)),
          Positioned(
              left: 0,
              bottom: 0,
              width: 0.3.sw,
              child: Image.asset(mainBottom)),
          child
        ],
      ),
    );
  }
}
