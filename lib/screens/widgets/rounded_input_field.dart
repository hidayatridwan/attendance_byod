part of 'widgets.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.password = false})
      : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: password,
        style: kRalewayRegular,
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
