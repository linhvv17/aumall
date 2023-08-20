import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final int index;
  final AddressEntity addressEntity;
  const AddressCard(
      {super.key, required this.index, required this.addressEntity});

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addressEntity.name!,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 14,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFDB3022),
                          fontSize: 14,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  addressEntity.mobile!,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'Metropolis',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  addressEntity.address!,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'Metropolis',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addressEntity.defaultAddress!
                        ? const CheckboxCustom2()
                        : const CheckboxCustom(),
                    const Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 14,
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w400,
                      ),
                    )
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
