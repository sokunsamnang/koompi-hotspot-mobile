import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class AppServices {
  static String contentConnection = "Something wrong with your connection ";
  static int myNumCount = 0;

  static Future noInternetConnection(GlobalKey<ScaffoldState> globalKey) async {
    try {
      final Connectivity _connectivity = Connectivity();

      final myResult = await _connectivity.checkConnectivity();

      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          // print("Open Red snackbar");
          openSnackBar(globalKey, contentConnection);
        } else {
          // ignore: deprecated_member_use
          globalKey.currentState.removeCurrentSnackBar();
        }
      });

      if (myResult == ConnectivityResult.none) {
        openSnackBar(globalKey, contentConnection);
      }
    } catch (e) {}
  }

  static void openSnackBar(GlobalKey<ScaffoldState> globalKey, String content) {
    // ignore: deprecated_member_use
    globalKey.currentState.showSnackBar(snackBarBody(content, globalKey));
  }

  // ignore: avoid_void_async
  static void closeSnackBar(
      GlobalKey<ScaffoldState> globalKey, String content) async {
    // await globalKey.currentState.showSnackBar(snackBarBody(content, globalKey)).closed.then((value) =>
    //   print("value $value")
    // );
  }

  static SnackBar snackBarBody(String content, globalKey) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(days: 365),
      backgroundColor: Colors.red,
      content: Text(content,
          style: const TextStyle(
            color: Colors.white,
          )),
      action: SnackBarAction(
        label: "Close",
        textColor: Colors.white,
        onPressed: () {
          globalKey.currentState.removeCurrentSnackBar();
        },
      ),
    );
  }

  // ignore: avoid_void_async
  static void clearStorage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  // Remove Zero At The Position Of Phone Number
  static String removeZero(String number) {
    return number.replaceFirst("0", "", 0);
  }

  static double getRadienFromDegree(double degree) {
    const double unitRadien = 57.295779513;
    return degree / unitRadien;
  }

  static Timer appLifeCycle(Timer timer) {
    return timer;
  }

  static Map<String, dynamic> emptyMapData() {
    return Map<String, dynamic>.unmodifiable({});
  }

  // ignore: avoid_void_async
  static void timerOutHandler(http.Response res, Function timeCounter) async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timer.tick <= 10) {
        timeCounter(timer);
        // ignore: invariant_booleans
      } else if (timer.tick > 10) timer.cancel();
    });
  }
}
