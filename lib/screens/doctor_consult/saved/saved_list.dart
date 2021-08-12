import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedList extends StatefulWidget {
  final docsList;

  const SavedList({Key key, this.docsList}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.docsList?.length,
            itemBuilder: (context, idx) {
              final doc = widget.docsList[idx];
              return ListTile(
                title: doc,
                leading: CircleAvatar(
                  radius: 24.w,
                  backgroundImage: AssetImage("assets/images/progile.jpeg"),
                ),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
