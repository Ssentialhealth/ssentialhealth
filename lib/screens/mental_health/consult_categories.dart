import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/list_facilities/list_facilities_cubit.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/screens/facilities/facilities_list_screen.dart';
import 'package:pocket_health/screens/practitioners/practitioners_list_screen.dart';
import 'package:pocket_health/utils/constants.dart';

class ConsultCategories extends StatelessWidget {
  const ConsultCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAFCF6),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Mental Health Specialists",
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: Column(
        children: [
          ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            trailing: Icon(
              Icons.chevron_right,
              color: Color(0xff00FFFF),
            ),
            title: Text(
              "Psychiatrists",
              style: listTileTitleStyle,
            ),
            onTap: () {
              //TODO: when data filter by speciality from backend

              context.read<ListPractitionersCubit>().filterPractitioners(
                    filterByDistance: "null",
                    practitionersCategory: "Psychologists, Counsellors",
                    filterByPrice: "null",
                    filterByAvailability: "null",
                    sortByNearest: "null",
                    sortByCheapest: "null",
                    sortByHighestRated: "null",
                    filterBySpeciality: "null",
                  );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PractitionersListScreen(
                    practitionersCategory: 'Doctors',
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.black26, height: 2),
          ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            trailing: Icon(
              Icons.chevron_right,
              color: Color(0xff00FFFF),
            ),
            title: Text(
              "Psychologists & Counsellors",
              style: listTileTitleStyle,
            ),
            onTap: () {
              context.read<ListPractitionersCubit>().filterPractitioners(
                    filterByDistance: "null",
                    practitionersCategory: "Psychologists, Counsellors",
                    filterByPrice: "null",
                    filterByAvailability: "null",
                    sortByNearest: "null",
                    sortByCheapest: "null",
                    sortByHighestRated: "null",
                    filterBySpeciality: "null",
                  );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PractitionersListScreen(
                    practitionersCategory: 'Psychologists, Counsellors',
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.black26, height: 2),
          ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            trailing: Icon(
              Icons.chevron_right,
              color: Color(0xff00FFFF),
            ),
            title: Text(
              "Mental Facilities",
              style: listTileTitleStyle,
            ),
            onTap: () {
              context.read<ListFacilitiesCubit>()..listFacilities("Mental Health");
              //push practitioner listing for each category
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FacilitiesListScreen(
                      facilitiesCategory: "Mental Health",
                    );
                  },
                ),
              );
            },
          ),
          Divider(color: Colors.black26, height: 2),
        ],
      ),
    );
  }
}
