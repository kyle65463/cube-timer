import 'package:cubetimer/pages/timer/controller/timer_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeCounter extends StatelessWidget {
  TimeCounter({Key? key}) : super(key: key);
  final TimerPageController controller = Get.find<TimerPageController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: controller.timer.rawTime,
      initialData: controller.currentTime,
      builder: (context, snapshot) {
        final int time = snapshot.data!;
        final String displayTime = controller.parseDisplayTime(time);
        return Center(
          child: Text(
            displayTime,
            style: TextStyle(
              fontSize: 70,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}