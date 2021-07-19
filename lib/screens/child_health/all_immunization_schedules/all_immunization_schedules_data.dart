import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_bloc.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_state.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_event.dart';
import 'package:pocket_health/screens/child_health/edit_schedule_details/edit_schedule_details_screen.dart';

class AllImmunizationSchedulesData extends StatefulWidget {
  const AllImmunizationSchedulesData({Key key}) : super(key: key);

  @override
  _AllImmunizationSchedulesDataState createState() => _AllImmunizationSchedulesDataState();
}

class _AllImmunizationSchedulesDataState extends State<AllImmunizationSchedulesData> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSchedulesBloc, AllSchedulesState>(builder: (BuildContext context, state) {
      if (state is AllSchedulesInitial) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Text("Initial"),
              ),
            ),
          ],
        );
      }
      if (state is AllSchedulesLoaded) {
        return Column(
          children: [
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: state.allSchedulesModel.length,
                  itemBuilder: (BuildContext context, index) {
                    final allSchedules = state.allSchedulesModel[index];
                    var preDate = allSchedules.childDob.toString();
                    var dates = DateTime.parse(preDate);
                    var formattedDate = "${dates.year}-${dates.month}-${dates.day}";

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: GestureDetector(
                        onTap: () async {
                          BlocProvider.of<ScheduleDetailsBloc>(context).add(FetchScheduleDetails(allSchedules.id));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditScheduleDetailsScreen(id: allSchedules.id)));
                        },
                        child: Container(
                          color: Colors.white,
                          constraints: BoxConstraints(minHeight: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Align(alignment: Alignment.centerLeft, child: Text(allSchedules.childName)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Align(alignment: Alignment.centerLeft, child: Text(formattedDate)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      }
      if (state is AllSchedulesError) {
        return Container(
          color: Colors.blueGrey,
          height: 40,
        );
      }
      return Container(
          height: 50,
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          )));
    });
  }
}
