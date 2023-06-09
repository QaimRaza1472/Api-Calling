import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'model.dart';


class MyServices extends GetxController{

  var userData=[].obs;
  bool loading=false;

  @override
  void onInit() {
    loadUserList();
    // TODO: implement onInit
    super.onInit();
  }
 void  loadUserList() async{
    var res = await http.get(Uri.https('dummyjson.com', 'users'));
    if(res.statusCode==200){
      var mydata =jsonDecode(res.body);
      userData.value =mydata['users'];
      print("*************************");
      print(userData);
      print("*************************");

    }

  }
}