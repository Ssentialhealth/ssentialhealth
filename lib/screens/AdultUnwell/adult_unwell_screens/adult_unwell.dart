import 'package:flutter/material.dart';
import 'package:pocket_health/models/adult_unwell_model.dart';
import 'package:pocket_health/screens/AdultUnwell/adult_unwell_list.dart';
import 'package:pocket_health/screens/AdultUnwell/organs/organs.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

class AdultUnwell extends StatefulWidget {
  @override
  _AdultUnwellState createState() => _AdultUnwellState();
}

class _AdultUnwellState extends State<AdultUnwell> {
 final List<String> symptoms = [
    "Runny Nose",
    "Nasal Irritation/Nose Irritation",

  ];
 final List<AdultUnwellModel> conditions = [];

  var items = List<String>();
  TextEditingController editingController =  TextEditingController();

  @override
  void initState() {
    items.addAll(symptoms);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(symptoms);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(symptoms);
      });
    }

  }

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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: editingController,
                      cursorColor: Colors.grey,
                      decoration: searchFieldInputDecoration("Search main symptom"),
                      onChanged: (value){
                        filterSearchResults(value);
                      },
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: ()async{
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Organs()));

                        },
                         child: Icon(Icons.menu,size: 32.0)
                       ),
                    ),
              ],
            ),
            Expanded(
              child: AdultUnwellCard()
            ),

          ],
        ),
      ),
    );
  }
}





































