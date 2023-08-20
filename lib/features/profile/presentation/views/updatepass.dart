import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/update_password_bloc.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldpassController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  final TextEditingController repeatpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(GetProfile());
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          S.current.changePassword,
          style: TextStyle(color: ColorManager.dark),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: kHeight(context) * .1,
                ),
                MainTFF(
                    labelText: S.current.oldpassword,
                    hintText: S.current.oldpassword,
                    controller: oldpassController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.oldpasswordEmpty;
                      } else {
                        if (value.length < 6) {
                          return S.current.passwordError;
                        }
                      }
                      return null;
                    },
                    isPassword: false,
                    borderRadius: 16,
                    inputType: TextInputType.text),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgotPassword);
                        },
                        child: Text(S.current.forgetPassword))),
                MainTFF(
                    labelText: S.current.newpassword,
                    hintText: S.current.newpassword,
                    controller: newpassController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.newpasswordEmpty;
                      } else {
                        if (value.length < 6) {
                          return S.current.passwordError;
                        }
                      }
                      return null;
                    },
                    isPassword: false,
                    borderRadius: 16,
                    inputType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                MainTFF(
                    labelText: S.current.repeatpassword,
                    hintText: S.current.repeatpassword,
                    controller: repeatpassController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.repeatpasswordEmpty;
                      } else {
                        if (value.length < 6) {
                          return S.current.passwordError;
                        }
                      }
                      return null;
                    },
                    isPassword: false,
                    borderRadius: 16,
                    inputType: TextInputType.text),
                const SizedBox(height: 30),
                BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
                  listener: (context, state) {
                    if (state is UpdatePasswordLoaded &&
                        state.data.status == '200') {
                      showSnackbar(S.current.updatepasssuccess, context,
                          ColorManager.green);
                    } else if (state is UpdatePasswordError) {
                      showSnackbar(state.message, context, Colors.red);
                    } else if (state is UpdatePasswordLoaded) {
                      showSnackbar(state.data.message!, context, Colors.red);
                    }
                  },
                  builder: (context, state) {
                    return state is UpdatePasswordLoading
                        ? const CircularProgressIndicator()
                        : MainButton(
                            text: S.current.updatePass.toUpperCase(),
                            height: 50,
                            ontab: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<UpdatePasswordBloc>(context)
                                    .add(
                                  UserUpdatePassword(
                                      oldpassController.text,
                                      newpassController.text,
                                      repeatpassController.text),
                                );
                              }
                            });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
