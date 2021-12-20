import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/screens/wellness/resource_card.dart';
import 'package:pocket_health/utils/constants.dart';

class ListDocumentsPage extends StatelessWidget {
  const ListDocumentsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Insurance Documents",
          style: appBarStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ScopedReader watch, child) {
            final linksAsyncVal = watch(linksModelProvider);
            return linksAsyncVal.when(
              data: (data) {
                final links = data.where((e) => e.linkName.toLowerCase().contains("rate") || e.linkName.toLowerCase().contains("policy")).toList();
                if (links.length == 0)
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Documents not found. Please Try Again"),
                    ),
                  );
                return Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: links.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final link = links[index];
                      return ResourceCard(link: link);
                    },
                  ),
                );
              },
              loading: () {
                return Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              error: (err, stack) {
                return Text(
                  'An error occurred. Please try again.',
                  style: TextStyle(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
