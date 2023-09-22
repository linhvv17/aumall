import 'package:aumall/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:aumall/features/profile/presentation/widgets/address_card.dart';
import 'package:flutter/cupertino.dart';
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

class AddressListView extends StatefulWidget {
  const AddressListView({super.key});

  @override
  State<StatefulWidget> createState() => _AddressListState();
}

class _AddressListState extends State<AddressListView> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProfileBloc>(context).add(GetListAddress());
  }

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
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is GetAddressListLoadedState) {
          return state.data.isEmpty
              ? const Center(child: Text("Bạn chưa có đia chỉ giao hàng nào!!"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return AddressCard(
                      index: index,
                      addressEntity: state.data[index],
                    );
                  },
                );
        }
        if (state is ProfileErrorState) {
          return Text(state.message);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: kHeight(context) / 3,
              ),
              // The loading indicator
              const CupertinoActivityIndicator(
                radius: 20.0,
                color: CupertinoColors.activeGreen,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(S.current.dataLoading)
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.address).then((value) =>
              {BlocProvider.of<ProfileBloc>(context).add(GetListAddress())});
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrangeAccent,
        focusColor: Colors.deepOrangeAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
