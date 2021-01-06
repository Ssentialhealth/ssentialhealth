import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_health/blocs/form_bloc.dart';

class FormProvider extends InheritedWidget {
  final bloc = FormBloc();

  FormProvider({Key key, Widget child}) : super
      (key: key, child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }


  static FormBloc of(BuildContext context) {
    return(context.inheritFromWidgetOfExactType(FormProvider) as
        FormProvider)
        .bloc;
  }


}