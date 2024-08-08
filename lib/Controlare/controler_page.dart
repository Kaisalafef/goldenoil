import 'package:get/get.dart';

class ControlerPage extends GetxController {
  int counter = 0;
  int price = 0;
  int x = 0;
  RxBool isDarkMode = false.obs;

  void updateDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void incremtnt() {
    counter++;
  }
void incresprice(int a){
    price += a;

}
  int _selectIndex = 0;

  int get selectIndex => _selectIndex;

  set selectIndex(int value) {
    _selectIndex = value;
    update();
  }
}
