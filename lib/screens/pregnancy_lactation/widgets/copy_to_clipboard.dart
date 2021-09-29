import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_health/utils/constants.dart';

class CopyToClipboard extends StatelessWidget {
  final String toCopy;

  const CopyToClipboard({Key key, this.toCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: toCopy)).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: accentColorDark,
              content: Text(
                "Copied to clipboard!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.copy,
        color: accentColorDark,
        size: 20.w,
      ),
    );
  }
}
