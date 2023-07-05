part of 'widgets.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(4),
          horizontal: getProportionateScreenWidth(12)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kLightGrey,
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: child,
    );
  }
}
