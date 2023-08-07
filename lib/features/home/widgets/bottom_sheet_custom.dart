import 'package:flutter/material.dart';
class BottomSheetCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomSheetCustomState();

}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  bool toggleIcon = true;
  toggleIconState(bool value ) {
    setState(() {
      toggleIcon = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Icon(
                  toggleIcon ? Icons.check_box : Icons.check_box_outline_blank
              ),
              ElevatedButton(onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: ( BuildContext context ) {
                      return StatefulBottomSheet(toggleIcon: toggleIcon, valueChanged: toggleIconState,);
                    }
                );
              } , child: Text('Show Bottom Sheet'))
            ],
          ),
        ),
      ),
    ) ;
  }
}

class StatefulBottomSheet extends StatefulWidget {
  final bool toggleIcon;
  final ValueChanged<bool> valueChanged;
  StatefulBottomSheet( {Key? key, required this.toggleIcon, required this.valueChanged } );

  @override
  _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
}

class _StatefulBottomSheetState extends State<StatefulBottomSheet> {
  late bool _toggleIcon;
  @override
  void initState() {
    _toggleIcon = widget.toggleIcon;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.blue,
      child: Column(
        children: [
          IconButton(onPressed:  () {
            setState(() {
              _toggleIcon= !_toggleIcon;
            });
            widget.valueChanged(_toggleIcon);
          } ,
              icon: Icon(
                  _toggleIcon ? Icons.check_box : Icons.check_box_outline_blank
              ) )
        ],
      ),
    );
  }
}