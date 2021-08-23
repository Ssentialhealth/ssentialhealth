import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/bloc/list_practitioners/list_practitioners_cubit.dart';
import 'package:pocket_health/screens/practitioners/practitioner_view_disclaimer.dart';
import 'package:pocket_health/screens/practitioners/practitioners_list_screen.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PractitionersCategoriesScreen extends StatefulWidget {
  @override
  _PractitionersCategoriesScreenState createState() => _PractitionersCategoriesScreenState();
}

class _PractitionersCategoriesScreenState extends State<PractitionersCategoriesScreen> {
  String _token;
  bool isAgreed = false;

  final List<String> practitionersCategories = [
    "Doctors",
    "Dentists",
    "Clinicians, Physician Assistants, Paramedics",
    'Pharmacists',
    "Nurses",
    "Psychologists, Counsellors",
    "Physiotherapists",
    'Occupational, Speech Therapists',
    'Nutritionists, Dieticians',
		"Chiropractors",
		"Others",
	];

	Future<String> getStringValuesSF() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		String stringValue = prefs.getString('token');
		return stringValue;
	}

	@override
	void initState() {
		super.initState();
		WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
			SharedPreferences prefs = await SharedPreferences.getInstance();
			bool testBool = prefs.getBool('isAgreed');
			testBool == null ? isAgreed = false : isAgreed = true;

			if (!isAgreed || isAgreed == null) {
				_token = await getStringValuesSF();

				if (_token != null)
					showDialog<void>(
						context: context,
						barrierDismissible: false,
						builder: (BuildContext dialogContext) {
							return PractitionerViewDisclaimer(
								disclaimerText:
								'This offers a platform to consult with doctors and other practitioners on healthrelated advice, complementing other health provision systems.',
							);
						},
					);
				else
					showDialog<void>(
						context: context,
						barrierDismissible: false,
						builder: (BuildContext dialogContext) {
							return PractitionerViewDisclaimer(
								disclaimerText: 'Please Log in or Sign up to see and consult available doctors & practitioners.',
							);
						},
					);
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				elevation: 0.0,
				title: Text(
					'Doctors & Practitioners',
					style: appBarStyle,
				),
				backgroundColor: Color(0xFF00FFFF),
			),
			body: SingleChildScrollView(
				child: Column(
					children: [
						//banner
						Stack(
							alignment: Alignment.topLeft,
							children: [
								Container(
									height: 110.h,
									width: 1.sw,
								),
								Positioned(
									left: -45.w,
									top: -47.h,
									child: Container(
										width: 460.w,
										height: 167.h,
										child: Image(
											fit: BoxFit.fitWidth,
											image: AssetImage('assets/images/practitioners_banner.png'),
										),
									),
								),
							],
						),

						//list of sub sections
						...List.generate(
							practitionersCategories.length,
									(index) => Column(
								children: [
									//tile
									ListTile(
										dense: true,
										isThreeLine: false,
										contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
										trailing: Icon(
											Icons.chevron_right,
											color: Color(0xff00FFFF),
										),
										title: Text(
											practitionersCategories[index],
											style: listTileTitleStyle,
										),
										onTap: () {
											final practitionersCategory = practitionersCategories[index];
                      context.read<ListPractitionersCubit>()..listPractitioners();
                      //push practitioner listing for each category
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PractitionersListScreen(
                              practitionersCategory: practitionersCategory,
                            );
                          },
                        ),
                      );
                    },
									),

									//divider
									Padding(
										padding: EdgeInsets.symmetric(horizontal: 15.w),
										child: Divider(
											height: 0,
											thickness: 0.0,
											color: Color(0xffC6C6C6),
										),
									),
								],
							),
						),
					],
				),
			),
		);
	}
}
