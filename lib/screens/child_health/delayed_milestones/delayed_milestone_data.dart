import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pocket_health/bloc/child_health/delayed_milestones/delayed_milestone_bloc.dart';
import 'package:pocket_health/bloc/child_health/delayed_milestones/delayed_milestone_state.dart';
import 'package:pocket_health/widgets/widget.dart';

class DelayedMilestoneData extends StatelessWidget {
  const DelayedMilestoneData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelayedMilestoneBloc,DelayedMilestoneState>(
        builder: (context,state){
          if(state is DelayedMilestoneInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is DelayedMilestoneLoaded){
            return Column(
              children: [
                Markdown(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    styleSheet: MarkdownStyleSheet(
                        h2: simpleTextStyle()
                    ),
                    data: state.delayedMilestoneModel.overview.overview
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.delayedMilestoneModel.overview.causes.length,
                  itemBuilder: (BuildContext context,index){
                    final delayedMilestone = state.delayedMilestoneModel.overview.causes[index];
                    return Container(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("• "+delayedMilestone)

                        )
                    );
                  }
                ),
                SizedBox(height: 12,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.delayedMilestoneModel.data.length,
                    itemBuilder: (BuildContext context,index){
                      final data = state.delayedMilestoneModel.data[index];
                      return Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(data.name,
                                        style:TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        )),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.possibleCauses.length,
                                      itemBuilder: (BuildContext context,index){
                                        final causes = data.possibleCauses[index];
                                        return Container(
                                            child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("• "+causes)

                                            )
                                        );
                                      }
                                  ),

                                ],
                              )

                          )
                      );
                    }
                ),


              ],
            );
          }
          if(state is DelayedMilestoneError){
            return Container(color: Colors.blueGrey,height: 40,);
          }
          return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }

    );
  }
}
