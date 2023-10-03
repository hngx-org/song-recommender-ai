import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/inapp_payment/payment_config.dart';
import 'package:song_recommender_ai/utils/widgets/custom_input_field.dart';
import 'package:song_recommender_ai/utils/widgets/custom_list_tile.dart';
import 'package:song_recommender_ai/utils/widgets/custom_buttons.dart';
import 'package:pay/pay.dart';
import 'dart:io';

class PaymentView extends StatelessWidget {
  PaymentView({super.key});

  String os = Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    const _paymentItems = [
      PaymentItem(
        label: 'Order now',
        amount: '123.99',
        status: PaymentItemStatus.final_price,
      ),
    ];

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
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
            Row(
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
                    paymentItems: _paymentItems,
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
                    paymentItems: _paymentItems,
                    type: GooglePayButtonType.pay,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (data) {
                      print('data');
                    },
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
