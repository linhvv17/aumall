import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../login/presentation/widgets/maintextformfield.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/update_password_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  final bool isDarkMode = false;
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

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
          S.current.settings,
          style: const TextStyle(color: ColorManager.dark),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Chế độ tối",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        late AppTheme currentTheme;
                        return IconButton(
                          onPressed: () {
                            if (state.themeData == appThemeData[AppTheme.lightTheme]) {
                              currentTheme = AppTheme.values[1];
                              ThemeDatabaseService.putThemeSettings(1);
                            } else {
                              currentTheme = AppTheme.values[0];
                              ThemeDatabaseService.putThemeSettings(0);
                            }

                            context
                                .read<ThemeBloc>()
                                .add(ThemeChanged(theme: currentTheme));
                          },
                          icon: state.themeData == appThemeData[AppTheme.lightTheme]
                              ? const Icon(Icons.sunny)
                              : const Icon(Icons.mode_night),
                        );
                      },
                    ),
                    // Transform.scale(
                    //   scale: 0.7,
                    //   child: CupertinoSwitch(
                    //     activeColor: Colors.deepOrangeAccent,
                    //     value: widget.isDarkMode,
                    //     onChanged: (bool value){
                    //
                    //     },
                    //   ),
                    // ),
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
