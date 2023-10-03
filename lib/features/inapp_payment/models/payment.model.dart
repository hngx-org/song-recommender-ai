import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/inapp_payment/models/payment_config.dart';
// import 'package:song_recommender_ai/features/inapp_payment/viewmodels/payment.viewmodel.dart';
import 'package:song_recommender_ai/utils/widgets/custom_buttons.dart';
import 'package:pay/pay.dart';
import 'dart:io';
import '../repositories/payment.repository.dart';

class PaymentView extends StatelessWidget {
  PaymentView({super.key});

  final String os = Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
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
            // CustomCheckboxListTile(
            //   title: Text(
            //     'Google pay',
            //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            //   ),
            //   icon: Icon(Icons.payments_rounded),
            // ),
            // SizedBox(
            //   height: height * 0.02,
            // ),
            // CustomCheckboxListTile(
            //   title: Text(
            //     'Apple pay',
            //     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            //   ),
            //   icon: Icon(Icons.apple),
            // ),
            SizedBox(
              height: height * 0.04,
            ),
            const Row(
              children: [
                Text(
                  'Order total',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                ),
                Expanded(child: SizedBox()),
                Text('\$123.99',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0))
              ],
            ),
            Platform.isIOS
                ? ApplePayButton(
                    paymentConfiguration:
                        PaymentConfiguration.fromJsonString(defaultApplePay),
                    paymentItems: paymentItems,
                    style: ApplePayButtonStyle.black,
                    type: ApplePayButtonType.buy,
                    width: double.infinity,
                    height: 50.0,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (onApplePayResult) {},
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : GooglePayButton(
                    paymentConfiguration:
                        PaymentConfiguration.fromJsonString(defaultGooglePay),
                    paymentItems: paymentItems,
                    type: GooglePayButtonType.pay,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (data) {},
                    width: double.infinity,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            // RoundedButton(
            //   color: Colors.black87,
            //   buttonTitle: 'Confirm order',
            //   textStyleColor: Colors.white,
            // )
          ],
        ),
      ),
    );
  }
}
