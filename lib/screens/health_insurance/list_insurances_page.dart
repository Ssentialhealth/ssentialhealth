import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide BuildContextX;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_health/bloc/saved_insurance_contacts/saved_insurance_contacts_cubit.dart';
import 'package:pocket_health/models/health_insurance_model.dart';
import 'package:pocket_health/screens/health_insurance/filter_insurances_screen.dart';
import 'package:pocket_health/screens/health_insurance/insurance_profile_page.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListInsurancesPage extends StatefulWidget {
  const ListInsurancesPage({Key key}) : super(key: key);

  @override
  _ListInsurancesPageState createState() => _ListInsurancesPageState();
}

class _ListInsurancesPageState extends State<ListInsurancesPage> {
  String filterByName = "";

  bool saveContactVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Shop and Compare Health Insurances",
          style: appBarStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        onChanged: (val) async {
                          setState(() {
                            filterByName = val.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0.w),
                          hintText: "Search for Insurances",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
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
                  ),

                  SizedBox(width: 10),
                  //filter
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    focusElevation: 0.0,
                    disabledElevation: 0.0,
                    color: Color(0xff1A5864),
                    height: 40.h,
                    highlightColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.filterMenu,
                          color: Colors.white,
                          size: 20.r,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.containsKey('filterAgentsByPrice') ? prefs.remove('filterAgentsByPrice') : null;
                      prefs.containsKey('filterAgentsByDistance') ? prefs.remove('filterAgentsByDistance') : null;
                      prefs.containsKey('filterAgentsByCountry') ? prefs.remove('filterAgentsByCountry') : null;
                      prefs.containsKey('sortAgentsByCheapest') ? prefs.remove('sortAgentsByCheapest') : null;
                      prefs.containsKey('filterAgentsByAvailability') ? prefs.remove('filterAgentsByAvailability') : null;
                      prefs.containsKey('sortAgentsByNearest') ? prefs.remove('sortAgentsByNearest') : null;
                      prefs.containsKey('filterAgentsBySpeciality') ? prefs.remove('filterAgentsBySpeciality') : null;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return FilterInsurancesScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            //listview
            Consumer(
              builder: (context, ScopedReader watch, child) {
                final healthInsurancesAsyncVal = watch(healthInsuranceModelProvider);
                return healthInsurancesAsyncVal.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: filterByName != null
                          ? data.where((element) => (element.name.toLowerCase().contains(filterByName.toLowerCase()))).length
                          : data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final HealthInsuranceModel insurance = filterByName != null
                            ? data.where((element) => (element.name.toLowerCase().contains(filterByName.toLowerCase()))).toList()[index]
                            : data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InsuranceProfilePage(insuranceModel: insurance),
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
                              tag: "insurance-profile-${insurance.id}",
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
                                            child: insurance.profileImgUrl == "" || insurance.profileImgUrl == null
                                                ? SizedBox.shrink()
                                                : Image(
                                                    image: NetworkImage(insurance.profileImgUrl),
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
                                                insurance.name,
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  color: Color(0xff242424),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),

                                              Spacer(),

                                              // bookmark
                                              BlocBuilder<SavedInsuranceContactsCubit, SavedInsuranceContactsState>(
                                                builder: (context, state) {
                                                  if (state is SavedInsuranceContactsSuccess) {
                                                    final isSaved =
                                                        state.savedInsuranceContacts.contains("insuranceIDTestThree" + '${insurance.id.toString()}');

                                                    return GestureDetector(
                                                      child: Icon(
                                                        isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                                        size: 20.w,
                                                        color: isSaved ? Color(0xff0e0e0e) : Color(0xff242424),
                                                      ),
                                                      onTap: () async {
                                                        setState(() {
                                                          saveContactVal = !isSaved;
                                                        });
                                                        context.read<SavedInsuranceContactsCubit>()
                                                          ..addRemoveContacts(saveContactVal, "insuranceIDTestThree" + "${insurance.id.toString()}");
                                                      },
                                                    );
                                                  }
                                                  return Icon(
                                                    Icons.bookmark_outline,
                                                    size: 20.w,
                                                    color: Color(0xff242424),
                                                  );
                                                },
                                              ),
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
                                                      insurance.location ?? "N/A",
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
                                                        builder: (context) => InsuranceProfilePage(insuranceModel: insurance),
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
                    child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, stack) => Text(
                    'error',
                    style: TextStyle(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
