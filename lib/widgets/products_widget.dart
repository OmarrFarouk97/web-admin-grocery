import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:web_admin_panel/widgets/text_widgets.dart';

import '../business_logic/global_cubit/darkThemeProvider.dart';
import '../business_logic/global_cubit/utils.dart';
import '../business_logic/servies/globle_method.dart';
import '../inner_screens/edit_prod.dart';

// class ProductWidget extends StatefulWidget {
//   const ProductWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _ProductWidgetState createState() => _ProductWidgetState();
// }
//
// class _ProductWidgetState extends State<ProductWidget> {
//   @override
//   Widget build(BuildContext context) {
//      final themeState = Provider.of<DarkThemeProvider>(context);
//      final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Material(
//         borderRadius: BorderRadius.circular(12),
//         color: Theme.of(context).cardColor.withOpacity(0.6),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       flex: 2,
//                       child: Image.network(
//                         'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
//                         fit: BoxFit.fill,
//                         // width: screenWidth * 0.12,
//                         height: 120.h,
//                       ),
//                     ),
//                     const Spacer(),
//                     PopupMenuButton(
//                         itemBuilder: (context) => [
//                           PopupMenuItem(
//                             onTap: () {},
//                             value: 1,
//                             child:const Text('Edit'),
//                           ),
//                           PopupMenuItem(
//                             onTap: () {},
//                             value: 2,
//                             child: const Text(
//                               'Delete',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ])
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 2,
//                 ),
//                 Row(
//                   children: [
//                     TextWidget(
//                       text: '\$1.99',
//                       color: color,
//                       textSize: 18,
//                     ),
//                     const SizedBox(
//                       width: 7,
//                     ),
//                     Visibility(
//                         visible: true,
//                         child: Text(
//                           '\$3.89',
//                           style: TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               color: color),
//                         )),
//                     const Spacer(),
//                     TextWidget(
//                       text: '1Kg',
//                       color: color,
//                       textSize: 18,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 2,
//                 ),
//                 TextWidget(
//                   text: 'Title',
//                   color: color,
//                   textSize: 24,
//                   isTitle: true,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = false;
  String title = '';
  String productCat = '';
  String? imageUrl;
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .get();
      if (productsDoc == null) {
        return;
      } else {
        title = productsDoc.get('title');
        productCat = productsDoc.get('productCategoryName');
        imageUrl = productsDoc.get('imageUrl');
        price = productsDoc.get('price');
        salePrice = productsDoc.get('salePrice');
        isOnSale = productsDoc.get('isOnSale');
        isPiece = productsDoc.get('isPiece');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethod.errorDialog(subTitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  id: widget.id,
                  title: title,
                  price: price,
                  salePrice: salePrice,
                  productCat: productCat,
                  imageUrl: imageUrl == null
                      ? 'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png'
                      : imageUrl!,
                  isOnSale: isOnSale,
                  isPiece: isPiece,
                ),
              ),
            );

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        imageUrl == null
                            ? 'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png'
                            : imageUrl!,
                        fit: BoxFit.fill,
                        // width: screenWidth * 0.12,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            child: Text('Edit'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            onTap: () {},
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                            value: 2,
                          ),
                        ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale
                          ? '\$${salePrice.toStringAsFixed(2)}'
                          : '\$$price',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: isOnSale,
                        child: Text(
                          '\$$price',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: isPiece ? 'Piece' : '1Kg',
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
