import 'package:pay/pay.dart';

List<PaymentItem> paymentItems = [
  const PaymentItem(
    label: 'Order now',
    amount: '123.99',
    status: PaymentItemStatus.final_price,
  ),
];
