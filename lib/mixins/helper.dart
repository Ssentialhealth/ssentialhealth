import 'package:flutter/material.dart';
import 'package:pocket_health/blocs/form_bloc.dart';

class Helper {
  static Widget errorMessage(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.errorMessage,
      builder: (context, snapshot){
        if(snapshot.hasData) {
          return Text(snapshot.data, style: TextStyle(color: Colors.red));
        }
        return Text('');
      },
    );
  }
}
