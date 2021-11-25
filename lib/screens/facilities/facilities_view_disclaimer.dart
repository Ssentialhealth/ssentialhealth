import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/screens/home/base.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacilitiesViewDisclaimer extends StatelessWidget {
  final String disclaimerText;

  const FacilitiesViewDisclaimer({Key key, this.disclaimerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
              child: Text(
                disclaimerText,
                maxLines: 4,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textBlack,
                ),
              ),
            ),
            disclaimerText != 'Please Log in or Sign up to see and contact available hospitals, pharmacies and other health facilities.'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //cancel
                      Spacer(),
                      TextButton(
                        child: Text(
                          'BACK',
                          style: TextStyle(
                            color: accentColorDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w),
                          )),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Base(),
                            ),
                          );
                        },
                      ),

                      SizedBox(width: 8.w),
                      //post
                      TextButton(
                        child: Text(
                          'AGREE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: MaterialStateProperty.all(Color(0xff1A5864)),
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w),
                            side: BorderSide(
                              color: Color(0xff1A5864),
                              width: 1.w,
                            ),
                          )),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.getBool("isAgreed-facilities") != true ? prefs.setBool('isAgreed-facilities', true) : null;
                          final test = prefs.getBool('isAgreed-facilities');
                          print('test' + test.toString());
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      TextButton(
                        child: Text(
                          'BACK',
                          style: TextStyle(
                            color: accentColorDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.w)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w),
                          )),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Base(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
