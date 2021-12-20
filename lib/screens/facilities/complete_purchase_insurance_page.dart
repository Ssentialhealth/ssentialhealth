import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/screens/doctor_consult/call/top_up_account.dart';
import 'package:pocket_health/screens/home/base.dart';
import 'package:pocket_health/utils/constants.dart';

class CompletePurchaseInsurancePage extends StatefulWidget {
  const CompletePurchaseInsurancePage({
    Key key,
  }) : super(key: key);

  @override
  _CompletePurchaseInsurancePageState createState() => _CompletePurchaseInsurancePageState();
}

class _CompletePurchaseInsurancePageState extends State<CompletePurchaseInsurancePage> {
  int amountToUse;
  int currentStep = 0;
  bool showBalance = false;

  @override
  void initState() {
    super.initState();
    context.read<CallBalanceCubit>()..getCallBalance(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Pay Premium",
          style: appBarStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocConsumer<CallBalanceCubit, CallBalanceState>(
                listener: (context, state) {},
                builder: (context, balanceState) {
                  if (balanceState is CallBalanceFetchSuccess) {
                    final int balanceInUSD = int.parse(balanceState.callBalanceModel.amount.split('.').first);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 1.sw,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h),

                              Text(
                                'Your Ssential Balance',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 15.h),

                              Text(
                                showBalance ? "**** USD" : '$balanceInUSD USD',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //show balance
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    showBalance = !showBalance;
                                  });
                                },
                                child: Text(
                                  showBalance ? "Hide Balance" : 'Show Balance',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: accentColorDark,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Enter amount quoted by agent',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 15.h),

                        //cost
                        SizedBox(
                          height: 40.h,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (val) {
                              val == null || val == ''
                                  ? setState(() {
                                      amountToUse = null;
                                    })
                                  : setState(() {
                                      amountToUse = int.parse(val);
                                    });

                              print('--------|amountToPay|--------|value -> ${amountToUse.toString()}');
                            },
                            onTap: () {},
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusColor: Colors.white,
                              contentPadding: EdgeInsets.all(10.0.w),
                              hintText: 'Enter amount quoted by agent in USD',
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

                        SizedBox(height: 15.h),

                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                elevation: 0.0,
                                child: Text(
                                  amountToUse == null
                                      ? "Pay Insurance"
                                      : (double.parse(balanceState.callBalanceModel.amount) >= amountToUse)
                                          ? 'Pay Insurance'
                                          : "Top Up Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                highlightElevation: 0.0,
                                focusElevation: 0.0,
                                disabledElevation: 0.0,
                                color: amountToUse == null ? Colors.grey[600] : Color(0xff1A5864),
                                height: 40.h,
                                highlightColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                onPressed: () async {
                                  if (amountToUse == null)
                                    null;
                                  else if (double.parse(balanceState.callBalanceModel.amount) >= amountToUse) {
                                    final newBalance = double.parse(balanceState.callBalanceModel.amount) - amountToUse;

                                    context.read<CallBalanceCubit>()
                                      ..creditDeductAdd(
                                          paymentType: 'LIPA_MPESA', currency: "KES", amount: newBalance.toInt(), user: 5, balance: newBalance.toInt());

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w)),
                                          child: Container(
                                            width: 1.sw,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 30.w),
                                                  height: 130.h,
                                                  child: Image(
                                                    image: AssetImage('assets/images/undraw_happy_announcement_ac67.png'),
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
                                                  child: Text(
                                                    "Success! Get in touch with an agent for more information",
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff6A6969),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 30.0.w),
                                                  child: TextButton(
                                                    child: Text(
                                                      'Back to Home',
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
                                                    onPressed: () {
                                                      Navigator.of(context).pushAndRemoveUntil(
                                                        MaterialPageRoute(builder: (c) => Base()),
                                                        (route) => false,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TopUpAccount(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
