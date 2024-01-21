import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../shared/shared.dart';
import '../../../bloc/log_absen/log_absen_bloc.dart';
import '../../../utility/prefs_data.dart';

part 'components/card_widget.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nik = PrefsData.instance.user!.nik;
    final date = DateTime.now();
    final formatDate = DateFormat('y-M-d');
    final period = formatDate.format(date);
    context.read<LogAbsenBloc>().add(GetLogAbsenEvent(nik, period));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logs',
          style: kRalewaySemiBold.copyWith(fontSize: 18.sp),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: kPurple,
                        ),
                        dialogBackgroundColor: kLightGrey,
                      ),
                      child: child!,
                    );
                  });
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String period = formatter.format(picked!);
              context.read<LogAbsenBloc>().add(GetLogAbsenEvent(nik, period));
            },
            icon: const Icon(
              Icons.calendar_month,
              color: kYellow,
            ),
          )
        ],
      ),
      body: BlocBuilder<LogAbsenBloc, LogAbsenState>(
        builder: (context, state) {
          if (state is LogAbsenLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kPurple,
              ),
            );
          }
          if (state is LogAbsenSuccess) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text('No data fetched'),
              );
            }
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final data = state.data[index];

                DateTime dateStart = DateTime.parse(data.jamDatang!);
                DateTime dateEnd = DateTime.parse(data.jamPulang!);

                bool checkIn = true;
                bool checkOut = true;

                if (dateStart.hour >= 8 && dateStart.minute >= 1) {
                  checkIn = false;
                }
                if (dateEnd.hour < 17) {
                  checkOut = false;
                }
                return CardWidget(
                  index: index,
                  dateStart: dateStart,
                  dateEnd: dateEnd,
                  checkIn: checkIn,
                  checkOut: checkOut,
                );
              },
            );
          }
          if (state is LogAbsenError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: Text('Failed to load data'),
          );
        },
      ),
    );
  }
}
