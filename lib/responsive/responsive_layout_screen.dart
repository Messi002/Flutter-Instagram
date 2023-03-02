import 'package:flutter/material.dart';
import 'package:instagram/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > Dimension.webScreenSize) {
          // Web screen here
          return webScreenLayout;
        }
        //Else mobile screen here
        return mobileScreenLayout;
      },
    );
  }
}
