import 'package:flutter/material.dart';
import 'package:project_management_frontend/core/t_colors.dart';

import '../t_sizes.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: TColors.bottomBar,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: IconButton(
                iconSize: TIconSizes.normal,
                padding: EdgeInsetsGeometry.all(0),
                icon: Icon(Icons.home_outlined, color: TColors.textGlobal),
                // ToDo: implement functionality for bottom navigation home button
                onPressed: () => print('home pressed'),
              ),
            ),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
