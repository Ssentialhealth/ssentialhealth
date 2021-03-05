import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesBloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesEvent.dart';
import 'package:pocket_health/screens/emergency_screens/hotline_widgets/sexual_reproduction_card.dart';
import 'package:pocket_health/widgets/widget.dart';

class SexualReproduction extends StatefulWidget {
  @override
  _SexualReproductionState createState() => _SexualReproductionState();
}

class _SexualReproductionState extends State<SexualReproduction> {
  String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE7FFFF),
        appBar: AppBar(
          title: Text("Sexual Reproduction"),
          backgroundColor: Color(0xFF00FFFF),
          centerTitle: true,
        ),
        body:Container(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 24),
                    child: DropdownButtonFormField(
                      decoration: countryFieldInputDecoration("Country"),
                      hint: code == null
                          ? Text('')
                          : Text(
                        code,
                        style: TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ['kenya','nigeria',].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            code = val;
                            BlocProvider.of<HotlinesBloc>(context).add(FetchHotline(country: code));
                          },
                        );
                      },
                    ),
                  ),
                  SexualReproductionCard()

                ],
              ),
            ],
          ),
        )
    );
  }
}
