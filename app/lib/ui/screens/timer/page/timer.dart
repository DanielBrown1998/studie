import 'package:app/ui/core/components/app_bar.dart';
import 'package:app/ui/core/components/error_screen.dart';
import 'package:app/ui/core/components/load_screen.dart';
import 'package:app/ui/core/theme/theme.dart';
import 'package:app/ui/screens/timer/logic/timer_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TimerScreen extends GetView<TimerLogic> {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
      appBar: StudieAppBar.appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.center,
            colors: [
              StudieTheme.primaryColor,
              StudieTheme.terciaryColor,
              StudieTheme.whiteSmoke,
            ],
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(width: width, height: height * .25),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 1,
              child: Text(
                "Pomodoro",
                textAlign: TextAlign.center,
                style: StudieTheme.textTheme.displayLarge,
              ),
            ),
            controller.obx(
              onError: (error) => ErrorScreen(error: error),
              onLoading: LoadScreen(),
              onEmpty: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Lottie.asset(
                      "assets/lotties/countdown.json",
                      height: height * .2,
                    ),
                    Text(
                      "reiniciar...",
                      style: StudieTheme.textTheme.bodyMedium,
                    ),
                    IconButton(
                      iconSize: Get.height * .1,
                      onPressed: () {
                        controller.startTimer();
                      },
                      icon: Icon(Icons.restart_alt),
                    ),
                  ],
                ),
              ),
              (state) => Obx(
                () => Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 2,
                          color: StudieTheme.primaryColor,
                        ),
                        color: StudieTheme.terciaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "${controller.time.value.inMinutes}:${controller.time.value.inSeconds % 60}",
                            style: StudieTheme.textTheme.titleLarge!.copyWith(
                              fontSize: Get.height * .1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              (!controller.isPlaying.value)
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.start,
                                      size: Get.height * .04,
                                    ),
                                    onPressed: () {
                                      controller.startTimer();
                                    },
                                  )
                                  : IconButton(
                                    icon: Icon(
                                      Icons.pause,
                                      size: Get.height * .04,
                                    ),
                                    onPressed: () {
                                      controller.pauseTimer();
                                    },
                                  ),
                              IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  size: Get.height * .04,
                                ),
                                onPressed: () {
                                  controller.cancelTimer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 3,
              child: Container(width: width, height: height * .25),
            ),
          ],
        ),
      ),
    );
  }
}
