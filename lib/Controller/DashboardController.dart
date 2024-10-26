import 'package:get/get.dart';

class DashboardController extends GetxController{
  int dashboardIndex = 0;
  





  set updateDashboardIndex(int updateIndex){
    dashboardIndex = updateIndex;
    update();
  }
}