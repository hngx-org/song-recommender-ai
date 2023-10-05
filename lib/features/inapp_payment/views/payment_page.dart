import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/inapp_payment/viewmodels/payment.viewmodel.dart';
import 'package:song_recommender_ai/utils/widgets/custom_buttons.dart';
import 'dart:io';
import 'package:in_app_payment/in_app_payment.dart';
import '../../../utils/widgets/custom_list_tile.dart';

class PaymentView extends StatelessWidget {
  PaymentView({
    super.key,
  });

  final pay = HNGPay();

  @override
  Widget build(BuildContext context) {
    PaymentViewModel paymentViewModel = context.watch<PaymentViewModel>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icons.arrow_back_ios,
        ),
        actions: [
          CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.close,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'SongScript Plus',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22.0),
                ),
                const Spacer(),
                Text(
                  '\$${paymentViewModel.amountToPay}/mo',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20.0),
                )
              ],
            ),
            SizedBox(
              height: height * 0.005,
            ),
            const PaymentListTile(
              title: 'Available even when demand is high',
            ),
            const PaymentListTile(
              title: 'Faster response speed',
            ),
            const PaymentListTile(
              title: 'Priority access to new feature',
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Platform.isIOS
                ? pay.applePay(context,
                    amountToPay: "${paymentViewModel.amountToPay}",
                    userID: "${paymentViewModel.getUserId()}")
                : pay.googlePay(context,
                    amountToPay: "${paymentViewModel.amountToPay}",
                    userID: "${paymentViewModel.getUserId()}")
          ],
        ),
      ),
    );
  }
}
