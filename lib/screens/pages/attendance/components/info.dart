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
                        fontSize: 40.sp, fontWeight: FontWeight.w700),
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
                    size: 25.sp,
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
              ElevatedButton(
                onPressed: state is SetMapAreaState && state.isInSelectedArea
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CameraPage(),
                            ));
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kYellow,
                  foregroundColor: kPurple,
                  textStyle: kRalewayRegular.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w700),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: BlocBuilder<KordinatBloc, KordinatState>(
                    builder: (BuildContext context, state2) {
                  if (state2 is KordinatSuccess) {
                    final result =
                        state2.data.where((e) => e.nama == 'initial').toList();

                    if (result[0].jumlahAbsen > 0) {
                      return const Text('CHECK OUT');
                    } else {
                      return const Text('CHECK IN');
                    }
                  }
                  return const Text('Loading...');
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
