part of '../account_page.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kRalewayMedium.copyWith(fontSize: 16.sp),
        ),
        const SizedBox(
          height: kSpace,
        ),
        Text(
          value,
          style: kRalewayMedium.copyWith(color: kGrey, fontSize: 16.sp),
        ),
        const SizedBox(
          height: kSpace,
        ),
      ],
    );
  }
}
