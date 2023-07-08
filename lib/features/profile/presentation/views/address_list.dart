import 'package:aumall/features/profile/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/core/utilities/strings.dart';
import 'package:aumall/features/profile/presentation/widgets/order_card.dart';
import 'package:aumall/features/profile/presentation/widgets/order_cardpastOrders.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../payment/presentation/bloc/order_bloc.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({super.key});

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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 22),
        itemCount: 3,
        itemBuilder: (context, index) {
          return AddressCard(
            index: index,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AppRoutes.address);
          },
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrangeAccent,
        focusColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
