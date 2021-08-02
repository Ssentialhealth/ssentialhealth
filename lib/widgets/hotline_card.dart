import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hotline extends StatelessWidget {
  const Hotline({
    Key key,
    @required this.name,
    @required this.location,
    @required this.phones,
    @required this.press,
  }) : super(key:key);
  final String name;
  final String location;
  final List<String> phones;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(name,style: TextStyle(fontSize: 14),)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.centerRight, child: Text(location)),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: phones.length,
                      itemBuilder: (context, index) {
                        final phone = phones[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            phone,
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        );
                      },
                    ),
                  ))),
        ],
      ),
    );
  }


}

































