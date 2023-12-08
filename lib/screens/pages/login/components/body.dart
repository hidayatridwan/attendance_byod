part of '../login_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final karyawanBloc = context.read<KaryawanBloc>();
    final kordinatBloc = context.read<KordinatBloc>();

    final TextEditingController nikController = TextEditingController(text: '');
    final TextEditingController passwordController =
        TextEditingController(text: '');

    return Background(
        child: Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            width: kWidthImage,
            child: Lottie.asset(login),
          ),
          const Spacer(),
          RoundedInputField(
            hintText: 'NIK',
            icon: Icons.person,
            controller: nikController,
          ),
          const SizedBox(
            height: kSpace,
          ),
          RoundedInputField(
              hintText: 'Password',
              icon: Icons.lock,
              controller: passwordController,
              password: true),
          const SizedBox(
            height: kSpace,
          ),
          BlocConsumer<KaryawanBloc, KaryawanState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                kordinatBloc.add(GetKordinatEvent(nikController.text));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
              }
              if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.error,
                    style: kRalewayRegular.copyWith(color: kWhite),
                  ),
                  backgroundColor: kRed,
                ));
              }
            },
            builder: (context, state) {
              return RoundedButton(
                text: 'Login',
                press: () {
                  karyawanBloc.add(
                      LoginEvent(nikController.text, passwordController.text));
                },
                loading: state is LoginLoading ? true : false,
              );
            },
          ),
          const Spacer(),
          IsRegistered(
            login: true,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                  ));
            },
          ),
        ],
      ),
    ));
  }
}
