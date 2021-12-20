import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'package:pocket_health/bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'package:pocket_health/bloc/saved_contacts/saved_contacts_cubit.dart';
import 'package:pocket_health/bloc/saved_insurance_contacts/saved_insurance_contacts_cubit.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/screens/doctor_consult/chat/channel_page.dart';
import 'package:pocket_health/screens/facilities/complete_purchase_insurance_page.dart';
import 'package:pocket_health/screens/health_insurance/insurance_profile_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PayInsurancesListPage extends StatefulWidget {
  const PayInsurancesListPage({
    Key key,
  }) : super(key: key);

  @override
  _PayInsurancesListPageState createState() => _PayInsurancesListPageState();
}

class _PayInsurancesListPageState extends State<PayInsurancesListPage> {
  String searchText = '';
  String searchFacilityText = '';

  @override
  void initState() {
    super.initState();
    context.read<FetchCallHistoryCubit>()..getCallHistory(5); //testing
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
        child: Column(children: [
          BlocBuilder<SavedInsuranceContactsCubit, SavedInsuranceContactsState>(
            builder: (context, savedState) {
              if (savedState is SavedInsuranceContactsSuccess) {
                return Consumer(
                  builder: (context, ScopedReader watch, child) {
                    final insurancesModelAsyncVal = watch(healthInsuranceModelProvider);

                    return insurancesModelAsyncVal.when(
                      data: (data) {
                        List<HealthInsuranceModel> insuranceDetailsSaved = [];
                        data.forEach((e) {
                          savedState.savedInsuranceContacts.forEach((element) {
                            if (e.id.toString() == element.replaceAll("insuranceIDTestThree", '')) {
                              return insuranceDetailsSaved.add(e);
                            }
                          });
                        });

                        final queriedInsurances = insuranceDetailsSaved?.where((element) => element.name?.toLowerCase()?.contains(searchText))?.toList();
                        return BlocConsumer<InitializeStreamChatCubit, InitializeStreamChatState>(
                          listener: (context, streamState) {
                            if (streamState is StreamChannelSuccess) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return StreamChat(
                                      streamChatThemeData: StreamChatThemeData(
                                        //input bar
                                        messageInputTheme: MessageInputTheme(
                                          sendAnimationDuration: Duration(milliseconds: 500),
                                        ),

                                        //messages styling
                                        ownMessageTheme: MessageTheme(
                                          messageBorderColor: accentColorDark,
                                          messageBackgroundColor: accentColorLight,
                                          messageText: TextStyle(
                                            color: Color(0xff373737),
                                          ),
                                        ),
                                        otherMessageTheme: MessageTheme(
                                          messageBorderColor: Color(0x19000000),
                                          messageBackgroundColor: Color(0xF000000),
                                          messageText: TextStyle(
                                            color: Color(0xff373737),
                                          ),
                                        ),

                                        //list styling
                                        channelPreviewTheme: ChannelPreviewTheme(
                                          unreadCounterColor: accentColorDark,
                                        ),

                                        //channel styling
                                        channelTheme: ChannelTheme(
                                          channelHeaderTheme: ChannelHeaderTheme(
                                            color: accentColor,
                                            subtitle: TextStyle(
                                              fontSize: 11.5.sp,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                      client: context.read<InitializeStreamChatCubit>().client,
                                      child: StreamChannel(
                                        channel: streamState.channel,
                                        child: ChannelPage(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }

                            if (streamState is StreamChannelError) {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Color(0xff163C4D),
                                    duration: Duration(milliseconds: 6000),
                                    content: Text(
                                      streamState.err,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                            }
                          },
                          builder: (context, streamState) {
                            if (streamState is StreamChannelLoading) {
                              return Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: CircularProgressIndicator(),
                                  width: 24,
                                  height: 24,
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10.h),

                                //search
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w, left: 10.w),
                                  child: SizedBox(
                                    height: 40.h,
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      onChanged: (val) async {
                                        setState(() {
                                          searchText = val.toLowerCase();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        fillColor: accentColorLight,
                                        filled: true,
                                        focusColor: accentColorLight,
                                        contentPadding: EdgeInsets.all(10.0.w),
                                        hintText: "Search for saved insurances to pay",
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                          borderSide: BorderSide(color: accentColorDark),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(100.0.w)),
                                          borderSide: BorderSide(color: accentColorDark),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                Divider(height: 0.5, color: Colors.black26),

                                //listview
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: searchText.isEmpty ? insuranceDetailsSaved.length : queriedInsurances.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    print('--------|docsnewlength|--------|value -> ${insuranceDetailsSaved.length.toString()}');
                                    final insuranceDetail = searchText.isEmpty
                                        ? insuranceDetailsSaved[index] ?? HealthInsuranceModel()
                                        : queriedInsurances[index] ?? HealthInsuranceModel();

                                    return ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => InsuranceProfilePage(
                                              insuranceModel: insuranceDetail,
                                            ),
                                          ),
                                        );
                                      },
                                      title: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            insuranceDetail.name == '' || insuranceDetail.name.isEmpty ? " Insurance" : insuranceDetail.name,
                                            style: TextStyle(
                                              color: Color(0xff515050),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                        ],
                                      ),
                                      leading: CircleAvatar(
                                        radius: 24.w,
                                        backgroundImage: AssetImage("assets/images/progile.jpeg"),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            color: Colors.blueAccent,
                                            size: 12.sp,
                                          ),
                                          Text(
                                            " Insurance",
                                            style: TextStyle(
                                              color: Color(0xff515050),
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: RawMaterialButton(
                                        elevation: 0.0,
                                        fillColor: accentColorDark,
                                        padding: EdgeInsets.zero,
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                          side: BorderSide(color: accentColorDark),
                                        ),
                                        child: Text(
                                          'Pay',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => CompletePurchaseInsurancePage()),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      loading: () => SizedBox.shrink(),
                      error: (err, stack) => SizedBox.shrink(),
                    );
                  },
                );
              }

              if (savedState is SavedContactsFailure) {
                return Container(
                  color: Colors.pink,
                  height: 100,
                  width: 1.sw,
                );
              }

              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
