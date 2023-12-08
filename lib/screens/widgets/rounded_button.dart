part of 'widgets.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.disabled = false,
      this.loading = false})
      : super(key: key);
  final String text;
  final Function() press;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: TextButton(
            onPressed: disabled ? null : press,
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(20.r),
                backgroundColor: disabled ? kLightGrey : kPurple),
            child: loading
                ? SizedBox(
                    height: 20.sp,
                    width: 20.sp,
                    child: const CircularProgressIndicator(
                      color: kWhite,
                    ),
                  )
                : Text(
                    text,
                    style: kRalewayRegular.copyWith(
                        color: disabled ? kGrey : kWhite),
                  )),
      ),
    );
  }
}
