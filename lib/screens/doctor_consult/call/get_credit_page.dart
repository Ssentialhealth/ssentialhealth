import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
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

  String minutesVal;

  TextEditingController minutesValController;

  bool showTransactionRefSnackbar = false;

  @override
  void initState() {
    super.initState();
    minutesValController = TextEditingController();
    context.read<CallBalanceCubit>()..getCallBalance(); //testing
  }

  @override
  Widget build(BuildContext context) {
    showTransactionRefSnackbar == true
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color(0xff163C4D),
              duration: Duration(milliseconds: 6000),
              content: Text(
                'Please try again in 2 minutes time!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: accentColor,
        elevation: 0.0,
        title: Text(
          'Top Up',
          style: appBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: BlocConsumer<CallBalanceCubit, CallBalanceState>(
          listener: (context, balanceState) {
            if (balanceState is CallBalanceAddSuccess) {
              context.read<CallBalanceCubit>()..getCallBalance();
            }
          },
          builder: (context, balanceState) {
            if (balanceState is CallBalanceFetchSuccess) {
              final balance = int.parse(balanceState.callBalanceModel.amount.split(".").first);
              return Column(
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
                  SizedBox(height: 20.h),

                  Container(
                    height: 144.w,
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
                    margin: EdgeInsets.only(bottom: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xC000000),
                          blurRadius: 4.w,
                          spreadRadius: 2.w,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Ssential Credit Balance',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$balance minutes',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

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
                      keyboardType: TextInputType.number,
                      controller: minutesValController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10.0.w),
                        hintText: "Enter minutes between 5 - 500",
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

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                        modesOfPayment.length,
                        (index) => SizedBox(
                          width: 120.w,
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

                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, loginState) {
                      if (loginState is LoginLoaded) {
                        print("-------------loginState.loginModel.user.userID");
                        print(loginState.loginModel.user.userID);
                        return Center(
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
                            onPressed: minutesValController.text == null
                                ? () {}
                                : () async {
                                    // Get a reference to RavePayInitializer
                                    RavePayInitializer initializer = RavePayInitializer(
                                      amount: double.parse(minutesValController.text),
                                      country: "KE",
                                      currency: "KES",
                                      email: "",
                                      txRef: "txRefTesting-${loginState.loginModel.user.email}",
                                      narration: 'For Ssential Health Credit',
                                      displayEmail: true,
                                      companyName: Text(
                                        'For Ssential Health Credit',
                                        style: TextStyle(
                                          color: accentColorDark,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      fName: loginState.loginModel.user.fullNames.split(" ").first,
                                      lName: loginState.loginModel.user.fullNames.split(" ").last,
                                      acceptMpesaPayments: selectedVal == "M-Pesa",
                                      acceptAccountPayments: false,
                                      acceptCardPayments: selectedVal == "Card",
                                      companyLogo: Image(
                                        image: AssetImage('assets/images/logonotag.png'),
                                        fit: BoxFit.fitWidth,
                                      ),
                                      acceptAchPayments: false,
                                      acceptGHMobileMoneyPayments: false,
                                      acceptUgMobileMoneyPayments: false,
                                      staging: true,
                                      isPreAuth: true,
                                      displayFee: true,
                                      publicKey: 'FLWPUBK_TEST-76c1705a4f7b2be0d3580eafaff28777-X',
                                      encryptionKey: 'FLWSECK_TEST968077f1f1c8',
                                    );

                                    // Initialize and get the transaction result
                                    try {
                                      RaveResult response = await RavePayManager().prompt(context: context, initializer: initializer);
                                      print(response.status);
                                      if (response == null) {
                                        print("user didn't complete the transaction. Payment wasn't successful.");

                                        print("-------------error section------------------");

                                        print(response.status);
                                        print(response.message);
                                        print("user didn't complete the transaction. Payment wasn't successful.");
                                        if (response.rawResponse["message"] ==
                                            "Transaction Reference already exist. Try again in 2 minutes time to use the same ref for a new transaction") {
                                          setState(() {
                                            showTransactionRefSnackbar = true;
                                          });
                                        }
                                      } else {
                                        final txID = response.rawResponse['data']['id'];
                                        final verifyResponse = await http.get(
                                          'https://api.flutterwave.com/v3/transactions/$txID/verify',
                                          headers: {"Authorization": "Bearer " + "FLWSECK_TEST-682e6172c96b33ce8d9e1eeeb8ae6a32-X"},
                                        );
                                        if (jsonDecode(verifyResponse.body)['message'] == "Transaction fetched successfully") {
                                          final paymentType = jsonDecode(verifyResponse.body)['data']['auth_model'];
                                          print("success");
                                          context.read<CallBalanceCubit>()
                                            ..creditDeductAdd(
                                              paymentType: paymentType,
                                              balance: (balance ?? 0) + int.parse(minutesValController.text),
                                              amount: (balance ?? 0) + int.parse(minutesValController.text),
                                              currency: "KES",
                                              user: 5,
                                            );
                                        }
                                      }
                                    } catch (e) {
                                      print("-------------error section------------------");
                                      print('flutterwave error --------------- $e');
                                    }
                                  },
                          ),
                        );
                      }

                      return Container();
                    },
                  )
                ],
              );
            }

            if (balanceState is CallBalanceLoading) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50.h, width: 1.sw),
                  SizedBox(
                    height: 24.w,
                    width: 24.w,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 50.h),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
