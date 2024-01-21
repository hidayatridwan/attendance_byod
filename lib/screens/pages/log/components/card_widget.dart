part of '../log_page.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.index,
      required this.dateStart,
      required this.dateEnd,
      required this.checkIn,
      required this.checkOut});

  final int index;
  final DateTime dateStart;
  final DateTime dateEnd;
  final bool checkIn;
  final bool checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: index == 0 ? kSpace : 0),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: kWhite,
          border: Border(bottom: BorderSide(color: kLightGrey, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.EEEE().format(dateStart),
                style: kRalewayMedium.copyWith(fontSize: 16.sp),
              ),
              Text(DateFormat.yMMMMd().format(dateStart),
                  style: kRalewayRegular.copyWith(fontSize: 14.sp))
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
                label: Text(
                    dateStart == dateEnd
                        ? 'Not yet'
                        : DateFormat.Hms().format(dateEnd),
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
