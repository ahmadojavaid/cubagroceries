import '../../../utils/images.dart';

class PaymentMethodAccountModel {
  String icon;
  String name;

  PaymentMethodAccountModel({required this.icon, required this.name});
}

List<PaymentMethodAccountModel> paymentDetail() {
  List<PaymentMethodAccountModel> tempPaymentDetail = [];

  tempPaymentDetail.add(PaymentMethodAccountModel(icon: Images.img_paypalLogo, name: "PayPal"));
  tempPaymentDetail.add(PaymentMethodAccountModel(icon: Images.img_googleLogo, name: "Google Pay"));
  tempPaymentDetail.add(PaymentMethodAccountModel(icon: Images.img_applePayLogo, name: "Apple Pay"));
  tempPaymentDetail.add(PaymentMethodAccountModel(icon: Images.img_mastercardLogo, name: "Master Card"));
  tempPaymentDetail.add(PaymentMethodAccountModel(icon: Images.img_visapay, name: "Visa Pay"));

  return tempPaymentDetail;
}
