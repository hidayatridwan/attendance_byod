import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/account/account_bloc.dart';
import '../../../screens/pages/change_password/change_password_page.dart';
import '../../../shared/shared.dart';
import '../../../utility/prefs_data.dart';
import '../login/login_page.dart';

part 'components/card_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nik = PrefsData.instance.user!.nik;
    context.read<AccountBloc>().add(GetAccountEvent(nik));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: kRalewaySemiBold.copyWith(fontSize: 18.sp),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kPurple,
              ),
            );
          }
          if (state is AccountSuccess) {
            return ListView(
              children: [
                Container(
                    margin: const EdgeInsets.all(kPadding),
                    padding: const EdgeInsets.all(kPadding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      color: kWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardWidget(
                          label: 'NIK',
                          value: state.data.nik,
                        ),
                        CardWidget(
                          label: 'Name',
                          value: state.data.nama,
                        ),
                        CardWidget(
                          label: 'Position',
                          value: state.data.jabatan,
                        ),
                        CardWidget(
                          label: 'Phone number',
                          value: state.data.noHp,
                        ),
                        CardWidget(
                          label: 'Email',
                          value: state.data.email ?? '-',
                        ),
                        CardWidget(
                          label: 'Date of birth',
                          value: state.data.tanggalLahir,
                        ),
                        CardWidget(
                          label: 'Address',
                          value: state.data.alamat,
                        ),
                      ],
                    )),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordPage(),
                          ));
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(kPadding / 1.3),
                        backgroundColor: kWhite,
                        side: const BorderSide(color: kBlack, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadius))),
                    child: Text(
                      'Change Password',
                      style: kRalewayRegular.copyWith(
                          color: Colors.black87, fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: OutlinedButton(
                    onPressed: () {
                      PrefsData.instance.clear();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(kPadding / 1.3),
                        backgroundColor: kWhite,
                        side: const BorderSide(color: kRed, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadius))),
                    child: Text(
                      'Logout',
                      style: kRalewayRegular.copyWith(
                          color: Colors.black87, fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
