import 'package:api_calling/Getx/my_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScreen extends StatelessWidget {
   MyScreen({Key? key}) : super(key: key);

  MyServices services = Get.find<MyServices>();

  @override
  Widget build(BuildContext context) {
    services.loadUserList();
    print("###############################");
    print(services.userData);
    print("###############################");

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Screen"),
      centerTitle: true,
      ),
      floatingActionButton:FloatingActionButton(
          onPressed: (){
            services.loadUserList();
          },
        child: const Icon(Icons.refresh),
      ),
      body:services.userData.isNotEmpty
          ?
      ListView.builder(
        itemCount: services.userData.length,
        itemBuilder: (context,index){
          return Obx(()
            => Card(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              //color:Colors.red.withOpacity(0.2),
                              offset: const Offset(0, 5),
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              //'',
                              '${services.userData[index]['image']}'



                             // _users[index]['image'],
                            ),
                            fit: BoxFit.contain,
                          )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(   '',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          '',
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

        },
      )
          :const Center(
            child: CircularProgressIndicator(),
      ),

    );
  }
}
