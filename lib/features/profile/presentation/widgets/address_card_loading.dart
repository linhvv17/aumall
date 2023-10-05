import 'package:aumall/app/widgets/skeleton.dart';
import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../bloc/profile_bloc.dart';

class AddressCardLoading extends StatelessWidget {
  const AddressCardLoading(
      {super.key});

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<OrderBloc>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 25,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(100, 30),
                    Skeleton(50, 30),
                  ],
                ),
                Skeleton(100, 30),
                Skeleton(200, 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Skeleton(30, 30),
                    Skeleton(200, 30),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class CheckboxCustom extends StatefulWidget {
  const CheckboxCustom({super.key});

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

class CheckboxCustom2 extends StatefulWidget {
  const CheckboxCustom2({super.key});

  @override
  State<CheckboxCustom2> createState() => _CheckboxCustom2State();
}

class _CheckboxCustom2State extends State<CheckboxCustom2> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
