import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_health/screens/facilities/list_documents_page.dart';
import 'package:pocket_health/screens/facilities/signing_documents_page.dart';
import 'package:pocket_health/utils/constants.dart';

class DocumentsCategoriesPage extends StatefulWidget {
  const DocumentsCategoriesPage({
    Key key,
  }) : super(key: key);

  @override
  _DocumentsCategoriesPageState createState() => _DocumentsCategoriesPageState();
}

class _DocumentsCategoriesPageState extends State<DocumentsCategoriesPage> {
  Future<String> createFolderInAppDocDir() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final Directory dirFolder = Directory('${dir.path}/downloadedpdfs/');
    if (await dirFolder.exists()) {
      return dirFolder.path;
    } else {
      final Directory _appDocDirNewFolder = await dirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  @override
  void initState() {
    super.initState();
    createFolderInAppDocDir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Documents',
          style: appBarStyle,
        ),
        backgroundColor: Color(0xFF00FFFF),
      ),
      body: Column(
        children: [
          ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            trailing: Icon(
              Icons.chevron_right,
              color: Color(0xff00FFFF),
            ),
            title: Text(
              "Sign Insurance Documents",
              style: listTileTitleStyle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SigningDocumentsPage();
                  },
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              height: 0,
              thickness: 0.0,
              color: Color(0xffC6C6C6),
            ),
          ),
          ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            trailing: Icon(
              Icons.chevron_right,
              color: Color(0xff00FFFF),
            ),
            title: Text(
              "View Insurance Documents",
              style: listTileTitleStyle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ListDocumentsPage();
                  },
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Divider(
              height: 0,
              thickness: 0.0,
              color: Color(0xffC6C6C6),
            ),
          ),
        ],
      ),
    );
  }
}
