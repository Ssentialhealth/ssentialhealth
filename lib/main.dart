import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactBloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesBloc.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileBloc.dart';
import 'package:pocket_health/bloc/profile/userProfileBloc.dart';
import 'package:pocket_health/repository/emergencyContactRepo.dart';
import 'package:pocket_health/repository/forgotPasswordRepo.dart';
import 'package:pocket_health/repository/hotline_repo.dart';
import 'package:pocket_health/repository/loginRepo.dart';
import 'package:pocket_health/repository/practitionerProfileRepo.dart';
import 'package:pocket_health/repository/userProfile_repo.dart';
import 'package:pocket_health/screens/Authentication/Authenticate.dart';
import 'package:pocket_health/screens/emergency_screens/emergency_hotlines_screen.dart';
import 'package:pocket_health/screens/emergency_screens/hotlines_screen.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'bloc/forgotPassword/forgotPasswordBloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final LoginRepository loginRepository = LoginRepository(
    ApiService(
      http.Client(),
    ),
  );
  final UserProfileRepo userProfileRepo = UserProfileRepo(ApiService(http.Client()));
  final ForgotPasswordRepo forgotPasswordRepo = ForgotPasswordRepo(
      ApiService(
          http.Client(),
      ),
  );
  final PractitionerProfileRepo practitionerProfileRepo = PractitionerProfileRepo(ApiService(http.Client()),);
  final EmergencyContactRepo emergencyContactRepo = EmergencyContactRepo(ApiService(http.Client()),);
  final HotlineRepo hotlineRepo = HotlineRepo(ApiService(http.Client()),);

  runApp(MyApp(
    forgotPasswordRepo: forgotPasswordRepo,
    loginRepository: loginRepository,
    userProfileRepo:userProfileRepo,
    practitionerProfileRepo:practitionerProfileRepo,
    emergencyContactRepo:emergencyContactRepo,
    hotlinesRepo:hotlineRepo,
  ));
}

class MyApp extends StatelessWidget {
  final ForgotPasswordRepo forgotPasswordRepo;
  final LoginRepository loginRepository;
  final UserProfileRepo userProfileRepo;
  final PractitionerProfileRepo practitionerProfileRepo;
  final EmergencyContactRepo emergencyContactRepo;
  final HotlineRepo hotlinesRepo;
  const MyApp({Key key, @required this.forgotPasswordRepo,@required this.hotlinesRepo,@required this.loginRepository,@required this.emergencyContactRepo,@required this.userProfileRepo,@required this.practitionerProfileRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ForgotPasswordBloc(forgotPasswordRepo: forgotPasswordRepo)),
        BlocProvider(create: (context) => LoginBloc(loginRepository: loginRepository)),
        BlocProvider(create: (context) => UserProfileBloc(userProfileRepo: userProfileRepo)),
        BlocProvider(create: (context) => PractitionerProfileBloc(practitionerProfileRepo: practitionerProfileRepo)),
        BlocProvider(create: (context) => EmergencyContactBloc(emergencyContactRepo: emergencyContactRepo)),
        BlocProvider(create: (context) => HotlinesBloc(hotlinesRepo: hotlinesRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ssential App',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white
        ),

        home: HotlineScreen(),

      ),
    );
  }

}




