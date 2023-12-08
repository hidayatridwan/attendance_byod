part of 'widgets.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kLightGrey,
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: child,
    );
  }
}
