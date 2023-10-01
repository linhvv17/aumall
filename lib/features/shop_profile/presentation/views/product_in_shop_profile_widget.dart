import 'package:aumall/features/shop_profile/domain/entities/shop_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shopping/domain/entities/products_entity.dart';

class ProductInShopWidget extends StatefulWidget {
  final ShopProductEntity shopProductEntity;
  const ProductInShopWidget(
      {super.key, required this.shopProductEntity});

  @override
  State<StatefulWidget> createState() => _ProductInShopWidgetState();
}

class _ProductInShopWidgetState extends State<ProductInShopWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: BlocProvider.of<ThemeBloc>(context).themeData ==
                    appThemeData[AppTheme.lightTheme]
                ? ColorManager.white
                : Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                widget.shopProductEntity.thumbnailUrl!,
                width: kWidth(context)/2,
                height: kWidth(context)/3,
                fit: BoxFit.cover,
              ),
            ),
            Text(widget.shopProductEntity.title!),
            // Text(widget.shopProductEntity
            //     .description!),
            Text(
              Utils.convertPrice(
                  widget.shopProductEntity.price!),
              style: const TextStyle(
                  color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }


  void showDialogCanNotAuction(int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(type == 2 ? 'Phiên đấu giá chưa diễn ra'
            : 'Phiên đấu giá đã kết thúc'),
            content:
             Text(type == 2 ? 'Hãy quay lại khi phiên đấu giá bắt đầu'
                 : 'Rất tiếc. Hãy tham khảo sản phẩm khác của chúng tôi'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đã hiểu')),
            ],
          );
        });
  }
}
