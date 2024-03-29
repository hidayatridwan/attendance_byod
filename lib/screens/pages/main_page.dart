import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/pages/account/account_page.dart';
import '../../screens/pages/log/log_page.dart';
import '../../screens/pages/attendance/attendance_page.dart';
import '../../shared/shared.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageIndex == 0
            ? const AttendancePage()
            : _pageIndex == 1
                ? const LogPage()
                : const AccountPage(),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: CustomNavigationBar(
            elevation: 0,
            iconSize: 30.sp,
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
                      color: _pageIndex == 0 ? kPurple : kGrey,
                      fontSize: 16.sp),
                ),
              ),
              CustomNavigationBarItem(
                icon: Icon(_pageIndex == 1
                    ? Icons.calendar_month_outlined
                    : Icons.calendar_today),
                title: Text('Logs',
                    style: kRalewayMedium.copyWith(
                        color: _pageIndex == 1 ? kPurple : kGrey,
                        fontSize: 16.sp)),
              ),
              CustomNavigationBarItem(
                icon: Icon(_pageIndex == 2
                    ? Icons.account_circle
                    : Icons.account_circle_outlined),
                title: Text('Account',
                    style: kRalewayMedium.copyWith(
                        color: _pageIndex == 2 ? kPurple : kGrey,
                        fontSize: 16.sp)),
              ),
            ],
            currentIndex: _pageIndex,
            onTap: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
          ),
        ));
  }
}
