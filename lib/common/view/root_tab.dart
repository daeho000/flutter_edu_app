import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/colors.dart';
import 'package:flutter_edu_app/common/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text('Root Tab'),
      ),
    );
  }
}