part of 'widgets.dart';

class IsRegistered extends StatelessWidget {
  const IsRegistered({Key? key, required this.login, required this.press})
      : super(key: key);
  final bool login;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Don\'t have an account?' : 'Already have an account?',
          style: kRalewayRegular.copyWith(color: kPurple),
        ),
        TextButton(
          onPressed: press,
          child: Text(login ? 'Register' : 'Login',
              style:
                  kRalewaySemiBold.copyWith(color: kPurple, fontSize: 14.sp)),
        )
      ],
    );
  }
}
