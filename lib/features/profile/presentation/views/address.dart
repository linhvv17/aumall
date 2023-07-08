import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/core/utilities/strings.dart';
import 'package:aumall/features/profile/presentation/widgets/order_card.dart';
import 'package:aumall/features/profile/presentation/widgets/order_cardpastOrders.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../../payment/presentation/bloc/order_bloc.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          S.current.myAddresses,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
              decoration: InputDecoration(
                  hintText: S.current.fullNameHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
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
              decoration: InputDecoration(
                  hintText: S.current.addressHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
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
              decoration: InputDecoration(
                  hintText: S.current.cityHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
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
              decoration: InputDecoration(
                  hintText: S.current.provinceHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),

            //Zip code
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Text(
                S.of(context).zipCode,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: S.current.zipCodeHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),

            //Country
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Text(
                S.of(context).country,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: S.current.countryHint,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: SizedBox(
                width: kWidth(context),
                height: kHeight(context) / 14,
                child: FloatingActionButton.extended(
                    heroTag: "add",
                    backgroundColor: ColorManager.orangeLight,
                    elevation: 8,
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    onPressed: () {

                    },
                    label: Text(
                      S.current.saveAddress.toUpperCase(),
                    )),
              ),
            ),

          ],
        ),
      )
    );
  }
}
