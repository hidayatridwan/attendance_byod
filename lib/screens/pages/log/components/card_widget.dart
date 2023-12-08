part of '../log_page.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.dateStart,
      required this.dateEnd,
      required this.checkIn,
      required this.checkOut});

  final DateTime dateStart;
  final DateTime dateEnd;
  final bool checkIn;
  final bool checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: kWhite,
          border: Border(bottom: BorderSide(color: kLightGrey, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.EEEE().format(dateStart),
                style: kRalewayMedium,
              ),
              Text(DateFormat.yMMMMd().format(dateStart),
                  style: kRalewayRegular)
            ],
          ),
          Row(
            children: [
              Chip(
                label: Text(DateFormat.Hms().format(dateStart),
                    style: kOpenSansRegular.copyWith(fontSize: 12.sp)),
                backgroundColor: checkIn ? kGreen : kRed,
                shape: const StadiumBorder(side: BorderSide(color: kWhite)),
              ),
              const SizedBox(
                width: 10,
              ),
              Chip(
                label: Text(DateFormat.Hms().format(dateEnd),
                    style: kOpenSansRegular.copyWith(fontSize: 12.sp)),
                backgroundColor: checkOut ? kGreen : kRed,
                shape: const StadiumBorder(side: BorderSide(color: kWhite)),
              )
            ],
          )
        ],
      ),
    );
  }
}
