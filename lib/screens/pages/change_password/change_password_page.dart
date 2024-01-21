import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../bloc/change_password/change_password_bloc.dart';
import '../../../shared/shared.dart';
import '../../../utility/prefs_data.dart';
import '../../widgets/widgets.dart';
import '../login/login_page.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changePasswordBloc = context.read<ChangePasswordBloc>();
    final TextEditingController oldPasswordController =
        TextEditingController(text: '');
    final TextEditingController newPasswordController =
        TextEditingController(text: '');
    final TextEditingController confirmNewPasswordController =
        TextEditingController(text: '');
    final isLogin = PrefsData.instance.user;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Change Password',
            style: kRalewaySemiBold.copyWith(fontSize: 18.sp),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              RoundedInputField(
                hintText: 'Old Password',
                icon: Icons.lock,
                controller: oldPasswordController,
                color: kWhite,
                password: true,
              ),
              const SizedBox(
                height: kSpace,
              ),
              RoundedInputField(
                hintText: 'New Password',
                icon: Icons.lock_open,
                controller: newPasswordController,
                color: kWhite,
                password: true,
              ),
              const SizedBox(
                height: kSpace,
              ),
              RoundedInputField(
                hintText: 'Confirm New Password',
                icon: Icons.lock_open,
                controller: confirmNewPasswordController,
                color: kWhite,
                password: true,
              ),
              const SizedBox(
                height: kSpace,
              ),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                  listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message,
                      style: kRalewayRegular.copyWith(
                          color: kBlack, fontSize: 14.sp),
                    ),
                    backgroundColor: kGreen,
                  ));

                  PrefsData.instance.clear();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                }
                if (state is ChangePasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.error,
                      style: kRalewayRegular.copyWith(
                          color: kWhite, fontSize: 14.sp),
                    ),
                    backgroundColor: kRed,
                  ));
                }
              }, builder: (context, state) {
                return RoundedButton(
                  text: 'Change Password',
                  press: () {
                    changePasswordBloc.add(ChangeOldPasswordEvent(
                        isLogin!.nik,
                        oldPasswordController.text,
                        newPasswordController.text,
                        confirmNewPasswordController.text));
                  },
                  loading: state is ChangePasswordLoading ? true : false,
                );
              })
            ],
          ),
        ));
  }
}
