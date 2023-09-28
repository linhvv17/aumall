import 'package:aumall/core/local/cecure_storage.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../bloc/login_bloc.dart';
import '../widgets/alert_snackbar.dart';
import '../widgets/mainbutton.dart';
import '../widgets/maintextformfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePass = true;

  String saveAccount = "false";

  @override
  void initState() {
    super.initState();
    loadAccountInfo();
  }

  void loadAccountInfo() async {
    emailController.text =
        await SecureStorage().storage.read(key: "username") ?? "";
    passController.text =
        await SecureStorage().storage.read(key: "password") ?? "";
    saveAccount =
        await SecureStorage().storage.read(key: "saveAccount") ?? "false";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: kHeight(context) * 0.1),
                  Row(
                    children: [
                      Text(
                        S.current.login,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.dark),
                      ),
                    ],
                  ),
                  SizedBox(height: kHeight(context) * 0.1),
                  MainTFF(
                      labelText: S.current.email,
                      hintText: S.current.email,
                      controller: emailController,
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
                      inputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 10,
                  ),
                  MainTFF(
                      max: 1,
                      labelText: S.current.password,
                      hintText: S.current.password,
                      controller: passController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.current.passwordEmpty;
                        } else {
                          if (value.length < 6) {
                            return S.current.passwordError;
                          }
                        }
                        return null;
                      },
                      isPassword: hidePass,
                      suffix: IconButton(
                        color: ColorManager.orangeLight,
                        icon: hidePass
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                      ),
                      borderRadius: 16,
                      inputType: TextInputType.text),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white, // color of tick Mark
                        activeColor: Colors.deepOrange,
                        value: saveAccount == "false" ? false : true,
                        onChanged: (bool? value) {
                          setState(() {
                            saveAccount = value.toString();
                          });
                        },
                      ),
                      Text(S.current.saveAccount)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.forgotPassword);
                          },
                          child: Text(S.current.forgetPassword))),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFinishedState && state.data.success!) {
                        showSnackbar(S.current.loginsuccess, context,
                            ColorManager.green);
                        PreferenceHelper.saveDataInSharedPreference(
                            key: "IsLoggedIn", value: true);
                        PreferenceHelper.saveDataInSharedPreference(
                                key: "token", value: state.data.token)
                            .then((value) => {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.layout)
                                });
                      } else if (state is LoginErrorState) {
                        showSnackbar(state.message, context, Colors.red);
                      } else if (state is LoginFinishedState) {
                        showSnackbar(state.data.message!, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      return state is LoginLoadingState
                          ? const CircularProgressIndicator()
                          : MainButton(
                              text: S.current.login.toUpperCase(),
                              height: 50,
                              ontab: () {
                                if (formKey.currentState!.validate()) {
                                  if (saveAccount == "true") {
                                    SecureStorage().storage.write(
                                        key: "username",
                                        value: emailController.text);
                                    SecureStorage().storage.write(
                                        key: "password",
                                        value: passController.text);
                                    SecureStorage().storage.write(
                                        key: "saveAccount",
                                        value: saveAccount.toString()
                                    );
                                    // PreferenceHelper.saveDataInSharedPreference(
                                    //     key: "saveAccount", value: saveAccount);

                                  }
                                  BlocProvider.of<LoginBloc>(context).add(
                                      UserLogin(emailController.text,
                                          passController.text));
                                }

                                // Navigator.pushReplacementNamed(
                                //     context, AppRoutes.layout);
                              });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.current.donthaveAccount,
                          style: Theme.of(context).textTheme.labelLarge),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        child: Text(S.current.register),
                      ),
                      Container(
                        width: 20,
                        height: 10,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/arrow.png"))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
