import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:pocket_health/screens/pregnancy_lactation/widgets/pregnancy_conditions_details.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PregnancyLactationDisclaimer extends StatelessWidget {
  final bool disclaimer;

  const PregnancyLactationDisclaimer({Key key, this.disclaimer}) : super(key: key);

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
                "This information is to aid in understanding pregnancy health and does not constitute medical advice.. Please consult doctor or seek care (facilities) if currently unwell. The content in this section refer to persons who are pregnant. If not pregnant, refer to Adult Unwell  or Unwell Child sections.",
                maxLines: 6,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textBlack,
                ),
              ),
            ),
            Row(
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
                        builder: (context) => PregnancyConditionsDetails(),
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
                    prefs.getBool("pregnancyIsAgreed") != true ? prefs.setBool('pregnancyIsAgreed', true) : null;
                    final test = prefs.getBool('pregnancyIsAgreed');
                    print('test' + test.toString());
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
