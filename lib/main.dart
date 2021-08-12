import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/bloc/adult_unwell/adultUnwellBloc.dart';
import 'package:pocket_health/bloc/call_balance/call_balance_cubit.dart';
import 'package:pocket_health/bloc/call_history/call_history_cubit.dart';
import 'package:pocket_health/bloc/child_health/all_schedules/all_schedules_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_conditions_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource/child_resource_bloc.dart';
import 'package:pocket_health/bloc/child_health/child_resource_detail/child_resource_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_condition/congenital_condition_bloc.dart';
import 'package:pocket_health/bloc/child_health/congenital_detail/congenital_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/delayed_milestones/delayed_milestone_bloc.dart';
import 'package:pocket_health/bloc/child_health/details_bloc/child_condition_detail_bloc.dart';
import 'package:pocket_health/bloc/child_health/growth_charts/growth_chart_bloc.dart';
import 'package:pocket_health/bloc/child_health/immunization_schedule/immunization_schedule_bloc.dart';
import 'package:pocket_health/bloc/child_health/normal_development/normal_development_bloc.dart';
import 'package:pocket_health/bloc/child_health/nutrition_bloc/nutrition_bloc.dart';
import 'package:pocket_health/bloc/child_health/schedule_detail/schedule_detail_bloc.dart';
import 'package:pocket_health/bloc/emergency_contact/emergencyContactBloc.dart';
import 'package:pocket_health/bloc/hotlines/hotlinesBloc.dart';
import 'package:pocket_health/bloc/login/loginBloc.dart';
import 'package:pocket_health/bloc/organs/organsBloc.dart';
import 'package:pocket_health/bloc/practitioner_profile/practitionerProfileBloc.dart';
import 'package:pocket_health/bloc/profile/userProfileBloc.dart';
import 'package:pocket_health/bloc/reviews/reviews_cubit.dart';
import 'package:pocket_health/bloc/search_conditions/search_condition_bloc.dart';
import 'package:pocket_health/bloc/search_organ/search_organ_bloc.dart';
import 'package:pocket_health/bloc/symptoms/details/symptoms_bloc.dart';
import 'package:pocket_health/repository/adultUnwellRepo.dart';
import 'package:pocket_health/repository/all_schedules_repo.dart';
import 'package:pocket_health/repository/appointments_repo.dart';
import 'package:pocket_health/repository/booking_history_repo.dart';
import 'package:pocket_health/repository/call_balance_repo.dart';
import 'package:pocket_health/repository/call_history_repo.dart';
import 'package:pocket_health/repository/child_condition_detail_repo.dart';
import 'package:pocket_health/repository/child_conditions_repo.dart';
import 'package:pocket_health/repository/child_resource_repo.dart';
import 'package:pocket_health/repository/chilren_resource_detail_repo.dart';
import 'package:pocket_health/repository/conditionDetailRepo.dart';
import 'package:pocket_health/repository/congenital_conditions_repo.dart';
import 'package:pocket_health/repository/congenital_details_repo.dart';
import 'package:pocket_health/repository/delayed_milestones_repo.dart';
import 'package:pocket_health/repository/emergencyContactRepo.dart';
import 'package:pocket_health/repository/fetch_call_history_repo.dart';
import 'package:pocket_health/repository/forgotPasswordRepo.dart';
import 'package:pocket_health/repository/growth_charts_repo.dart';
import 'package:pocket_health/repository/hotline_repo.dart';
import 'package:pocket_health/repository/immunization_schedule_repo.dart';
import 'package:pocket_health/repository/loginRepo.dart';
import 'package:pocket_health/repository/normal_development_repo.dart';
import 'package:pocket_health/repository/nutrition_repo.dart';
import 'package:pocket_health/repository/organDetailsRepo.dart';
import 'package:pocket_health/repository/organsRepo.dart';
import 'package:pocket_health/repository/practitionerProfileRepo.dart';
import 'package:pocket_health/repository/reviews_repo.dart';
import 'package:pocket_health/repository/schedule_detail_repo.dart';
import 'package:pocket_health/repository/search_condition_repo.dart';
import 'package:pocket_health/repository/search_organs_repo.dart';
import 'package:pocket_health/repository/symptoms_repo.dart';
import 'package:pocket_health/repository/userProfile_repo.dart';
import 'package:pocket_health/screens/boarding/splash_screen.dart';
import 'package:pocket_health/services/api_service.dart';
import 'package:pocket_health/simple_bloc_observer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'bloc/appointments/appointments_cubit.dart';
import 'bloc/booking_history/booking_history_cubit.dart';
import 'bloc/conditionDetails/conditionDetailsBloc.dart';
import 'bloc/fetch_call_history/fetch_call_history_cubit.dart';
import 'bloc/filter_reviews/filter_reviews_cubit.dart';
import 'bloc/forgotPassword/forgotPasswordBloc.dart';
import 'bloc/initialize_stream_chat/initialize_stream_chat_cubit.dart';
import 'bloc/list_practitioners/list_practitioners_cubit.dart';
import 'bloc/organDetails/organDetailsBloc.dart';
import 'bloc/post_review/post_review_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Bloc.observer = SimpleBlocObserver();
  //
  // final client = StreamChatClient(
  //   '5ce52vsjkw26',
  //   logLevel: Level.OFF,
  // );

  // await client.connectUser(
  //   User(id: 'MochogeDavid'),
  //   client.devToken('MochogeDavid'),
  // );

  //repos
  final LoginRepository loginRepository = LoginRepository(ApiService(http.Client()));
  final UserProfileRepo userProfileRepo = UserProfileRepo(ApiService(http.Client()));
  final ForgotPasswordRepo forgotPasswordRepo = ForgotPasswordRepo(ApiService(http.Client()));
  final PractitionerProfileRepo practitionerProfileRepo = PractitionerProfileRepo(ApiService(http.Client()));
  final EmergencyContactRepo emergencyContactRepo = EmergencyContactRepo(ApiService(http.Client()));
  final HotlineRepo hotlineRepo = HotlineRepo(ApiService(http.Client()));
  final SearchConditionRepo searchConditionRepo = SearchConditionRepo(ApiService(http.Client()));
  final SearchOrganRepo searchOrganRepo = SearchOrganRepo(ApiService(http.Client()));
  final ConditionDetailsRepo conditionDetailsRepo = ConditionDetailsRepo(ApiService(http.Client()));
  final ChildConditionDetailRepo childConditionDetailRepo = ChildConditionDetailRepo(ApiService(http.Client()));
  final SymptomDetailsRepo symptomDetailsRepo = SymptomDetailsRepo(ApiService(http.Client()));
  final AdultUnwellRepo unwellRepo = AdultUnwellRepo(ApiService(http.Client()));
  final NutritionRepo nutritionRepo = NutritionRepo(ApiService(http.Client()));
  final ChildConditionsRepo childConditionRepo = ChildConditionsRepo(ApiService(http.Client()));
  final OrgansRepo organsRepo = OrgansRepo(ApiService(http.Client()));
  final OrganDetailsRepo organDetailsRepo = OrganDetailsRepo(ApiService(http.Client()));
  final NormalDevelopmentRepo normalDevelopmentRepo = NormalDevelopmentRepo(ApiService(http.Client()));
  final ChildResourceRepo childResourceRepo = ChildResourceRepo(ApiService(http.Client()));
  final ChildResourceDetailRepo childResourceDetailRepo = ChildResourceDetailRepo(ApiService(http.Client()));
  final CongenitalConditionsRepo congenitalConditionsRepo = CongenitalConditionsRepo(ApiService(http.Client()));
  final CongenitalConditionDetailRepo congenitalConditionDetailRepo = CongenitalConditionDetailRepo(ApiService(http.Client()));
  final GrowthChartsRepo growthChartsRepo = GrowthChartsRepo(ApiService(http.Client()));
  final DelayedMilestonesRepo delayedMilestonesRepo = DelayedMilestonesRepo(ApiService(http.Client()));
  final ImmunizationScheduleRepo immunizationScheduleRepo = ImmunizationScheduleRepo(ApiService(http.Client()));
  final AllScheduleRepo allScheduleRepo = AllScheduleRepo(ApiService(http.Client()));
  final ScheduleDetailRepo scheduleDetailRepo = ScheduleDetailRepo(ApiService(http.Client()));
  final ReviewsRepo reviewsRepo = ReviewsRepo(ApiService(http.Client()));
  final CallHistoryRepo callHistoryRepo = CallHistoryRepo(ApiService(http.Client()));
  final FetchCallHistoryRepo fetchCallHistoryRepo = FetchCallHistoryRepo(ApiService(http.Client()));
  final AppointmentsRepo appointmentsRepo = AppointmentsRepo(ApiService(http.Client()));
  final BookingHistoryRepo bookingHistoryRepo = BookingHistoryRepo(ApiService(http.Client()));
  final CallBalanceRepo callBalanceRepo = CallBalanceRepo(ApiService(http.Client()));
  runApp(MyApp(
    forgotPasswordRepo: forgotPasswordRepo,
    loginRepository: loginRepository,
    bookingHistoryRepo: bookingHistoryRepo,
    appointmentsRepo: appointmentsRepo,
    userProfileRepo: userProfileRepo,
    practitionerProfileRepo: practitionerProfileRepo,
    emergencyContactRepo: emergencyContactRepo,
    hotlinesRepo: hotlineRepo,
    searchConditionRepo: searchConditionRepo,
    adultUnwellRepo: unwellRepo,
    childConditionRepo: childConditionRepo,
    conditionDetailsRepo: conditionDetailsRepo,
    childConditionDetailRepo: childConditionDetailRepo,
    organsRepo: organsRepo,
    organDetailRepo: organDetailsRepo,
    searchOrganRepo: searchOrganRepo,
    symptomDetailsRepo: symptomDetailsRepo,
    nutritionRepo: nutritionRepo,
    normalDevelopmentRepo: normalDevelopmentRepo,
    childResourceRepo: childResourceRepo,
    childResourceDetailRepo: childResourceDetailRepo,
    congenitalConditionsRepo: congenitalConditionsRepo,
    congenitalConditionDetailRepo: congenitalConditionDetailRepo,
    growthChartsRepo: growthChartsRepo,
    delayedMilestonesRepo: delayedMilestonesRepo,
    immunizationScheduleRepo: immunizationScheduleRepo,
    allScheduleRepo: allScheduleRepo,
    scheduleDetailRepo: scheduleDetailRepo,
    reviewsRepo: reviewsRepo,
    callHistoryRepo: callHistoryRepo,
    fetchCallHistoryRepo: fetchCallHistoryRepo,
    callBalanceRepo: callBalanceRepo,
  ));
}

class MyApp extends StatelessWidget {
  final ForgotPasswordRepo forgotPasswordRepo;
  final LoginRepository loginRepository;
  final UserProfileRepo userProfileRepo;
  final PractitionerProfileRepo practitionerProfileRepo;
  final EmergencyContactRepo emergencyContactRepo;
  final HotlineRepo hotlinesRepo;
  final SearchConditionRepo searchConditionRepo;
  final ConditionDetailsRepo conditionDetailsRepo;
  final NutritionRepo nutritionRepo;
  final ChildConditionDetailRepo childConditionDetailRepo;
  final AdultUnwellRepo adultUnwellRepo;
  final ChildConditionsRepo childConditionRepo;
  final OrgansRepo organsRepo;
  final OrganDetailsRepo organDetailRepo;
  final SearchOrganRepo searchOrganRepo;
  final SymptomDetailsRepo symptomDetailsRepo;
  final NormalDevelopmentRepo normalDevelopmentRepo;
  final ChildResourceRepo childResourceRepo;
  final ChildResourceDetailRepo childResourceDetailRepo;
  final CongenitalConditionsRepo congenitalConditionsRepo;
  final CongenitalConditionDetailRepo congenitalConditionDetailRepo;
  final GrowthChartsRepo growthChartsRepo;
  final DelayedMilestonesRepo delayedMilestonesRepo;
  final ImmunizationScheduleRepo immunizationScheduleRepo;
  final AllScheduleRepo allScheduleRepo;
  final ScheduleDetailRepo scheduleDetailRepo;
  final ReviewsRepo reviewsRepo;
  final CallHistoryRepo callHistoryRepo;
  final FetchCallHistoryRepo fetchCallHistoryRepo;
  final AppointmentsRepo appointmentsRepo;
  final BookingHistoryRepo bookingHistoryRepo;
  final CallBalanceRepo callBalanceRepo;

  MyApp({
    Key key,
    @required this.forgotPasswordRepo,
    @required this.normalDevelopmentRepo,
    @required this.nutritionRepo,
    @required this.childConditionRepo,
    @required this.childConditionDetailRepo,
    @required this.searchOrganRepo,
    @required this.symptomDetailsRepo,
    @required this.searchConditionRepo,
    @required this.adultUnwellRepo,
    @required this.organsRepo,
    @required this.organDetailRepo,
    @required this.hotlinesRepo,
    @required this.loginRepository,
    @required this.emergencyContactRepo,
    @required this.userProfileRepo,
    @required this.conditionDetailsRepo,
    @required this.practitionerProfileRepo,
    @required this.childResourceRepo,
    @required this.childResourceDetailRepo,
    @required this.congenitalConditionDetailRepo,
    @required this.congenitalConditionsRepo,
    @required this.growthChartsRepo,
    @required this.delayedMilestonesRepo,
    @required this.immunizationScheduleRepo,
    @required this.allScheduleRepo,
    @required this.scheduleDetailRepo,
    @required this.reviewsRepo,
    @required this.callHistoryRepo,
    @required this.fetchCallHistoryRepo,
    @required this.appointmentsRepo,
    @required this.bookingHistoryRepo,
    @required this.callBalanceRepo,
  }) : super(key: key);

  final GlobalKey<NavigatorState> _navigator = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext mainContext) {
    return ScreenUtilInit(
      designSize: Size(414, 736),
      // allowFontScaling: false,
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ForgotPasswordBloc(forgotPasswordRepo: forgotPasswordRepo)),
          BlocProvider(create: (context) => LoginBloc(loginRepository: loginRepository)),
          BlocProvider(create: (context) => UserProfileBloc(userProfileRepo: userProfileRepo)),
          BlocProvider(create: (context) => PractitionerProfileBloc(practitionerProfileRepo: practitionerProfileRepo)),
          BlocProvider(create: (context) => EmergencyContactBloc(emergencyContactRepo: emergencyContactRepo)),
          BlocProvider(create: (context) => HotlinesBloc(hotlinesRepo: hotlinesRepo)),
          BlocProvider(create: (context) => SearchConditionBloc(searchConditionRepo: searchConditionRepo)),
          BlocProvider(create: (context) => ConditionDetailsBloc(conditionDetailsRepo: conditionDetailsRepo)),
          BlocProvider(create: (context) => AdultUnwellBloc(adultUnwellRepo: adultUnwellRepo)),
          BlocProvider(create: (context) => OrgansBloc(organsRepo: organsRepo)),
          BlocProvider(create: (context) => OrgansDetailsBloc(organDetailsRepo: organDetailRepo)),
          BlocProvider(create: (context) => SearchOrganBloc(searchOrganRepo: searchOrganRepo)),
          BlocProvider(create: (context) => ListPractitionersCubit(practitionerProfileRepo: practitionerProfileRepo)),
          BlocProvider(create: (context) => FilterReviewsCubit()..loadRecentlyRated()),
          BlocProvider(create: (context) => AdultUnwellBloc(adultUnwellRepo: adultUnwellRepo)),
          BlocProvider(create: (context) => ChildConditionBloc(childConditionsRepo: childConditionRepo)),
          BlocProvider(create: (context) => OrgansBloc(organsRepo: organsRepo)),
          BlocProvider(create: (context) => OrgansDetailsBloc(organDetailsRepo: organDetailRepo)),
          BlocProvider(create: (context) => SearchOrganBloc(searchOrganRepo: searchOrganRepo)),
          BlocProvider(create: (context) => SymptomDetailsBloc(symptomDetailsRepo: symptomDetailsRepo)),
          BlocProvider(create: (context) => ChildConditionDetailsBloc(childConditionDetailRepo: childConditionDetailRepo)),
          BlocProvider(create: (context) => NutritionBloc(nutritionRepo: nutritionRepo)),
          BlocProvider(create: (context) => NormalDevelopmentBloc(normalDevelopmentRepo: normalDevelopmentRepo)),
          BlocProvider(create: (context) => ChildResourceBloc(childResourceRepo: childResourceRepo)),
          BlocProvider(create: (context) => ChildResourceDetailsBloc(childResourceDetailRepo: childResourceDetailRepo)),
          BlocProvider(create: (context) => CongenitalConditionBloc(congenitalConditionsRepo: congenitalConditionsRepo)),
          BlocProvider(create: (context) => CongenitalConditionDetailsBloc(congenitalDetailDetailRepo: congenitalConditionDetailRepo)),
          BlocProvider(create: (context) => GrowthChartBloc(growthChartsRepo: growthChartsRepo)),
          BlocProvider(create: (context) => DelayedMilestoneBloc(delayedMilestonesRepo: delayedMilestonesRepo)),
          BlocProvider(create: (context) => ImmunizationScheduleBloc(immunizationScheduleRepo: immunizationScheduleRepo)),
          BlocProvider(create: (context) => AllSchedulesBloc(allSchedulesRepo: allScheduleRepo)),
          BlocProvider(create: (context) => ScheduleDetailsBloc(scheduleDetailRepo: scheduleDetailRepo)),
          BlocProvider(create: (context) => ReviewsCubit(reviewsRepo: reviewsRepo)),
          BlocProvider(create: (context) => PostReviewCubit(reviewsRepo)),
          BlocProvider(create: (context) => InitializeStreamChatCubit()),
          BlocProvider(create: (context) => CallHistoryCubit(callHistoryRepo)),
          BlocProvider(create: (context) => AppointmentsCubit(appointmentsRepo)),
          BlocProvider(create: (context) => BookingHistoryCubit(bookingHistoryRepo)),
          BlocProvider(create: (context) => FetchCallHistoryCubit(fetchCallHistoryRepo)),
          BlocProvider(create: (context) => CallBalanceCubit(callBalanceRepo)),
        ],
        child: MaterialApp(
          navigatorKey: _navigator,
          debugShowCheckedModeBanner: false,
          title: 'Ssential App',
          theme: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            accentColor: Color(0xff00FFFF),
          ),
          builder: (context, child) {
            return StreamChat(
              child: child,
              client: context.read<InitializeStreamChatCubit>().client,
            );
          },
          home: SplashScreen(),
        ),
      ),
    );
  }
}
