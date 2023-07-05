part of '../attendance_page.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(150),
      padding: const EdgeInsets.only(
          left: kPadding / 2,
          top: kPadding,
          right: kPadding / 2,
          bottom: 6),
      decoration: const BoxDecoration(
          color: kDarkPurple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kLightGrey, width: 1)),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(userPic), fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(
            width: kSpace,
          ),
          BlocBuilder<KaryawanBloc, KaryawanState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.data.nama.toUpperCase(),
                      style: kRalewaySemiBold.copyWith(color: kWhite),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      state.data.jabatan,
                      style: kRalewayRegular.copyWith(
                        color: kYellow,
                      ),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
