import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/repository/forgotPasswordRepo.dart';
import 'package:pocket_health/screens/wait_screen.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'bloc/forgotPassword/forgotPasswordBloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final ForgotPasswordRepo forgotPasswordRepo = ForgotPasswordRepo(
      ApiService(
          http.Client(),
      ),
  );
  runApp(MyApp(
    forgotPasswordRepo: forgotPasswordRepo,
  ));
}

class MyApp extends StatelessWidget {
  final ForgotPasswordRepo forgotPasswordRepo;
  const MyApp({Key key, @required this.forgotPasswordRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ForgotPasswordBloc(forgotPasswordRepo: forgotPasswordRepo))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ssential App',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white
        ),

        home: WaitScreen(),

      ),
    );
  }

}




