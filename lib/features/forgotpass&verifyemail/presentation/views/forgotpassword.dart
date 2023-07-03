import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/utilities/endpoints.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../forgotpass&verifyemail_bloc/forgotpass&verifyemail_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController inputController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  VerifyStatus status = VerifyStatus.forgotPassword;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ForgetpasswordAndeVerifyEmailBloc,
              ForgetpasswordAndeVerifyEmailState>(
            builder: (context, state) {
              status =
                  BlocProvider.of<ForgetpasswordAndeVerifyEmailBloc>(context)
                      .status;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status == VerifyStatus.forgotPassword
                          ? S.current.forgetPasswordtext
                          : S.current.verify,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.dark,
                          ),
                    ),
                    SizedBox(
                      height: kHeight(context) * 0.1,
                    ),
                    Text(
                      status == VerifyStatus.forgotPassword
                          ? S.current.enteremail
                          : S.current.enterLink,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: status == VerifyStatus.forgotPassword
                          ? MainTFF(
                              labelText: S.current.email,
                              hintText: S.current.email,
                              controller: inputController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return S.current.emptyEmail;
                                } else {
                                  if (!value.contains('@')) {
                                    return S.current.invalidEmail;
                                  }
                                }
                                return null;
                              },
                              isPassword: false,
                              borderRadius: 16,
                              inputType: TextInputType.emailAddress)
                          : MainTFF(
                              labelText: S.current.code,
                              hintText: S.current.code,
                              controller: inputController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return S.current.codeEmpty;
                                } else {
                                  if (value.length < 9) {
                                    return S.current.invalidCode;
                                  }
                                }
                                return null;
                              },
                              isPassword: false,
                              borderRadius: 16,
                              inputType: TextInputType.text),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<ForgetpasswordAndeVerifyEmailBloc,
                        ForgetpasswordAndeVerifyEmailState>(
                      listener: (context, state) {
                        if (state is ForgetpasswordFinishedState) {
                          showSnackbar(
                              state.data.message, context, ColorManager.green);
                        } else if (state is ForgetpasswordErrorState) {
                          showSnackbar(state.message, context, Colors.red);
                        }
                      },
                      builder: (context, state) {
                        return state is ForgetpasswordLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : status == VerifyStatus.forgotPassword
                                ? MainButton(
                                    text: S.current.send.toUpperCase(),
                                    height: 50,
                                    ontab: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<
                                                    ForgetpasswordAndeVerifyEmailBloc>(
                                                context)
                                            .add(
                                                SendLink(inputController.text));
                                        formKey.currentState!.reset();
                                      }
                                    })
                                : MainButton(
                                    text: S.current.send.toUpperCase(),
                                    height: 50,
                                    ontab: () {
                                      if (formKey.currentState!.validate()) {
                                        PreferenceHelper
                                            .saveDataInSharedPreference(
                                                key: "code",
                                                value: inputController.text);
                                        code = PreferenceHelper
                                            .getDataFromSharedPreference(
                                                key: 'code');
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.setPassword);
                                      }
                                    });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
