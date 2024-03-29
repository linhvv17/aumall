import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../bloc/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePass = true;
  bool checked = false;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: kHeight(context) * 0.05),
                  Row(
                    children: [
                      Text(
                        S.current.register,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.dark),
                      ),
                    ],
                  ),
                  SizedBox(height: kHeight(context) * 0.05),
                  MainTFF(
                      max: 1,
                      labelText: S.current.name,
                      hintText: S.current.name,
                      controller: nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.current.nameEmpty;
                        } else {
                          if (value.length < 3) {
                            return S.current.nameError;
                          }
                        }
                        return null;
                      },
                      isPassword: false,
                      borderRadius: 16,
                      inputType: TextInputType.text),
                  const SizedBox(
                    height: 10,
                  ),
                  MainTFF(
                      max: 1,
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
                  const SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterFinishedState) {
                        showSnackbar(S.current.registeruccess, context,
                            ColorManager.green);
                        PreferenceHelper.saveDataInSharedPreference(
                            key: "token", value: state.data.token);
                        PreferenceHelper.saveDataInSharedPreference(
                            key: "IsLoggedIn", value: true);
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.layout);
                      } else if (state is RegisterErrorState) {
                        showSnackbar(state.message, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      return state is RegisterLoadingState
                          ? const CircularProgressIndicator()
                          : MainButton(
                              text: S.current.registerText.toUpperCase(),
                              height: 50,
                              ontab: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                    UserRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                    ),
                                  );
                                }
                              });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.current.haveAccount,
                          style: Theme.of(context).textTheme.labelLarge),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text(S.current.login),
                      ),
                      Container(
                        width: 20,
                        height: 10,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/arrow.png"))),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
