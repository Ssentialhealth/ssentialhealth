import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:rave_flutter/rave_flutter.dart';

class GetCreditPage extends StatefulWidget {
  @override
  _GetCreditPageState createState() => _GetCreditPageState();
}

class _GetCreditPageState extends State<GetCreditPage> {
  var modeOfPaymentVal;

  var onChanged;

  var groupValue;

  List<String> modesOfPayment = [
    'M-Pesa',
    'Card',
    'PayPal',
  ];

  String selectedVal = 'M-Pesa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        elevation: 0.0,
        title: Text(
          'Top Up',
          style: appBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Top Up Ssential Credit',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'Call and consult doctors at affordable rates within Ssential',
              style: TextStyle(
                fontSize: 14.sp,
                color: textBlack,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Choose desired call duration in minutes (5 - 300 mins)',
              style: TextStyle(
                fontSize: 14.sp,
                color: textBlack,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 40.h,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: Colors.white,
                  contentPadding: EdgeInsets.all(10.0.w),
                  hintText: "Enter minutest between 5 - 500",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                    borderSide: BorderSide(color: Color(0xFF00FFFF)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
                    borderSide: BorderSide(color: Color(0xFF00FFFF)),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.h),

            //mode of payment
            Text(
              'Mode of Payment',
              style: TextStyle(
                fontSize: 12.sp,
                color: textBlack,
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(
                  modesOfPayment.length,
                  (index) => SizedBox(
                    width: 120,
                    child: RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: accentColorDark,
                      shape: StadiumBorder(),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: selectedVal == modesOfPayment[index]
                          ? Text(
                              modesOfPayment[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: accentColorDark,
                              ),
                            )
                          : Text(
                              modesOfPayment[index],
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black54,
                              ),
                            ),
                      value: modesOfPayment[index],
                      groupValue: selectedVal,
                      onChanged: (val) async {
                        setState(() {
                          selectedVal = val;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            Center(
              child: MaterialButton(
                minWidth: 374.w,
                elevation: 0.0,
                highlightElevation: 0.0,
                focusElevation: 0.0,
                disabledElevation: 0.0,
                color: Color(0xff1A5864),
                height: 40.h,
                highlightColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // bool checkPaymentIsSuccessful(final RaveResult response) {
                  //   return response.status == RaveStatus.success &&
                  //       response.rawResponse['currency'] == 'KES' &&
                  //       response.rawResponse['amount'] == '11' &&
                  //       response.rawResponse['txRef'] == 'txRe7fsss';
                  // }

                  // Get a reference to RavePayInitializer
                  RavePayInitializer initializer = RavePayInitializer(
                    amount: 1000.0,
                    country: "KE",
                    currency: "KES",
                    txRef: 'txRe7fsss',
                    email: "mwakicodes@gmail.com",
                    fName: "Lewis",
                    lName: "Mwaki",
                    acceptMpesaPayments: true,
                    acceptAccountPayments: false,
                    acceptCardPayments: true,
                    companyLogo: Container(color: Colors.red, height: 40, width: 30),
                    acceptAchPayments: false,
                    acceptGHMobileMoneyPayments: false,
                    acceptUgMobileMoneyPayments: false,
                    staging: false,
                    isPreAuth: true,
                    displayFee: false,
                    publicKey: 'FLWPUBK-01d949a9c04f029cc1f1a927af871079-X',
                    encryptionKey: '4c6325b0afa75beb8a0dc641',
                  );

                  // Initialize and get the transaction result
                  try {
                    RaveResult response = await RavePayManager().initialize(context: context, initializer: initializer);
                    print(response.status);
                    if (response == null) {
                      print("// user didn't complete the transaction. Payment wasn't successful.");
                    } else {
                      // final isSuccessful = checkPaymentIsSuccessful(response);
                      // if (isSuccessful) {
                      //   print("// provide value to customer");
                      // } else {
                      // check message
                      // print("message --------------- " + response.rawResponse['message']);
                      // print("authModel --------------- " + response.rawResponse['authModel']);

                      // check status
                      // print("status --------------- " + response.status.toString());

                      // check processor error
                      // print("processor --------------- " + response.rawResponse['processorResponse']);
                      // }
                    }
                  } catch (e) {
                    print('flutterwave error --------------- $e');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}