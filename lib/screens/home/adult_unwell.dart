import 'package:flutter/material.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

class AdultUnwell extends StatefulWidget {
  @override
  _AdultUnwellState createState() => _AdultUnwellState();
}

class _AdultUnwellState extends State<AdultUnwell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Most Notable Symptom/Sign",style: TextStyle(fontSize: 18),),
        backgroundColor: Color(0xFF00FFFF),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: searchFieldInputDecoration("Search main symptom"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()async{

                      },
                      child: Icon(Icons.menu,size: 32.0)
                    ),
                  ),

                ],
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Divider(height: 1,color: Color(0xFFC6C6C6),),
                    SizedBox(height: 5,),
                    AdultUnwellMenuItems(text:"Runny Nose",),
                    AdultUnwellMenuItems(text:"Nasal Irritation/Nose Irritation",),
                    AdultUnwellMenuItems(text:"Sore Throat/Swallowing pain",),
                    AdultUnwellMenuItems(text:"Cough",),
                    AdultUnwellMenuItems(text:"Fever",),
                    AdultUnwellMenuItems(text:"Headache",),
                    AdultUnwellMenuItems(text:"Chest Pain",),
                    AdultUnwellMenuItems(text:"Abdominal pain/Stomachache",),
                    AdultUnwellMenuItems(text:"High blood pressure/Hypertension",),
                    AdultUnwellMenuItems(text:"Loose Stools",),
                    AdultUnwellMenuItems(text:"Nausea or Vomiting",),
                    AdultUnwellMenuItems(text:"Abdominal swelling/distention",),
                    AdultUnwellMenuItems(text:"Constipation",),
                    AdultUnwellMenuItems(text:"Dizziness",),
                    AdultUnwellMenuItems(text:"Genital discharge or itchiness",),
                    AdultUnwellMenuItems(text:"Genital odour",),
                    AdultUnwellMenuItems(text:"Urination pain",),
                    AdultUnwellMenuItems(text:"Skin Rash/Skin Issues",),
                    AdultUnwellMenuItems(text:"Backache",),
                    AdultUnwellMenuItems(text:"Pain in limbs/joints or Limb swelling",),
                    AdultUnwellMenuItems(text:"Eye itchiness, redness, tears",),
                    AdultUnwellMenuItems(text:"Eye discharge",),
                    AdultUnwellMenuItems(text:"Yellowing of eyes",),
                    AdultUnwellMenuItems(text:"Ear pain or discharge ",),
                    AdultUnwellMenuItems(text:"Anxiety ",),
                    AdultUnwellMenuItems(text:"Sadness or Hopelessness ",),
                    AdultUnwellMenuItems(text:"Injury or Physical Trauma ",),
                    AdultUnwellMenuItems(text:"Burn or Electrocution ",),
                    AdultUnwellMenuItems(text:"Other ",),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
