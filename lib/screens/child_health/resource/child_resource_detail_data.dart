import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource_detail/child_resource_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource_detail/child_resource_detail_state.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailData extends StatelessWidget {
  const DetailData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildResourceDetailsBloc,ChildResourceDetailsState>(
        builder: (BuildContext context,state){
          if(state is ChildResourceDetailsInitial){
            return Container(color: Colors.black,height: 300,);
          }
          if(state is ChildResourceDetailsLoaded) {
            return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.childResourcesDetailModel.links.length,
                  itemBuilder: (BuildContext context,index){
                    final pdf = state.childResourcesDetailModel.links[index];
                    print(pdf);
                    return Container(
                        constraints: BoxConstraints(minHeight: 10.h),
                        child: SfPdfViewer.network(
                            pdf,
                            canShowScrollHead: false,
                            canShowScrollStatus: false)
                    );
            }
              )
            );
          }
          if(state is ChildResourceDetailsError){
            return Container(color: Colors.blueGrey,height: 40,);
          }
          return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,)));
        }
    );
  }
}
