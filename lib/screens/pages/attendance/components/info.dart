part of '../attendance_page.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPadding),
      padding: const EdgeInsets.all(kPadding / 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: kWhite,
      ),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Column(
            children: [
              TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (context) {
                  return Text(
                    DateFormat.Hms().format(DateTime.now()),
                    style: kOpenSansRegular.copyWith(
                        fontSize: getProportionateScreenWidth(40),
                        fontWeight: FontWeight.w700),
                  );
                },
              ),
              TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (context) {
                  return Text(
                    DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                    style: kRalewayMedium,
                  );
                },
              ),
              const SizedBox(
                height: kSpace,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: state is SetMapAreaState
                        ? (state.isInSelectedArea ? kGreen : kRed)
                        : kRed,
                    size: getProportionateScreenWidth(25),
                  ),
                  const SizedBox(
                    width: kSpace / 2,
                  ),
                  Text(
                      state is SetMapAreaState
                          ? (state.isInSelectedArea ? 'In area' : 'Out of area')
                          : 'Out of area',
                      style: kRalewaySemiBold.copyWith(
                          color: state is SetMapAreaState
                              ? (state.isInSelectedArea ? kGreen : kRed)
                              : kRed)),
                ],
              ),
              const SizedBox(
                height: kSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state is SetMapAreaState &&
                              state.isInSelectedArea
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CameraPage(),
                                  ));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPurple,
                          textStyle: kRalewayRegular,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      child: const Text('Check In'),
                    ),
                  ),
                  const SizedBox(
                    width: kSpace,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: state is SetMapAreaState &&
                                state.isInSelectedArea
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CameraPage(),
                                    ));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPurple,
                            textStyle: kRalewayRegular,
                            padding: const EdgeInsets.symmetric(vertical: 20)),
                        child: const Text('Check Out')),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
