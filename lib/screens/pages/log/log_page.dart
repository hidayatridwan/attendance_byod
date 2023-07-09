import 'package:attendance_byod/shared/shared.dart';
import 'package:attendance_byod/utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/absen/absen_bloc.dart';
import '../../../utility/prefs_data.dart';

part 'components/card_widget.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTime date = DateTime.now();
    final nik = PrefsData.instance.user!.nik;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logs',
          style: kRalewaySemiBold,
        ),
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
              context.read<AbsenBloc>().add(LogEvent(nik, period));
            },
            icon: const Icon(
              Icons.calendar_month,
              color: kYellow,
            ),
          )
        ],
      ),
      body: BlocBuilder<AbsenBloc, AbsenState>(
        builder: (context, state) {
          if (state is LogLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kPurple,
              ),
            );
          }
          if (state is LogSuccess) {
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
                  dateStart: dateStart,
                  dateEnd: dateEnd,
                  checkIn: checkIn,
                  checkOut: checkOut,
                );
              },
            );
          }
          if (state is LogError) {
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
