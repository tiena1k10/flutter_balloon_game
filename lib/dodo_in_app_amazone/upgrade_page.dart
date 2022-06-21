import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'in_app.dart';
import 'in_app_constant.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({Key? key}) : super(key: key);

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  final DodoInApp _inApp = Get.put(
    DodoInApp(
      useAmazon: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    _inApp.init();
  }

  @override
  void dispose() {
    _inApp.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: Container(
                        height: 300,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.only(
                        //       bottomLeft: Radius.circular(10),
                        //       bottomRight: Radius.circular(10)),
                        //   image: DecorationImage(
                        //       image: AssetImage('assets/images/bg.png'),
                        //       fit: BoxFit.cover),
                        // ),
                        child: Lottie.asset('assets/images/balloon.json'),
                      ),
                    ),
                    Positioned(
                      top: 16.0,
                      left: 16.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: kConsumables.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                  "${index + 1} s ",
                                  style: const TextStyle(fontSize: 24),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: _inApp
                                          .isProductReady(kConsumables[index])
                                      ? () {
                                          _inApp.buyById(kConsumables[index]);
                                        }
                                      : null,
                                  child: const Text("Buy"),
                                ),
                                subtitle:
                                    Text(_inApp.getPrice(kConsumables[index])),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class BuyItem extends StatelessWidget {
//   const BuyItem({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);

//   final String productId;

//   @override
//   Widget build(BuildContext context) {
//     final _inApp = Get.find<DodoInApp>();
//     return Obx(
//       () => ListTile(
//         title: Text(_inApp.getPrice(productId)),
//         trailing: ElevatedButton(
//           onPressed: _inApp.isProductReady(productId)
//               ? () {
//                   _inApp.buyBuyId(productId);
//                 }
//               : null,
//           child: const Text("Buy"),
//         ),
//       ),
//     );
//   }
// }
