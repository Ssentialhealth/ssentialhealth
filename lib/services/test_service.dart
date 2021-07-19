import 'package:json_patch/json_patch.dart';

test({int vaccineNo, int scheduleNo}) {
  try {
    final newJson = JsonPatch.apply(
      {
        "id": 18,
        "schedules": [
          {
            "id": 103,
            "vaccines": [
              {"id": 1, "vaccine_name": "BCG TB Vaccine", "received": false, "date_received": null, "schedule": 103},
              {"id": 2, "vaccine_name": "Polio vaccine", "received": false, "date_received": null, "schedule": 103},
              {"id": 3, "vaccine_name": "Hepatitis B vaccine", "received": false, "date_received": null, "schedule": 103},
              {"id": 4, "vaccine_name": "Vitamin K", "received": false, "date_received": null, "schedule": 103}
            ],
            "age": "At birth",
            "due_date": "2015-06-07"
          },
          {
            "id": 104,
            "vaccines": [
              {
                "id": 5,
                "vaccine_name": "Diptheria/Tetanus/Pertussis/Hib/Hepatitis B/Injected Polio Vaccines",
                "received": false,
                "date_received": null,
                "schedule": 104
              },
              {"id": 6, "vaccine_name": "Polio vaccine, dose 2 of 5.", "received": false, "date_received": null, "schedule": 104},
              {"id": 7, "vaccine_name": "Rotavirus vaccine, dose 1 of 2", "received": false, "date_received": null, "schedule": 104},
              {"id": 8, "vaccine_name": "Pneumonia pneumococcal vaccine, dose 1 of 3", "received": false, "date_received": null, "schedule": 104}
            ],
            "age": "6 Weeks",
            "due_date": "2015-07-19"
          },
          {
            "id": 105,
            "vaccines": [
              {
                "id": 9,
                "vaccine_name": "Diptheria/Tetanus/Pertussis/Hib/Hepatitis B/Injected Polio Vaccines, dose 2 of 3",
                "received": false,
                "date_received": null,
                "schedule": 105
              },
              {"id": 10, "vaccine_name": "Polio vaccine, dose 3 of 5", "received": false, "date_received": null, "schedule": 105},
              {"id": 11, "vaccine_name": "Rotavirus vaccine, dose 2 of 2", "received": false, "date_received": null, "schedule": 105},
              {"id": 12, "vaccine_name": "Pneumonia pneumococcal vaccine, dose 2 of 3", "received": false, "date_received": null, "schedule": 105}
            ],
            "age": "10 weeks",
            "due_date": "2015-08-16"
          },
          {
            "id": 106,
            "vaccines": [
              {
                "id": 13,
                "vaccine_name": "Diptheria/Tetanus/Pertussis/Hib/Hepatitis B/Injected Polio Vaccines with orwithout Polio Vaccine, dose 3 of 3",
                "received": false,
                "date_received": null,
                "schedule": 106
              },
              {"id": 14, "vaccine_name": "Polio vaccine, dose 4 of 5, given by mouth", "received": false, "date_received": null, "schedule": 106},
              {"id": 15, "vaccine_name": "Polio vaccine, dose 5 of 5", "received": false, "date_received": null, "schedule": 106},
              {"id": 16, "vaccine_name": "Pneumonia pneumococcal vaccine, dose 3 of 3", "received": false, "date_received": null, "schedule": 106}
            ],
            "age": "14 weeks",
            "due_date": "2015-09-13"
          },
          {
            "id": 107,
            "vaccines": [
              {"id": 17, "vaccine_name": "Vitamin A routine supplementation", "received": false, "date_received": null, "schedule": 107},
              {
                "id": 18,
                "vaccine_name": "Advice on transition to various feeds to complement continued breastfeeding (weaning advice)",
                "received": false,
                "date_received": null,
                "schedule": 107
              },
              {"id": 19, "vaccine_name": "Flu vaccine, dose 1 of 2", "received": false, "date_received": null, "schedule": 107},
              {"id": 20, "vaccine_name": "Optional Hepatitis B vaccine booster dose", "received": false, "date_received": null, "schedule": 107}
            ],
            "age": "6 months",
            "due_date": "2015-12-10"
          },
          {
            "id": 108,
            "vaccines": [
              {"id": 21, "vaccine_name": "Flu vaccine, dose 2 of 2(optional)", "received": false, "date_received": null, "schedule": 108}
            ],
            "age": "7 months",
            "due_date": "2016-01-09"
          }
        ],
        "child_name": "David",
        "child_dob": "2015-06-07",
        "user": 5
      },
      [
        {'op': 'replace', "path": "/schedules/$scheduleNo/vaccines/$vaccineNo/received", 'value': true}
        //                 schedule index.    ^                    ^vaccine number
      ],
      strict: true,
    );
    print('Object after applying patch operations: $newJson');
  } on JsonPatchTestFailedException catch (e) {
    print(e);
  }
}
