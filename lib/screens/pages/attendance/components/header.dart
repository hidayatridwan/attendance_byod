part of '../attendance_page.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.nama, required this.jabatan})
      : super(key: key);

  final String nama;
  final String jabatan;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    return Container(
      width: double.infinity,
      height: 65.h,
      padding: const EdgeInsets.only(
          left: kPadding / 2, top: kPadding, right: kPadding / 2, bottom: 0),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama.toUpperCase(),
                style:
                    kRalewaySemiBold.copyWith(color: kWhite, fontSize: 18.sp),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              Text(
                jabatan,
                style: kRalewayRegular.copyWith(
                  color: kYellow,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
