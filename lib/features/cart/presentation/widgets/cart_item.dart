import 'package:aumall/features/cart/data/models/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/cart/data/models/cart_model.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../bloc/cart_bloc.dart';

class CartItem extends StatelessWidget {
  // final CartProduct item;
  final CartProductModel item;
  final int index;
  const CartItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: kWidth(context),
        height: kHeight(context) / 6,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[3]),
        child: Row(
          children: [
            SizedBox(
              width: kWidth(context) * 0.25,
              child: Image.network(
                item.productImage,
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: kWidth(context) * 0.5,
                          child: Text(
                            item.name,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ColorManager.dark,),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          "item.category",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.dark,)
                        )
                      ],
                    ),
                    BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is RemoveFromCart) {
                          showSnackbar(S.current.removeFromCart, context,
                              Colors.green);
                        }
                      },
                      child: IconButton(
                        onPressed: () async {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveFromCart(index));
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: ColorManager.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: kWidth(context) * .33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: kElevationToShadow[4]),
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.white,
                                  radius: 15.0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        //giam 1
                                            BlocProvider.of<CartBloc>(context).add(DecrementCount(item, index));
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        size: 20.0,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                  ),
                                )),
                            Text(
                              '${item.amount}',
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: ColorManager.dark,),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: kElevationToShadow[4]),
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.white,
                                  radius: 15.0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        //tang 1
                                        BlocProvider.of<CartBloc>(context).add(IncrementCount(item, index));
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 20.0,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Text(
                        'đ ${item.price}',
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
