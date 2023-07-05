import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/karyawan/karyawan_bloc.dart';
import '../../../shared/shared.dart';
import '../../../utility/prefs_data.dart';
import '../../../utility/size_config.dart';
import '../login/login_page.dart';

part 'components/card_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Account',
            style: kRalewaySemiBold,
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(kPadding),
              padding: const EdgeInsets.all(kPadding),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                color: kWhite,
              ),
              child: BlocBuilder<KaryawanBloc, KaryawanState>(
                builder: (context, state) {
                  if (state is LoginSuccess) {
                    return Column(
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
                          label: 'Phone number',
                          value: state.data.noHp,
                        ),
                        CardWidget(
                          label: 'Email',
                          value: state.data.email,
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
                    );
                  }
                  return const SizedBox();
                },
              ),
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
                    side: const BorderSide(color: kYellow, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius))),
                child: Text(
                  'Logout',
                  style: kRalewayRegular.copyWith(color: Colors.black87),
                ),
              ),
            )
          ],
        ));
  }
}
