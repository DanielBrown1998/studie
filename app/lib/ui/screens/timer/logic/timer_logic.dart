import 'dart:async';

import 'package:get/get.dart';

class TimerLogic extends GetxController with StateMixin<Duration> {
  Rx<Duration> time = Duration.zero.obs;
  Timer timer = Timer(Duration.zero, () {});
  RxBool isPlaying = false.obs;

  RxStatus success = RxStatus.success();
  RxStatus loading = RxStatus.loading();
  RxStatus error = RxStatus.error("Houve um erro!".tr);
  RxStatus empty = RxStatus.empty();

  @override
  void onInit() {
    try {
      change(Duration.zero, status: loading);
      super.onInit();
      change(Duration.zero, status: success);
      print(timer.isActive.toString());
    } on Exception {
      change(Duration.zero, status: error);
    }
  }

  startTimer() {
    change(Duration.zero, status: success);
    isPlaying.value = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      time.value += Duration(seconds: 1);
      if (time.value >= Duration(minutes: 1)) {
        cancelTimer();
        change(Duration.zero, status: empty);
        //TODO emitir alarme;
        print(timer.isActive.toString());
      }
    });
  }

  pauseTimer() {
    if (isPlaying.value) {
      timer.cancel();
      isPlaying.value = !isPlaying.value;
    }
  }

  cancelTimer() {
    if (isPlaying.value) {
      timer.cancel();
      time.value = Duration.zero;
      isPlaying.value = !isPlaying.value;
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
