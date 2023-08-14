import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:web_admin_panel/business_logic/global_cubit/utils.dart';
import 'package:web_admin_panel/business_logic/servies/globle_method.dart';
import 'package:web_admin_panel/inner_screens/add_prod.dart';
import 'package:web_admin_panel/responsive.dart';
import 'package:web_admin_panel/widgets/buttons.dart';
import 'package:web_admin_panel/widgets/text_widgets.dart';
import '../consts/constt.dart';
import '../controllers/MenuController.dart';
import '../inner_screens/all_orders_screen.dart';
import '../widgets/grid_products.dart';
import '../widgets/herder.dart';
import '../widgets/orders_list.dart';
import '../widgets/products_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MenuControllerr>().controlDashBoardMenu();
                },
              title:'Dashboard' ,
            ),
            TextWidget(text: 'Latest products', color: color),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                ButtonsWidget(
                    onPressed: () {},
                    text: 'View All',
                    icon: Icons.store,
                    backgroundColor: Colors.blue),
                const Spacer(),
                ButtonsWidget(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UploadProductForm()));
                      },
                    text: 'Add product',
                    icon: Icons.add,
                    backgroundColor: Colors.blue),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGridWidget(
                          crossAxisCount: size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? .8 : .6,
                        ),
                        desktop: ProductGridWidget(
                          //crossAxisCount:size.width > 650 ? 2 : 4 ,
                          childAspectRatio: size.width < 1400 ? .7 : 1,
                        ),
                      ),
                       const OrdersList(),

                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
