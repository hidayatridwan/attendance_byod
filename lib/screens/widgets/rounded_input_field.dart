part of 'widgets.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.password = false,
      this.color = kLightGrey})
      : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool password;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      child: TextField(
        controller: controller,
        obscureText: password,
        style: kRalewayRegular.copyWith(fontSize: 14.sp),
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: kPurple,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
