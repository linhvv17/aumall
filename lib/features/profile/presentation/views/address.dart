import 'package:aumall/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../widgets/address_card.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<StatefulWidget> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final TextEditingController tfName = TextEditingController();
  final TextEditingController tfMobile = TextEditingController();
  final TextEditingController tfAddress = TextEditingController();
  final TextEditingController tfProvince = TextEditingController();
  final TextEditingController tfCity = TextEditingController();
  final TextEditingController tfDefault = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            S.current.myAddresses,
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: true,
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            // do stuff here based on BlocA's state
            if (state is AddAddressSuccessState) {
              showSnackbar("Thêm địa chỉ giao hàng thành công !!!!!", context,
                  Colors.red);
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      S.of(context).fullName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  TextField(
                    controller: tfName,
                    decoration: InputDecoration(
                        hintText: S.current.fullNameHint,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),

                  //Mobile
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      S.of(context).phone,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  TextField(
                    controller: tfMobile,
                    decoration: InputDecoration(
                        hintText: S.current.phone,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),

                  //Address
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      S.of(context).address,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  TextField(
                    controller: tfAddress,
                    decoration: InputDecoration(
                        hintText: S.current.addressHint,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),

                  //Province
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      S.of(context).province,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  TextField(
                    controller: tfProvince,
                    decoration: InputDecoration(
                        hintText: S.current.provinceHint,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),

                  //City
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      S.of(context).city,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  TextField(
                    controller: tfCity,
                    decoration: InputDecoration(
                        hintText: S.current.cityHint,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),

                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        checkColor: Colors.white,
                        fillColor:
                            MaterialStateProperty.all(Colors.deepOrangeAccent),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        'Đặt làm địa chỉ giao hàng mặc định',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 14,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: SizedBox(
                      width: kWidth(context),
                      height: kHeight(context) / 14,
                      child: FloatingActionButton.extended(
                          backgroundColor: ColorManager.orangeLight,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          onPressed: () {
                            BlocProvider.of<ProfileBloc>(context).add(AddAddress(
                              tfName.value.text,
                              tfMobile.value.text,
                              "${tfAddress.value.text} - ${tfProvince.value.text} - ${tfCity.value.text}",
                              isChecked,
                            ));
                          },
                          label: Text(
                            S.current.saveAddress.toUpperCase(),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
