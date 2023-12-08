part of '../login_page.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: 1.sh,
        child: Stack(
          children: [
            Positioned(
                right: 0,
                bottom: 0,
                width: 0.3.sw,
                child: Image.asset(loginBottom)),
            child
          ],
        ),
      ),
    );
  }
}
