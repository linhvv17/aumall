import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../bloc/products_bloc.dart';

class FilterProduct extends StatelessWidget {
  const FilterProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: ColorManager.grey,
                spreadRadius: 2,
              )
            ],
          ),
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext _) {
                      return SizedBox(
                        height: kHeight(context) / 2.3,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StatefulBuilder(builder: (_, setState) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.current.filter,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      S.current.price,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: ColorManager.grey,
                                          ),
                                    ),
                                    RangeSlider(
                                      activeColor: ColorManager.orangeLight,
                                      min: 0000000000,
                                      max: 5000000000,
                                      values: bloc.priceSelectRange,
                                      onChanged: (value) {
                                        setState(() {
                                          BlocProvider.of<ProductsBloc>(context)
                                              .priceSelectRange = value;
                                        });
                                      },
                                      divisions: 5,
                                      labels: RangeLabels(
                                        "${bloc.priceSelectRange.start.round().toString()}\$",
                                        "${bloc.priceSelectRange.end.round().toString()}\$",
                                      ),
                                    ),
                                    Text(
                                      S.current.rate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: ColorManager.grey,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: bloc.rateValue.round() * 50,
                                          child: const SizedBox(),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            '${S.current.productsAbove} ${(bloc.rateValue.round())} ${S.current.stars}',
                                            style: const TextStyle(
                                                color: ColorManager.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 100 - bloc.rateValue.round(),
                                          child: const SizedBox(),
                                        ),
                                      ],
                                    ),
                                    Slider(
                                      min: 0,
                                      max: 5,
                                      activeColor: ColorManager.orangeLight,
                                      value: bloc.rateValue,
                                      onChanged: (v) {
                                        setState(() {
                                          bloc.rateValue = v;
                                        });
                                      },
                                      divisions: 4,
                                    ),
                                    SizedBox(
                                      width: kWidth(context) / 2,
                                      child: BlocProvider.value(
                                        value: bloc,
                                        child: MainButton(
                                            text: S.current.apply,
                                            ontab: () {
                                              setState(() {
                                                bloc.add(GetProductsByFilter(
                                                    bloc.priceSelectRange.start
                                                        .round()
                                                        .toString(),
                                                    bloc.priceSelectRange.end
                                                        .round()
                                                        .toString(),
                                                    bloc.rateValue == 0
                                                        ? '-1'
                                                        : bloc.rateValue
                                                            .round()
                                                            .toString(),
                                                    bloc.currentCategoryId
                                                        .toString()));
                                              });
                                              Navigator.pop(context);
                                            },
                                            height: kHeight(context) / 15),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.filter_list_alt))),
    );
  }
}
