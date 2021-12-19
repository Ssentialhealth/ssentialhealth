import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/repository/insurance_agent_model.dart';
import 'package:pocket_health/screens/health_insurance/insurance_agent_profile_page.dart';
import 'package:pocket_health/utils/constants.dart';

class ListAgentsPage extends StatelessWidget {
  const ListAgentsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "View and Contact Agents",
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
            final agentsModelAsyncVal = watch(insuranceAgentModelProvider);
            return agentsModelAsyncVal.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final agent = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                          ),
                        );
                      },
                      child: Container(
                        height: 130.w,
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
                        child: Hero(
                          tag: "agent-profile-${agent.id}",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //avi / rating
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //avi
                                    CircleAvatar(
                                      radius: 32.w,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: agent.profileImgUrl == "" || agent.profileImgUrl == null
                                            ? SizedBox.shrink()
                                            : Image(
                                                image: NetworkImage(agent.profileImgUrl),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),

                                    SizedBox(height: 8.h),

                                    //rating
                                    Text(
                                      '4.6/5',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffF06E20),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 20.w),

                                //details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //name / verified / bookmark
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          //name
                                          Text(
                                            agent.name,
                                            style: TextStyle(
                                              fontSize: 17.sp,
                                              color: Color(0xff242424),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),

                                          Spacer(),

                                          //bookmark
                                          // BlocBuilder<SavedFacilityContactsCubit, SavedFacilityContactsState>(
                                          //   builder: (context, state) {
                                          //     if (state is SavedFacilityContactsSuccess) {
                                          //       final isSaved = state.savedFacilityContacts.contains("facilityIDTestThree" + '${facilityProfileModel.id.toString()}');
                                          //
                                          //       return GestureDetector(
                                          //         child: Icon(
                                          //           isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                          //           size: 20.w,
                                          //           color: isSaved ? Color(0xff0e0e0e) : Color(0xff242424),
                                          //         ),
                                          //         onTap: () async {
                                          //           setState(() {
                                          //             saveContactVal = !isSaved;
                                          //           });
                                          //           context.read<SavedFacilityContactsCubit>()
                                          //             ..addRemoveContacts(saveContactVal, "facilityIDTestThree" + "${facilityProfileModel.id.toString()}");
                                          //         },
                                          //       );
                                          //     }
                                          //     return Icon(
                                          //       Icons.bookmark_outline,
                                          //       size: 20.w,
                                          //       color: Color(0xff242424),
                                          //     );
                                          //   },
                                          // ),
                                        ],
                                      ),

                                      //location / get directions
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          //location
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 15.w,
                                                color: Color(0xff1A5864),
                                              ),
                                              SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  agent.location ?? "N/A",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Color(0xff242424),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Spacer(),
                                          //get directions
                                          Text(
                                            'Get Directions',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Color(0xff1A5864),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4.h),

                                      //view profile btn / book appointment btn
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RawMaterialButton(
                                              elevation: 0.0,
                                              fillColor: Colors.white,
                                              padding: EdgeInsets.zero,
                                              shape: ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.r),
                                                side: BorderSide(color: accentColorDark),
                                              ),
                                              child: Text(
                                                'View Profile',
                                                style: TextStyle(
                                                  color: Color(0xff1A5864),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => InsuranceAgentProfilePage(agentModel: agent),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              error: (err, stack) => Text(
                "err",
                style: TextStyle(),
              ),
            );
          },
        ),
      ),
    );
  }
}
