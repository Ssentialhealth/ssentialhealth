import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_event.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_state.dart';
import 'package:pocket_health/bloc/child_health/child_resource_detail/child_resource_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource_detail/child_resource_detail_event.dart';
import 'package:pocket_health/screens/child_health/resource/child_resource_detail_screen.dart';
import 'package:pocket_health/widgets/adult_unwell_menu_items.dart';

class ChildResourceData extends StatelessWidget {
  const ChildResourceData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildResourceBloc,ChildResourceState>(
      builder: (context,state){
        if(state is ChildResourceInitial){
          return Container(color: Colors.black,height: 300,);
        }
        if(state is ChildResourceLoaded){
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.childResourceModel.length,
                  itemBuilder: (BuildContext context,index){
                    final resource = state.childResourceModel[index];
                    return Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdultUnwellMenuItems(text: resource.name,
                            press: ()async{
                              BlocProvider.of<ChildResourceDetailsBloc>(context).add(FetchChildResourceDetails(id: resource.id));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChildResourceDetailScreen(title: resource.name,)));

                            },
                          )
                      ),
                    );
                  }
              ),
            ),
          );
        }
        if(state is ChildResourceError){
          return Container(color: Colors.blueGrey,height: 40,);
        }
        return Container(
            height: 50,
            child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
      },
    );
  }
}
