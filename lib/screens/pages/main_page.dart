import 'package:attendance_byod/bloc/absen/absen_bloc.dart';
import 'package:attendance_byod/screens/pages/account/account_page.dart';
import 'package:attendance_byod/screens/pages/log/log_page.dart';
import 'package:attendance_byod/utility/prefs_data.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/kordinat/kordinat_bloc.dart';
import '../../screens/pages/attendance/attendance_page.dart';
import '../../utility/size_config.dart';
import '../../shared/shared.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;
  final nik = PrefsData.instance.user!.nik;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: _pageIndex == 0
            ? const AttendancePage()
            : _pageIndex == 1
                ? const LogPage()
                : const AccountPage(),
        bottomNavigationBar: CustomNavigationBar(
          elevation: 0,
          iconSize: getProportionateScreenHeight(30),
          selectedColor: kPurple,
          strokeColor: kPurple,
          unSelectedColor: kGrey,
          backgroundColor: kWhite,
          items: [
            CustomNavigationBarItem(
              icon: Icon(_pageIndex == 0
                  ? Icons.fingerprint
                  : Icons.fingerprint_outlined),
              title: Text(
                'Attendance',
                style: kRalewayMedium.copyWith(
                    color: _pageIndex == 0 ? kPurple : kGrey),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(_pageIndex == 1
                  ? Icons.calendar_month_outlined
                  : Icons.calendar_today),
              title: Text('Logs',
                  style: kRalewayMedium.copyWith(
                      color: _pageIndex == 1 ? kPurple : kGrey)),
            ),
            CustomNavigationBarItem(
              icon: Icon(_pageIndex == 2
                  ? Icons.account_circle
                  : Icons.account_circle_outlined),
              title: Text('Account',
                  style: kRalewayMedium.copyWith(
                      color: _pageIndex == 2 ? kPurple : kGrey)),
            ),
          ],
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
            if (index == 1) {
              context.read<AbsenBloc>().add(LogEvent(nik));
            }
          },
        ));
  }
}
