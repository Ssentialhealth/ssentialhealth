import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as materialStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SearchMessages extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                color: Color(0xff82899E),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
        ),
        primaryColor: Colors.black,
        primaryTextTheme: materialStyle.TextTheme(
          caption: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        hintColor: Colors.white24,
        textTheme: materialStyle.TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
        primaryColorBrightness: Brightness.dark,
      );

  @override
  Widget buildLeading(BuildContext context) {
    return Icon(
      Icons.search,
      color: Color(0xff646B80),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 10.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
              width: 15.0,
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  query = '';
                },
                icon: Icon(
                  Icons.cancel,
                  size: 20.0,
                  color: query.isEmpty ? Colors.black : Color(0xff646B80),
                ),
              ),
            ),
            SizedBox(width: 16.0.w),

            VerticalDivider(
              color: Color(0xff646B80),
              width: 1.0,
              indent: 7,
              endIndent: 7,
            ),

            SizedBox(width: 16.0.w),
            //see all
            MaterialButton(
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                close(context, null);
              },
              minWidth: 0.0.w,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              textColor: Color(0xff4878FF),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff4878FF),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 16.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Messages',
                        // style: titleText.copyWith(fontSize: 16.0.sp),
                      ),
                      //title
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {}
}
