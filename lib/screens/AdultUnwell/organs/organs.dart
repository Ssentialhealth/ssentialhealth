import 'package:flutter/material.dart';
import 'package:pocket_health/screens/AdultUnwell/organs/organs_list.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';
import 'package:pocket_health/widgets/widget.dart';

class Organs extends StatefulWidget {
  @override
  _OrgansState createState() => _OrgansState();
}

class _OrgansState extends State<Organs> {
  final   List<String> organs = [
    "Head, Eyes and the Nerves system",
    "Ear, Nose and Throat System",
    "Stomach and Digestive System",
    "Chest, Heart and Circulation system",
    "Urination and Reproductive systems",
    "Muscle, Bone and Connective system",
    "Skin, Hair and Mucous membranes",
    "Injuries, Trauma",
    "Drugs & Toxins Poisoning",
    "Infections",
    "Burn and Electrocution",
    "Mental,Behavioral and social conditions",
    "Tumors, malignancies",
    "Autoimmune and allergy conditions",
    "Metabolic and Hormone conditions",
    "Blood conditions",
    "Vascular (blood vessel) conditions ",
    "Congenital and genetic conditions ",
    "Degenerative conditions",
    "Parasites",
    "Others",

  ];
  var items = List<String>();
  TextEditingController editingController =  TextEditingController();

  @override
  void initState() {
    items.addAll(organs);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(organs);
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
        items.addAll(organs);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAFCF6),
      appBar: AppBar(
        title: Text("Main Affected System/Organ",style: TextStyle(fontSize: 18),),
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
                      decoration: searchFieldInputDecoration("Search main affected organ"),
                      onChanged: (value){
                        filterSearchResults(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: OrgansCard()
            ),

          ],
        ),
      ),
    );
  }
}
