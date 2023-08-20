import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../bloc/products_bloc.dart';

class SortProduct extends StatefulWidget {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> sortBys;

  SortProduct({super.key, required this.sortBys});

  @override
  State<StatefulWidget> createState() => _SortProductState();
}

class _SortProductState extends State<SortProduct> {
  @override
  Widget build(BuildContext context) {
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
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setNewState) {
                        return Column(
                          children: [
                            Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                color: Colors.deepOrangeAccent,
                              ),
                              child: Center(
                                  child: Text(
                                S.current.sortBy.toUpperCase(),
                                style: const TextStyle(fontSize: 22),
                              )),
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount: widget.sortBys.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Card(
                                    key:
                                        ValueKey(widget.sortBys[index]['name']),
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),

                                    // The color depends on this is selected or not
                                    color:
                                        // widget.sortBys[index]
                                        //             ['isSelected'] ==
                                        //         true
                                        index == widget.selectedIndex
                                            ? Colors.amber
                                            : Colors.white,
                                    child: ListTile(
                                      onTap: () {
                                        print("AAAAAAAAAAAAAAAA");
                                        print(widget.sortBys[index]['key']);
                                        Navigator.pop(context);
                                        BlocProvider.of<ProductsBloc>(context)
                                            .add(GetProductsByType(
                                                widget.sortBys[index]['key']));
                                        // if this item isn't selected yet, "isSelected": false -> true
                                        // If this item already is selected: "isSelected": true -> false
                                        setNewState(() {
                                          // widget.sortBys[index]['isSelected'] =
                                          //     !widget.sortBys[index]
                                          //         ['isSelected'];
                                          widget.selectedIndex = index;
                                        });
                                      },
                                      title:
                                          Text(widget.sortBys[index]['name']),
                                    ));
                              },
                            )),
                          ],
                        );
                      });
                    });
              },
              icon: const Icon(Icons.tune))),
    );
  }
}
