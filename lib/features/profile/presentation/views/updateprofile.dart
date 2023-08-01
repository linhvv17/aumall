import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';

class UpdateProfileView extends StatefulWidget {
  final UserEntity user;
  const UpdateProfileView({super.key, required this.user});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    emailController.text = widget.user.email;
    nameController.text = widget.user.name;
    super.initState();
  }

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
            S.current.personalinfo,
              style: const TextStyle(fontWeight: FontWeight.bold, color: ColorManager.dark)
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: kHeight(context) * 0.1),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      // if (state is UploadImageState) {
                      //   return Stack(children: [
                      //     SizedBox(
                      //       width: kWidth(context) * .25,
                      //       height: kHeight(context) * .14,
                      //     ),
                      //     CircleAvatar(
                      //       radius: 50,
                      //       backgroundImage: NetworkImage(state
                      //                   .xFileToUpload.path ==
                      //               null
                      //           ? 'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'
                      //           : state
                      //           .xFileToUpload.path!),
                      //     ),
                      //     Positioned(
                      //       left: 2,
                      //       bottom: 6,
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             boxShadow: kElevationToShadow[6]),
                      //         child: CircleAvatar(
                      //           backgroundColor: ColorManager.white,
                      //           radius: 15.0,
                      //           child: InkWell(
                      //             onTap: () {
                      //               print("AAAAAAAAAAA");
                      //               BlocProvider.of<ProfileBloc>(context)
                      //                   .add(UploadImage());
                      //             },
                      //             child: const Icon(
                      //               Icons.camera_alt,
                      //               size: 20.0,
                      //               color: ColorManager.grey,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ]);
                      // } else
                        if (state is UploadImagesLoadingState ||
                          state is UpdateProfileLoadingState) {
                        return const CircleAvatar(
                          radius: 50,
                          backgroundColor: ColorManager.grey,
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProfileLoadedState) {
                        return Stack(children: [
                          SizedBox(
                            width: kWidth(context) * .25,
                            height: kHeight(context) * .14,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(state
                                        .data.user!.avatar ==
                                    null
                                ? 'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'
                                : state.data.user!.avatar.toString()),
                          ),
                          Positioned(
                            left: 2,
                            bottom: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: kElevationToShadow[6]),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 15.0,
                                child: InkWell(
                                  onTap: () {
                                    print("AAAAAAAAAAA");
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(UploadImage());
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                    color: ColorManager.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]);
                      } else
                  if (state is PickedImageState) {
                        return Stack(children: [
                          SizedBox(
                            width: kWidth(context) * .25,
                            height: kHeight(context) * .14,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(File(state.xFileToUpload.path)),
                          ),
                          Positioned(
                            left: 2,
                            bottom: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: kElevationToShadow[6]),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 15.0,
                                child: InkWell(
                                  onTap: () {
                                    print("AAAAAAAAAAA");
                                    print("AAAAAAAAAAA ${state.xFileToUpload.path}");

                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(UploadImage());
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                    color: ColorManager.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]);
                      } else {
                        return Stack(children: [
                          SizedBox(
                            width: kWidth(context) * .25,
                            height: kHeight(context) * .14,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(widget.user.avatar ==
                                    null
                                ? 'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'
                                : widget.user.avatar.toString()),
                          ),
                          Positioned(
                            left: 2,
                            bottom: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: kElevationToShadow[6]),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 15.0,
                                child: InkWell(
                                  onTap: () {
                                    print("AAAAAAAAAAA");
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(UploadImage());
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                    color: ColorManager.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  //name
                  MainTFF(
                    labelText: S.current.name,
                    hintText: widget.user.name,
                    controller: nameController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.nameEmpty;
                      }

                      return null;
                    },
                    borderRadius: 16,
                    inputType: TextInputType.text,
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //email
                  MainTFF(
                      labelText: S.current.email,
                      hintText: widget.user.email,
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
                  //mobile
                  MainTFF(
                    labelText: S.current.phone,
                    hintText: widget.user.phone,
                    controller: mobileController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.nameEmpty;
                      }

                      return null;
                    },
                    borderRadius: 16,
                    inputType: TextInputType.text,
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //date of birth
                  MainTFF(
                      labelText: S.current.dateOfBirth,
                      hintText: widget.user.dateOfBirth,
                      controller: dateOfBirthController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return S.current.emptyEmail;
                        } else {
                          // if (!value.contains('@')) {
                          //   return S.current.invalidEmail;
                          // }
                        }
                        return null;
                      },
                      isPassword: false,
                      borderRadius: 16,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 10,
                  ),
                  //address
                  MainTFF(
                    labelText: S.current.address,
                    hintText: widget.user.address,
                    controller: addressController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return S.current.nameEmpty;
                      }

                      return null;
                    },
                    borderRadius: 16,
                    inputType: TextInputType.text,
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileUpdateState && state.data.status == '200') {
                        showSnackbar(S.current.updateproflesuccess, context,
                            ColorManager.green);
                      } else if (state is UpdateProfileErrorState) {
                        showSnackbar(state.message, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      return state is PickedImageState
                          ? MainButton(
                              text: S.current.updateprofile.toUpperCase(),
                              height: 50,
                              ontab: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      UpdataProfileEvent(
                                          nameController.text,
                                          File(state.xFileToUpload.path),
                                        nameController.text,
                                        mobileController.text,
                                        dateOfBirthController.text,
                                        addressController.text,
                                      ));
                                }
                              })
                      :const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
