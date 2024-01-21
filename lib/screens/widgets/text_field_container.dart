part of 'widgets.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child, required this.color})
      : super(key: key);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(kBorderRadius)),
      child: child,
    );
  }
}
