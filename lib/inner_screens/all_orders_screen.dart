import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business_logic/global_cubit/utils.dart';
import '../controllers/MenuController.dart';
import '../responsive.dart';
import '../widgets/herder.dart';
import '../widgets/orders_list.dart';
import '../widgets/side_menu.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuControllerr>().getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Header(
                        showTextField: false,
                        fct: () {
                          context.read<MenuControllerr>().controlAllOrder();
                        },
                        title:'All Orders' ,

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OrdersList(isInDashboard: false,)
                        // StreamBuilder<QuerySnapshot>(
                        //   //there was a null error just add those lines
                        //   stream: FirebaseFirestore.instance.collection('orders').snapshots(),
                        //
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     } else if (snapshot.connectionState == ConnectionState.active) {
                        //       if (snapshot.data!.docs.isNotEmpty) {
                        //         return const OrdersList();
                        //       } else {
                        //         return const Center(
                        //           child: Padding(
                        //             padding: EdgeInsets.all(18.0),
                        //             child: Text('Your store is empty'),
                        //           ),
                        //         );
                        //       }
                        //     }
                        //     return const Center(
                        //       child: Text(
                        //         'Something went wrong',
                        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
