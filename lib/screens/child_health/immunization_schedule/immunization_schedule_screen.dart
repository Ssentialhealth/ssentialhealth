import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pocket_health/widgets/widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ImmunizationChartScreen extends StatefulWidget {
  const ImmunizationChartScreen({Key key}) : super(key: key);

  @override
  _ImmunizationChartScreenState createState() => _ImmunizationChartScreenState();
}

class _ImmunizationChartScreenState extends State<ImmunizationChartScreen> {

  String dateOfBirth;
  TextEditingController dob = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Immunization Schedule",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: searchFieldInputDecoration("Search by week/month"),
                      onChanged: (value){
                        setState(() {
                          // textValue = value;
                          // BlocProvider.of<SearchConditionBloc>(context).add(FetchSearchCondition(condition: textValue));
                        });
                      },
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 12,),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10.0),
                child: Container(
                  constraints: BoxConstraints(minHeight: 10.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Child Name"
                        )
                    ),
                      SizedBox(height: 5.h,),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: textFieldInputDecoration("Child Name"),
                      ),
                      SizedBox(height: 12.h,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Date of Birth"
                          )
                      ),
                      SizedBox(height: 5.h,),
                      TextFormField(
                        readOnly: true,
                        decoration: dateFieldInputDecoration(dateOfBirth),
                        controller: dob,
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1963, 3, 5),
                              maxTime: DateTime(2021, 6, 7),
                              onChanged: (date) {
                                // print('change $date');
                              }, onConfirm: (date) {
                                // print('confirm $date');
                                setState(() {
                                  var dob = date.toString();
                                  var dates = DateTime.parse(dob);
                                  var formattedDate = "${dates.day}-${dates.month}-${dates.year}";

                                  dateOfBirth = formattedDate;

                                  print(formattedDate);
                                });
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                      ),
                      SizedBox(height: 12.h,),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff163C4D),
                                    const Color(0xff32687F)
                                  ]
                              )
                          ),
                          child: Text("Generate Schedule",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                      ),
                      SizedBox(height: 12.h,),
                      Text("This Schedule of recommended immunizations may vary depending on the country you selected in your profile.",style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center,),
                      SizedBox(height: 12.h,),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
