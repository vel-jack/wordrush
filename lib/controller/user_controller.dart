import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final Rx<int> _score = Rx<int>(0);
  int get score => _score.value;
  SharedPreferences? prefs;

  @override
  void onReady() {
    getScore();
    super.onReady();
  }

  Future<void> getScore() async {
    prefs ??= await SharedPreferences.getInstance();
    _score.value = prefs!.getInt('highscore') ?? 0;
  }

  Future<void> setScore(int scoreToSet) async {

    await prefs!.setInt('highscore', scoreToSet);
    _score.value = scoreToSet;
  }

}
