import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/login/loginState.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:rave_flutter/rave_flutter.dart';

class TopUpAccount extends StatefulWidget {
  @override
  _TopUpAccountState createState() => _TopUpAccountState();
}

class _TopUpAccountState extends State<TopUpAccount> {
  String selectedVal = 'M-Pesa';
  int amountToPay;
  int minutesToBuy = 0;

  List<String> modesOfPayment = [
    'M-Pesa',
    'Card',
    'PayPal',
  ];

  @override
  void initState() {
    super.initState();
    context.read<CallBalanceCubit>()..getCallBalance(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
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
          listener: (context, balanceState) {},
          buildWhen: (prev, curr) => prev == curr ? false : true,
          builder: (context, balanceState) {
            if (balanceState is CallBalanceFetchSuccess) {
              final int balanceInUSD = int.parse(balanceState.callBalanceModel.amount.split('.').first);
              print('--------|balance-in-USD|--------|value -> ${balanceInUSD.toString()}');
              return Column(
                children: [
                  Text(
                    'Top Up Ssential Account',
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
                            'Your Ssential Balance',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$balanceInUSD USD',
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

                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny('.'),
                        FilteringTextInputFormatter.deny(','),
                      ],
                      onChanged: (val) {
                        val == null || val == ''
                            ? setState(() {
                                amountToPay = null;
                              })
                            : setState(() {
                                amountToPay = int.parse(val);
                              });

                        print('--------|amountToPay|--------|value -> ${amountToPay.toString()}');
                      },
                      onTap: () {},
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10.0.w),
                        hintText: 'Enter amount you wish to pay in USD',
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
                    'Select preferred mode of Payment',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: textBlack,
                    ),
                  ),

                  SizedBox(height: 10.h),

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
                            onPressed: amountToPay != null
                                ? selectedVal == 'M-Pesa' || selectedVal == 'Card'
                                    ? () async {
                                        // Get a reference to RavePayInitializer
                                        RavePayInitializer initializer = RavePayInitializer(
                                          amount: selectedVal == 'M-Pesa' ? amountToPay.toDouble() * 110.00 : amountToPay.toDouble(),
                                          country: "KE",
                                          currency: selectedVal == 'M-Pesa' ? "KES" : "USD",
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
                                          staging: false,
                                          isPreAuth: true,
                                          displayAmount: true,
                                          displayFee: true,
                                          publicKey: 'FLWPUBK-01d949a9c04f029cc1f1a927af871079-X',
                                          encryptionKey: '4c6325b0afa75beb8a0dc641',
                                        );

                                        // Initialize and get the transaction result
                                        try {
                                          RaveResult response = await RavePayManager().prompt(context: context, initializer: initializer);
                                          print(response.status);
                                          if (response == null) {
                                            print('--------|status|--------|value -> ${response.status.toString()}');
                                            print('--------|message|--------|value -> ${response.message.toString()}');
                                            if (response.rawResponse["message"] ==
                                                "Transaction Reference already exist. Try again in 2 minutes time to use the same ref for a new transaction") {
                                              ScaffoldMessenger.of(context).showSnackBar(
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
                                              );
                                            }
                                          } else {
                                            final txID = response.rawResponse['data']['id'];
                                            final verifyResponse = await http.get(
                                              'https://api.flutterwave.com/v3/transactions/$txID/verify',
                                              headers: {"Authorization": "Bearer " + "FLWSECK-4c6325b0afa7d07c4f285745e2884847-X"},
                                            );
                                            if (jsonDecode(verifyResponse.body)['message'] == "Transaction fetched successfully") {
                                              print("success");
                                              final paymentType = jsonDecode(verifyResponse.body)['data']['auth_model'];

                                              context.read<CallBalanceCubit>()
                                                ..creditDeductAdd(
                                                  paymentType: paymentType,
                                                  balance: (balanceInUSD ?? 0) + amountToPay,
                                                  amount: (balanceInUSD ?? 0) + amountToPay,
                                                  currency: "USD",
                                                  user: 5,
                                                );
                                            }
                                          }
                                        } catch (e) {
                                          print('--------|flutterwave error|--------|value -> ${e.toString()}');
                                        }
                                      }
                                    : selectedVal == 'PayPal'
                                        ? () async {
                                            final request = BraintreeDropInRequest(
                                              tokenizationKey: 'sandbox_ykgj6x4t_zjcjvpvw83bjxqkd',
                                              cardEnabled: false,
                                              paypalRequest: BraintreePayPalRequest(
                                                amount: amountToPay.toString(),
                                                currencyCode: 'USD',
                                                billingAgreementDescription: 'NULL',
                                                displayName: 'Ssential Health',
                                              ),
                                            );

                                            try {
                                              BraintreeDropInResult result = await BraintreeDropIn.start(request);
                                              if (result != null) {
                                                context.read<CallBalanceCubit>()
                                                  ..creditDeductAdd(
                                                    paymentType: 'PayPal',
                                                    balance: (balanceInUSD ?? 0) + amountToPay,
                                                    amount: (balanceInUSD ?? 0) + amountToPay,
                                                    currency: "USD",
                                                    user: 5,
                                                  );
                                                print('--------|devicedata|--------|value -> ${result.deviceData.toString()}');

                                                print('description: ${result.paymentMethodNonce.description} ');
                                                print('Nonce: ${result.paymentMethodNonce.nonce}');
                                              } else {
                                                print('Selection was canceled.');
                                              }
                                            } catch (_) {
                                              print('--------|drop-in-error|--------|value -> ${_.toString()}');
                                            }
                                          }
                                        : () {
                                            print('value');
                                          }
                                : () {
                                    print('EMPTY');
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
