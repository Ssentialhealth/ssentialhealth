import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_patch/json_patch.dart';
import 'package:pocket_health/models/ForgotPassword.dart';
import 'package:pocket_health/models/all_schedules_model.dart';
import 'package:pocket_health/models/appoinment_model.dart';
import 'package:pocket_health/models/call_balance_model.dart';
import 'package:pocket_health/models/call_history_model.dart';
import 'package:pocket_health/models/child_chronic_condition_model.dart';
import 'package:pocket_health/models/child_chronic_detail_model.dart';
import 'package:pocket_health/models/child_condition_detail_model.dart';
import 'package:pocket_health/models/child_conditions_model.dart';
import 'package:pocket_health/models/child_resource_detail_model.dart';
import 'package:pocket_health/models/children_resources_model.dart';
import 'package:pocket_health/models/conditionDetailsModel.dart';
import 'package:pocket_health/models/delayed_milestone_model.dart';
import 'package:pocket_health/models/emergency_contact.dart';
import 'package:pocket_health/models/facility_call_history_model.dart';
import 'package:pocket_health/models/facility_open_hours_model.dart';
import 'package:pocket_health/models/facility_profile_model.dart';
import 'package:pocket_health/models/facility_review_model.dart';
import 'package:pocket_health/models/growth_chart_model.dart';
import 'package:pocket_health/models/hotlines.dart';
import 'package:pocket_health/models/immunization_schedule_model.dart' hide Vaccine;
import 'package:pocket_health/models/loginModel.dart';
import 'package:pocket_health/models/normal_development_Model.dart';
import 'package:pocket_health/models/nutrition_model.dart';
import 'package:pocket_health/models/organDetailsModel.dart';
import 'package:pocket_health/models/organsModel.dart';
import 'package:pocket_health/models/organs_search_model.dart';
import 'package:pocket_health/models/practitioner_profile_model.dart';
import 'package:pocket_health/models/profile.dart';
import 'package:pocket_health/models/review_model.dart';
import 'package:pocket_health/models/search_condition_model.dart';
import 'package:pocket_health/models/symptom_model.dart';
import 'package:pocket_health/models/symptoms_detail_model.dart';
import 'package:pocket_health/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final http.Client httpClient;
  String _token;
  BuildContext buildContext;

  ApiService(this.httpClient) : assert(httpClient != null);

  //Emergency Endpoint Hotlines Fetch
  Future<Hotlines> fetchHotlines(String country) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/emergency/hotlines?country=$country");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Hotlines');
    }

    print(response.body);
    final hotlinesJson = response.body;
    return hotlinesFromJson(hotlinesJson);
  }

  //Search Conditions
  Future<List<SearchCondition>> fetchSearchedCondition(String condition) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/symptoms/?overview=$condition");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Hotlines');
    }

    print(response.body);
    return searchConditionFromJson(response.body);
  }

  //Search Organs
  Future<List<SearchOrgan>> fetchSearchedOrgan(String organ) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/organs/?name=$organ");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Hotlines');
    }

    print(response.body);
    return searchOrganFromJson(response.body);
  }

  //All Condition Endpoint Fetch
  Future<List<SymptomModel>> fetchConditions() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/symptoms");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Conditions');
    }

    print(response.body);

    return symptomModelFromJson(response.body);
  }

  Future<List<NutritionModel>> fetchNutrition() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/nutrition/");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Nutrition');
    }

    print(response.body);

    return nutritionModelFromJson(response.body);
  }

  Future<NormalDevelopmentModel> fetchNormalDevelopment() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/normal_development/");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Nutrition');
    }

    print(response.body);

    return normalDevelopmentModelFromJson(response.body);
  }

  //All Child Conditions Fetch
  Future<List<ChildConditionsModel>> fetchChildConditions() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/child_unwell");
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    print(response.body);

    return childConditionsModelFromJson(response.body);
  }

  //Children Resources
  Future<List<ChildResourceModel>> fetchChildResource() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/children_resources/");
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    print(response.body);

    return childResourceModelFromJson(response.body);
  }

  //Children Resource Details
  Future<ChildResourceDetailModel> fetchResourceDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/children_resources/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Symptom Detail');
    }
    print(response.body);
    return childResourceDetailModelFromJson(response.body);
  }

  //Child Chronic Condition
  Future<List<CongenitalConditionsModel>> fetchCongenitalConditions() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/congenital_conditions/");
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    print(response.body);

    return congenitalConditionsModelFromJson(response.body);
  }

  //Growth Chart Fetch
  Future<GrowthChartModel> fetchGrowthCharts() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/growth_charts/");
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    print(response.body);

    return growthChartModelFromJson(response.body);
  }

  //
  Future<DelayedMilestoneModel> fetchDelayedMilestones() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/delayed_milestones/");
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    print(response.body);

    return delayedMilestoneModelFromJson(response.body);
  }

  //Child Chronic condition Detail
  Future<CongenitalDetailModel> fetchCongenitalDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/child_health/congenital_conditions/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Symptom Detail');
    }
    print(response.body);
    return congenitalDetailModelFromJson(response.body);
  }

  //Symptoms Endpoint Details Fetch by ID
  Future<SymptomDetail> fetchSymptomsDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/symptoms/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Symptom Detail');
    }
    print(response.body);
    return symptomDetailFromJson(response.body);
  }

  //Symptoms Endpoint Details Fetch by ID
  Future<ConditionDetails> fetchConditionDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/adult_unwell/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Condition Details');
    }
    print(response.body);
    return conditionDetailsFromJson(response.body);
  }

  //Child Conditions detail
  Future<ChildConditionsDetailModel> fetchChildConditionDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/child_unwell/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Condition Details');
    }
    print(response.body);
    return childConditionsDetailModelFromJson(response.body);
  }

  //All Organs Endpoint
  Future<List<OrgansModel>> fetchAllOrgans() async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/organs/");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Organs');
    }

    print(response.body);

    return organsModelFromJson(response.body);
  }

  //Specific Organ Details Fetch Endpoint
  Future<OrganDetailsModel> fetchOrganDetails(int id) async {
    final response = await this.httpClient.get("https://ssential.herokuapp.com/api/conditions/organs/$id");
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Condition Details');
    }
    print(response.body);
    return organDetailsModelFromJson(response.body);
  }

  //Immunization Schedule Creating
  Future<ImmunizationScheduleModel> createSchedule(String childName, String childDob) async {
    Map<String, dynamic> schedule = Map();
    schedule['child_name'] = childName;
    schedule['child_dob'] = childDob;

    _token = await getStringValuesSF();

    final response = await httpClient.post(Uri.encodeFull(immunizationEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token}, body: jsonEncode(schedule));

    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Error Creating Schedule');
    }
    final createSchedule = jsonDecode(response.body);
    return ImmunizationScheduleModel.fromJson(createSchedule);
  }

  //UPDATE SCHEDULE

  Future<void> updateReceived({
    Vaccine vaccine,
    bool hasReceivedChanged,
    bool initialReceivedVal,
    bool newReceivedVal,
    String newReceivedDate,
    String initialReceivedDate,
  }) async {
    //if initial date is null & dateReceived is not null pass dateReceived
    //if inital date is null & dateReceieved is null pass null
    //if initital date is not null & date receievd is null pass initalDate
    // if initital date is not null & date received i
    // s not null pass dateReceived
    final newestReceivedDate = initialReceivedDate == null && newReceivedDate == null
        ? null
        : initialReceivedDate == null && newReceivedDate != null
            ? newReceivedDate
            : initialReceivedDate != null && newReceivedDate == null
                ? initialReceivedDate
                : initialReceivedDate != null && newReceivedDate != null
                    ? newReceivedDate
                    : 'what?';

    //if inital val is false & receivedVal is true pass true
    //if inital val is false & receivedVal is false pass false
    //if initial val is true & receivedval is false pass false
    //if initial val is true & receoveval is true pass true
    //if receivedHasChanged is true pass receivedVal
    //else if inital is true

    final newestRecievedVal = hasReceivedChanged == true ? newReceivedVal : initialReceivedVal;
    _token = await getStringValuesSF();
    final vaccineToPatch = vaccine.toJson();
    final patchedJson = JsonPatch.apply(
      vaccineToPatch,
      [
        {
          "op": "replace",
          "path": "/received",
          "value": newestRecievedVal,
        },
        {
          "op": "replace",
          "path": "/date_received",
          "value": newestReceivedDate,
        }
      ],
      strict: true,
    );
    final payload = json.encode(patchedJson);
    print('vaccine after applying patch operations: $payload');
    final response = await httpClient.patch(
      vaccinesEndpoint + vaccine.id.toString(),
      body: payload,
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );
    log('vaccine update response  | ' + '${response.body}');
  }

  //Fetching all Schedules
  Future<List<AllScheduleModel>> fetchAllSchedule() async {
    _token = await getStringValuesSF();

    final response = await this.httpClient.get(
      Uri.encodeFull(immunizationEndpoint),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );
    print(_token);
    print("alL schedules" + response.body);
    if (response.statusCode != 200) {
      throw Exception("Error Fetching condition");
    }
    return allScheduleModelFromJson(response.body);
  }

  //Schedule detail
  Future<AllScheduleModel> fetchEachSchedule(int id) async {
    _token = await getStringValuesSF();

    final response = await this.httpClient.get(
      Uri.encodeFull("https://ssential.herokuapp.com/api/child_health/immunization_schedule/"),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching Schedule Details');
    }
    print(response.body);
    final schedule = allScheduleModelFromJson(response.body).where((element) => element.id == id).toList()[0];
    return schedule;
  }

  //User Emergency Contacts Endpoints Fetch
  Future<EmergencyContact> addContacts(
      String ambulanceName, countryCode, ambulancePhone, insurerName, insuranceNumber, insurerNumber, emergenceName, emergencyRelation, emergencyNumber) async {
    Map<String, dynamic> mainLoad = Map();

    Map<String, dynamic> emergency = Map();
    emergency['name'] = emergenceName;
    emergency['phone_number'] = emergencyNumber;
    emergency['relationship'] = emergencyRelation;

    Map<String, dynamic> healthI = Map();
    healthI['name'] = insurerName;
    healthI['insurance_number'] = insuranceNumber;
    healthI['contacts'] = [insurerNumber];

    Map<String, dynamic> ambulance = Map();
    ambulance['name'] = ambulanceName;
    ambulance['contacts'] = [ambulancePhone];

    mainLoad['emergency_contacts'] = [emergency];
    mainLoad['health_insurers'] = [healthI];
    mainLoad['ambulance_services'] = [ambulance];

    _token = await getStringValuesSF();
    final response = await httpClient.post(Uri.encodeFull(addContactsEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token}, body: jsonEncode(mainLoad));
    print(response.body);
    print(_token);
    print(mainLoad);

    if (response.statusCode != 200) {
      throw Exception('error creating profile');
    }
    final createProfileJson = jsonDecode(response.body);
    return EmergencyContact.fromJson(createProfileJson);
  }

  //Health Practitioner Profile Creation Endpoint
  Future<PractitionerProfileModel> createPractitioner(String surname, location, region, phone, healthInstitution, careType, practitioner, speciality,
      affiliatedInstitution, operationTime, onlinePrice, personalPrice, followPrice, onlinePriceB, onlinePriceC, personalBPrice, followBPrice) async {
    Map<String, dynamic> healthInfo = Map();
    healthInfo['health_institution'] = healthInstitution;
    healthInfo['care_type'] = careType;
    healthInfo['practitioner'] = practitioner;
    healthInfo['speciality'] = speciality;
    healthInfo['affiliated_institution'] = affiliatedInstitution;

    Map<String, dynamic> onlineBook = Map();
    onlineBook['upto_15_mins'] = onlinePrice;
    onlineBook['upto_30_mins'] = onlinePriceB;
    onlineBook['upto_1_hour'] = onlinePriceC;

    Map<String, dynamic> inPersonBook = Map();
    inPersonBook['per_visit'] = personalPrice;
    inPersonBook['per_hour'] = personalBPrice;

    Map<String, dynamic> followUpBook = Map();
    followUpBook['per_visit'] = followPrice;
    followUpBook['per_hour'] = followBPrice;

    Map<String, dynamic> ratesInfo = Map();
    ratesInfo['online_booking'] = onlineBook;
    ratesInfo['in_person_booking'] = inPersonBook;
    ratesInfo['follow_up_visit'] = followUpBook;

    Map<String, dynamic> _payLoad = Map();
    _payLoad['surname'] = surname;
    _payLoad['phone_number'] = operationTime + phone;
    _payLoad['location'] = location;
    _payLoad['region'] = region;
    _payLoad['health_info'] = healthInfo;
    _payLoad['rates_info'] = ratesInfo;
    _token = await getStringValuesSF();
    final response = await httpClient.post(Uri.encodeFull(createPractitionerProfileEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token}, body: jsonEncode(_payLoad));
    print(response.body);
    print(_token);
    print(_payLoad);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final createProfileJson = jsonDecode(response.body);
    return PractitionerProfileModel.fromJson(createProfileJson);
  }

  //fetch practitioners by category
  Future<List<PractitionerProfileModel>> fetchPractitioners() async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/user/practitioner_profiles/",
      headers: {
        "Authorization": "Bearer " + _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching practitioners');
    }

    print(response.body);
    // return practitionerProfileFromJson(response.body).where((element) => element.healthInfo != null && element.healthInfo.practitioner == practitionersCategory).toList();
    return practitionerProfileListModelFromJson(response.body).where((element) => element.healthInfo != null).toList();
  }

  //fetch practitioners by filters
  Future<List<PractitionerProfileModel>> fetchFilteredPractitioners({
    @required String filterByDistance,
    @required String filterByPrice,
    @required String sortByNearest,
    @required String filterByAvailability,
    @required String sortByHighestRated,
    @required String sortByCheapest,
    @required String filterBySpeciality,
    @required String practitionersCategory,
  }) async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/user/practitioner_profiles/",
      headers: {
        "Authorization": "Bearer " + _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching practitioners');
    }
    final whereNotNull = practitionerProfileListModelFromJson(response.body);
    // .where(
    //   (element) => (element.user != null &&
    //       element.region != null &&
    //       element.location != null &&
    //       element.healthInfo != null &&
    //       element.ratesInfo != null &&
    //       element.surname != null),
    // )
    // .toList();

    final filtered = practitionersCategory == 'Doctors'
        ? (filterByPrice != 'null' && filterByDistance != 'null' && filterBySpeciality != 'null' && filterByAvailability != 'null')
            //if doctors filtered by all filters
            ? whereNotNull
                .where((element) =>
                    (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                    (30.0 <= double.parse(filterByDistance)) &&
                    (element.healthInfo.speciality == filterBySpeciality) &&
                    (element.available.toString() == filterByAvailability))
                .toList()
            // if doctors not filtered by price
            : (practitionersCategory == 'Doctors') &&
                    (filterByPrice == 'null' && filterByDistance != 'null' && filterBySpeciality != 'null' && filterByAvailability != 'null')
                ? whereNotNull
                    .where((element) =>
                        (30.0 <= double.parse(filterByDistance)) &&
                        (element.healthInfo.speciality == filterBySpeciality) &&
                        (element.available.toString() == filterByAvailability))
                    .toList()
                // if doctors not filtered by distance or price
                : (practitionersCategory == 'Doctors') &&
                        (filterByPrice == 'null' && filterByDistance == 'null' && filterBySpeciality != 'null' && filterByAvailability != 'null')
                    ? whereNotNull
                        .where((element) => (element.healthInfo.speciality == filterBySpeciality) && (element.available.toString() == filterByAvailability))
                        .toList()
                    // if doctors not filtered by distance
                    : (practitionersCategory == 'Doctors') &&
                            (filterByPrice != 'null' && filterByDistance == 'null' && filterBySpeciality != 'null' && filterByAvailability != 'null')
                        ? whereNotNull
                            .where((element) =>
                                (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                                (element.healthInfo.speciality == filterBySpeciality) &&
                                (element.available.toString() == filterByAvailability))
                            .toList()
                        // if doctors not filtered by distance or availability
                        : (practitionersCategory == 'Doctors') &&
                                (filterByPrice != 'null' && filterByDistance == 'null' && filterBySpeciality != 'null' && filterByAvailability == 'null')
                            ? whereNotNull
                                .where((element) =>
                                    (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                                    (element.healthInfo.speciality == filterBySpeciality))
                                .toList()
                            // if doctors not filtered by price or availability
                            : (practitionersCategory == 'Doctors') &&
                                    (filterByPrice == 'null' && filterByDistance != 'null' && filterBySpeciality != 'null' && filterByAvailability == 'null')
                                ? whereNotNull
                                    .where((element) => (30.0 <= double.parse(filterByDistance)) && (element.healthInfo.speciality == filterBySpeciality))
                                    .toList() // if doctors not filtered availability
                                : (practitionersCategory == 'Doctors') &&
                                        (filterByPrice != 'null' &&
                                            filterByDistance != 'null' &&
                                            filterBySpeciality != 'null' &&
                                            filterByAvailability == 'null')
                                    ? whereNotNull
                                        .where((element) =>
                                            (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                                            (element.healthInfo.speciality == filterBySpeciality))
                                        .toList()
                                    : (practitionersCategory == 'Doctors') &&
                                            (filterByPrice == 'null' &&
                                                filterByDistance == 'null' &&
                                                filterByAvailability != 'null' &&
                                                filterBySpeciality == 'null')
                                        ? whereNotNull.where((element) => (element.available.toString() == filterByAvailability)).toList()
                                        : whereNotNull
        : (filterByPrice != 'null' && filterByDistance != 'null' && filterByAvailability != 'null')
            //if filtered by price & distance & availability
            ? whereNotNull
                .where((element) =>
                    (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                    (30.0 <= double.parse(filterByDistance)) &&
                    (element.available.toString() == filterByAvailability))
                .toList()
            // if not filtered by price
            : (filterByPrice == 'null' && filterByDistance != 'null' && filterByAvailability != 'null')
                ? whereNotNull.where((element) => (30.0 <= double.parse(filterByDistance)) && (element.available.toString() == filterByAvailability)).toList()
                // if not filtered by distance or price
                : (filterByPrice == 'null' && filterByDistance == 'null' && filterByAvailability != 'null')
                    ? whereNotNull.where((element) => (element.available.toString() == filterByAvailability)).toList()
                    // if not filtered by distance
                    : (filterByPrice != 'null' && filterByDistance == 'null' && filterByAvailability != 'null')
                        ? whereNotNull
                            .where((element) =>
                                (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                                (element.available.toString() == filterByAvailability))
                            .toList()
                        // if not filtered by availabilty
                        : (filterByPrice != 'null' && filterByDistance != 'null' && filterByAvailability == 'null')
                            ? whereNotNull
                                .where((element) =>
                                    (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)) &&
                                    (30.0 <= double.parse(filterByDistance)))
                                .toList()
                            // if not filtered by availabilty or distance
                            : (filterByPrice != 'null' && filterByDistance == 'null' && filterByAvailability == 'null')
                                ? whereNotNull
                                    .where((element) => (double.parse(element.ratesInfo.onlineBooking.upto1Hour) <= double.parse(filterByPrice)))
                                    .toList()
                                // if not filtered by availabilty or price
                                : (filterByPrice == 'null' && filterByDistance != 'null' && filterByAvailability == 'null')
                                    ? whereNotNull.where((element) => (30.0 <= double.parse(filterByDistance))).toList()
                                    // if not filtered
                                    : whereNotNull;
    return filtered;
  }

  //facilities
  Future<List<FacilityProfileModel>> fetchFacilities() async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/HealthFacility/",
      headers: {
        "Authorization": "Bearer " + _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching facilitites');
    }
    print(response.body);
    return facilityProfileModelListFromJson(response.body).toList();
  }

  Future<String> fetchFacilityHourlyRate() async {
    final _token = await getStringValuesSF();
    print('--------|token|--------|value -> ${_token.toString()}');
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/HealthFacility/OnlineBookingrates/1/",
      headers: {"Authorization": "Bearer " + _token, "Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      print('--------|response.reasonPhrase|--------|value -> ${response.reasonPhrase.toString()}');
    }
    final hourlyRate = json.decode(response.body)['upto_1_hour'];
    return hourlyRate;
  }

  Future<List<FacilityOpenHoursModel>> fetchOpenHours(facilityID) async {
    final _token = await getStringValuesSF();
    print('--------|token|--------|value -> ${_token.toString()}');
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/HealthFacility/openHrs/",
      headers: {"Authorization": "Bearer " + _token, "Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      print('--------|response.reasonPhrase|--------|value -> ${response.reasonPhrase.toString()}');
    }

    return facilityOpenHoursFromJson(response.body).where((element) => element.facility == facilityID).toList();
  }

  Future fetchDepartmentsByFacilityID(facilityID) async {
    final _token = await getStringValuesSF();
    print('--------|token|--------|value -> ${_token.toString()}');
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/HealthFacility/openHrs/",
      headers: {"Authorization": "Bearer " + _token, "Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      print('--------|response.reasonPhrase|--------|value -> ${response.reasonPhrase.toString()}');
    }
  }

  //Individual User Profile Creation Endpoint
  Future<Profile> createProfile(String surname, phone, photo, dob, gender, residence, country, blood, chronic, longTerm, date, condition, code, disabilities,
      recreational, drugAllergies, foodAllergies) async {
    Map<String, dynamic> _payLoad = Map();
    Map<String, dynamic> data = Map();
    Map<String, dynamic> previous = Map();
    previous['admission_date'] = date;
    previous['conditions'] = [condition];

    List<String> dis = [data['disabilities'] = disabilities];
    List<String> longterm = [data['long_term_medications'] = longTerm];
    List<String> family = [data['family_chronic_conditions'] = chronic];
    List<String> drugs = [data['recreational_drug_use'] = recreational];
    List<String> dAllergies = [data['recreational_drug_use'] = drugAllergies];
    List<String> fAllergies = [data['recreational_drug_use'] = foodAllergies];

    _payLoad['surame'] = surname;
    _payLoad['profile_img_url'] = phone;
    _payLoad['phone_number'] = code + photo;
    _payLoad['date_of_birth'] = dob;
    _payLoad['gender'] = gender;
    _payLoad['residence'] = residence;
    _payLoad['country'] = country;
    _payLoad['blood_group'] = blood;
    _payLoad['chronic_condition'] = chronic;
    _payLoad['previous_admissions'] = [previous];
    _payLoad['disabilities'] = dis;
    _payLoad['long_term_medications'] = longterm;
    _payLoad['family_chronic_conditions'] = family;
    _payLoad['recreational_drug_use'] = drugs;
    _payLoad['drug_allergies'] = dAllergies;
    _payLoad['food_allergies'] = fAllergies;
    _token = await getStringValuesSF();
    final response = await httpClient.post(Uri.encodeFull(createProfileEndpoint),
        headers: {'Accept': 'application/json', "Content-Type": "application/json", "Authorization": "Bearer " + _token}, body: jsonEncode(_payLoad));
    print(response.body);
    print(_token);
    print(_payLoad);

    if (response.statusCode != 200) {
      throw Exception("Please Enter Fill all the Fields");
    }

    if (!response.body.startsWith('{"id":')) {
      print("No ID");
    } else {
      print("NO");
    }

    final createProfileJson = jsonDecode(response.body);
    return Profile.fromJson(createProfileJson);
  }

  //User Reset Password Endpoint
  Future<ForgotPassword> resetPassword(String email) async {
    Map<String, String> _payLoad = Map();
    _payLoad['email'] = email;
    final response = await this.httpClient.post(Uri.encodeFull(forgotPassEndpoint), headers: {"Content-Type": "application/json"}, body: jsonEncode(_payLoad));
    print(response.body);
    if (response.statusCode != 204) {
      throw Exception('Error creating Profile');
    }
    final resetPasswordJson = jsonDecode(response.body);
    return ForgotPassword.fromJson(resetPasswordJson);
  }

  //User Login Endpoint
  Future<LoginModel> login(String email, String password) async {
    Map<String, String> payLoad = Map();
    payLoad['email'] = email;
    payLoad['password'] = password;

    final response = await this.httpClient.post(Uri.encodeFull(loginEndpoint), headers: {"Content-Type": "application/json"}, body: json.encode(payLoad));
    print(response.body);
    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
    if (response.statusCode != 200) {
      _showSnackBar(response.body.substring(11, response.body.length - 3));
      throw Exception('Error Occurred');
    } else {
      addStringToSF(loginModel.access, loginModel.user.userCategory, loginModel.user.fullNames, loginModel.user.email);
    }
    final loginJson = jsonDecode(response.body);
    return LoginModel.fromJson(loginJson);
  }

  //post review
  Future<ReviewModel> postReview(ReviewModel review) async {
    _token = await getStringValuesSF();
    final mapData = reviewModelToJson(review);

    final response = await this.httpClient.post(
          Uri.encodeFull('https://ssential.herokuapp.com/api/practitionerProfile/reviews/'),
          headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
          body: mapData,
        );
    print("review respsonse | ${response.body}");
    return reviewModelFromJson(response.body);
  }

  //fetch reviews
  Future<List<ReviewModel>> fetchReviews() async {
    _token = await getStringValuesSF();

    final response = await this.httpClient.get(
      'https://ssential.herokuapp.com/api/practitionerProfile/reviews/',
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );
    print("review respsonse | ${response.body}");
    return listOfReviewModelFromJson(response.body);
  }

  //post review
  Future<FacilityReviewModel> postFacilityReview(FacilityReviewModel review) async {
    _token = await getStringValuesSF();
    final mapData = facilityReviewModelToJson(review);

    final response = await this.httpClient.post(
          Uri.encodeFull('https://ssential.herokuapp.com/api/HealthFacility/reviews/'),
          headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
          body: mapData,
        );
    print("review respsonse | ${response.body}");
    return facilityReviewModelFromJson(response.body);
  }

  //fetch reviews
  Future<List<FacilityReviewModel>> fetchFacilityReviews() async {
    _token = await getStringValuesSF();

    final response = await this.httpClient.get(
      'https://ssential.herokuapp.com/api/HealthFacility/reviews/',
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );
    print("review respsonse | ${response.body}");
    return facilityReviewModelListFromJson(response.body);
  }

  Future<CallHistoryModel> addCallHistoryToDB(Map<String, dynamic> mapData) async {
    _token = await getStringValuesSF();

    final response = await http.post(
      'https://ssential.herokuapp.com/api/doctors_consult/call_history/',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
      body: json.encode(mapData),
    );

    print('--------|mapData|--------|value -> ${mapData.toString()}');
    print(response.body);

    return callHistoryModelFromJson(response.body);
  }

  Future<FacilityCallHistoryModel> addFacilityCallHistoryToDB(Map<String, dynamic> mapData) async {
    _token = await getStringValuesSF();

    final response = await http.post(
      'https://ssential.herokuapp.com/api/HealthFacility/CallsHistory/',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
      body: json.encode(mapData),
    );

    print('--------|mapData|--------|value -> ${mapData.toString()}');
    print(response.body);

    return facilityCallHistoryModelFromJson(response.body);
  }

  //appointments
  Future<AppointmentModel> bookAppointments(appointment) async {
    _token = await getStringValuesSF();
    final mapData = appointmentModelToJson(appointment);

    final response = await this.httpClient.post(
          Uri.encodeFull('https://ssential.herokuapp.com/api/doctors_consult/appointment/'),
          headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
          body: mapData,
        );
    print("response data | " + response.body);
    return appointmentModelFromJson(response.body);
  }

  Future<List<AppointmentModel>> fetchBookingHistory(int userID, int docID, int status) async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      Uri.encodeFull('https://ssential.herokuapp.com/api/doctors_consult/appointment/'),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer " + _token},
    );

    final allBookings = appointmentModelListFromJson(response.body);

    final queriedBookings = allBookings.where((e) => e.user == userID && e.profile == docID).toList();
    return queriedBookings;
  }

  //call history
  Future<List<PractitionerProfileModel>> fetchAllDoctorsCalled(userID) async {
    _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/doctors_consult/call_history/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
    );

    final callList = callHistoryListModelFromJson(response.body).where((element) => element.user == userID).toList();

    if (callList.length == 0) {
      return [];
    } else {
      Future<List<PractitionerProfileModel>> getDocs() async {
        List<PractitionerProfileModel> allDocDetails = [];
        for (final doc in callList) {
          final docdetail = await this.fetchDocDetails(doc.profile);
          allDocDetails.add(docdetail);
        }

        return allDocDetails;
      }

      final allDocs = await getDocs();
      return practitionerProfileListModelFromJson(allDocs.map((e) => jsonEncode(e)).toList().toSet().toList().toString());
    }
  }

  Future<List<FacilityProfileModel>> fetchAllFacilitiesCalled(userID) async {
    _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/HealthFacility/CallsHistory",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
    );

    final callList = facilityCallHistoryListModelFromJson(response.body).where((element) => element.user == userID).toList();

    if (callList.length == 0) {
      return [];
    } else {
      Future<List<FacilityProfileModel>> getFacilities() async {
        List<FacilityProfileModel> allFacilityDetails = [];
        for (final facility in callList) {
          final facilityDetail = await this.fetchFacilityDetails(facility.facility);
          allFacilityDetails.add(facilityDetail);
        }

        return allFacilityDetails;
      }

      final allFacilities = await getFacilities();
      return facilityProfileModelListFromJson(allFacilities.map((e) => jsonEncode(e)).toList().toSet().toList().toString());
    }
  }

  Future<List<CallHistoryModel>> fetchAllCallHistory(userID) async {
    _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/doctors_consult/call_history/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
    );

    print('--------|response call|--------|value -> ${response.body.toString()}');

    return callHistoryListModelFromJson(response.body).where((element) => element.user == userID).toList();
  }

  Future<List<FacilityCallHistoryModel>> fetchAllFacilityCallHistory(userID) async {
    _token = await getStringValuesSF();
    final response = await http.get(
      "https://ssential.herokuapp.com/api/HealthFacility/CallsHistory",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token,
      },
    );

    print('--------|response call|--------|value -> ${response.body.toString()}');

    return facilityCallHistoryListModelFromJson(response.body).where((element) => element.user == userID).toList();
  }

  Future<PractitionerProfileModel> fetchDocDetails(docID) async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/user/practitioner_profile/$docID/",
      headers: {
        "Authorization": "Bearer " + _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching practitioner DETAILS');
    }

    print(response.body);
    return practitionerProfileModelFromJson(response.body);
  }

  Future<FacilityProfileModel> fetchFacilityDetails(facilityID) async {
    _token = await getStringValuesSF();
    final response = await this.httpClient.get(
      "https://ssential.herokuapp.com/api/HealthFacility/$facilityID/",
      headers: {
        "Authorization": "Bearer " + _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Error Fetching practitioner DETAILS');
    }

    print(response.body);
    return facilityProfileModelFromJson(response.body);
  }

  //call balance
  Future<CallBalanceModel> fetchCallBalance(userID) async {
    _token = await getStringValuesSF();
    final fetchResponse = await http.get(
      "https://ssential.herokuapp.com/api/doctors_consult/callBalance/",
      headers: {
        'Authorization': 'Bearer ' + _token,
        'Content-Type': 'application/json',
      },
    );

    if (fetchResponse.statusCode == 200) {
      print(fetchResponse.body);
      final allCalls = callBalanceListModelFromJson(fetchResponse.body);
      print('--------|user id|--------|value -> ${allCalls.where((e) => e.user == userID).toList()[0].user.toString()}');
      final callBalanceModel = allCalls.where((e) => e.user == userID).lastWhere((e) => e.createdAt.isBefore(DateTime.now()));
      print('--------|balance from fetch|--------|value -> ${callBalanceModel.amount.toString()}');
      return callBalanceModel;
    } else {
      print(fetchResponse.reasonPhrase);
      return null;
    }
  }

  Future<CallBalanceModel> addCallPayment(paymentData) async {
    final payload = json.encode(paymentData);
    _token = await getStringValuesSF();
    final fetchResponse = await http.post(
      "https://ssential.herokuapp.com/api/doctors_consult/callBalance/",
      headers: {
        'Authorization': 'Bearer ' + _token,
        'Content-Type': 'application/json',
      },
      body: payload,
    );

    if (fetchResponse.statusCode == 201) {
      print(fetchResponse.body);
      final payment = callBalanceModelFromJson(fetchResponse.body);
      return payment;
    } else {
      print(fetchResponse.reasonPhrase);
      print(fetchResponse.statusCode);
      return null;
    }
  }
}

addStringToSF(String value, String userType, String fullName, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = User(email: email, fullNames: fullName);

  // Map<String, dynamic> map ={
  //   'name': user.fullNames,
  //   'email': user.email,
  // };
  // String rawJson = jsonEncode(map);
  // prefs.setString('userInfo', rawJson);

  prefs.setString('token', value);
  prefs.setString('userType', userType);
  prefs.setString('fullName', fullName);
  prefs.setString('email', email);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  return stringValue;
}

void _showSnackBar(message) {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(message),
  ));
}
