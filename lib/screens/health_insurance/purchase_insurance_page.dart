import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/screens/doctor_consult/call/top_up_account.dart';
import 'package:pocket_health/screens/health_insurance/view_policy_content.dart';
import 'package:pocket_health/screens/home/base.dart';
import 'package:pocket_health/utils/constants.dart';

class PurchaseInsurancePage extends StatefulWidget {
  final LinkModel policyLink;
  const PurchaseInsurancePage({
    Key key,
    this.policyLink,
  }) : super(key: key);

  @override
  _PurchaseInsurancePageState createState() => _PurchaseInsurancePageState();
}

class _PurchaseInsurancePageState extends State<PurchaseInsurancePage> {
  int amountToUse;
  int currentStep = 0;
  bool showBalance = false;
  bool hasSignature = false;

  final _sign = GlobalKey<SignatureState>();

  @override
  void initState() {
    super.initState();
    context.read<CallBalanceCubit>()..getCallBalance(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: accentColor,
        title: Text(
          'Purchase Insurance Process',
          style: appBarStyle,
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: Theme(
                data: ThemeData(canvasColor: Colors.white, primaryColor: Color(0xff163C4D)),
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: [
                    Step(
                      title: Text('Policy'),
                      isActive: currentStep == 0,
                      subtitle: Text(
                        "View Policy",
                        style: TextStyle(),
                      ),
                      content: Container(
                        height: 400.h,
                        child: ViewPolicyContent(pdf: widget.policyLink.resourceLink),
                      ),
                    ),
                    Step(
                      title: Text('Agreement'),
                      isActive: currentStep == 1,
                      subtitle: Text(
                        'Sign Agreement',
                        style: TextStyle(),
                      ),
                      content: Container(
                        height: 400.h,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: accentColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Signature(
                              color: accentColorDark,
                              strokeWidth: 3.0,
                              backgroundPainter: null,
                              onSign: () {
                                setState(() {
                                  hasSignature = true;
                                });
                              },
                              key: _sign,
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: accentColorDark,
                                ),
                                onPressed: () {
                                  final sign = _sign.currentState;
                                  sign.clear();
                                  setState(() {
                                    hasSignature = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      title: Text('Pay'),
                      isActive: currentStep == 2,
                      subtitle: Text(
                        'Pay Insurance',
                        style: TextStyle(),
                      ),
                      content: BlocConsumer<CallBalanceCubit, CallBalanceState>(
                        listener: (context, state) {},
                        builder: (context, balanceState) {
                          if (balanceState is CallBalanceFetchSuccess) {
                            final int balanceInUSD = int.parse(balanceState.callBalanceModel.amount.split('.').first);
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                      FilteringTextInputFormatter.deny('.'),
                                      FilteringTextInputFormatter.deny(','),
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
                    ),
                  ],
                  currentStep: currentStep,
                  onStepCancel: null,
                  onStepContinue: () {},
                  controlsBuilder: (
                    BuildContext context, {
                    VoidCallback onStepContinue,
                    VoidCallback onStepCancel,
                  }) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.0.h),
                      child: Row(
                        children: [
                          currentStep != 2
                              ? Expanded(
                                  child: TextButton(
                                    child: Text(
                                      currentStep == 0 ? 'Proceed to Sign' : 'Proceed to Pay',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: currentStep != 1
                                          ? MaterialStateProperty.all(Color(0xff1A5864))
                                          : hasSignature
                                              ? MaterialStateProperty.all(Color(0xff1A5864))
                                              : MaterialStateProperty.all(Colors.grey[600]),
                                      minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.w),
                                          side: BorderSide(
                                            color: Color(0xff1A5864),
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (currentStep == 0) {
                                        setState(() {
                                          currentStep++;
                                        });
                                      }
                                      if (currentStep == 1 && hasSignature) {
                                        setState(() {
                                          currentStep++;
                                        });
                                      } else if (currentStep == 1 && !hasSignature) {
                                        null;
                                      }
                                    },
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
