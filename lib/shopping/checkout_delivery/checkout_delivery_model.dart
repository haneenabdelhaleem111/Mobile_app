import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import '../../backend/woocommerce/checkout_models.dart';
import 'checkout_delivery_widget.dart' show CheckoutDeliveryWidget;

class CheckoutDeliveryModel extends FlutterFlowModel<CheckoutDeliveryWidget> {
  final formKey = GlobalKey<FormState>();
  WooCheckoutAddress? billingAddress;
  WooCheckoutAddress? shippingAddress;
  final billingNameController = TextEditingController();
  final billingEmailController = TextEditingController();
  final billingPhoneController = TextEditingController();
  final billingAddressController = TextEditingController();
  final billingCityController = TextEditingController();
  final billingCountryController = TextEditingController();
  final shippingNameController = TextEditingController();
  final shippingAddressController = TextEditingController();
  final shippingCityController = TextEditingController();
  final shippingCountryController = TextEditingController();
  final shippingPhoneController = TextEditingController();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    billingNameController.dispose();
    billingEmailController.dispose();
    billingPhoneController.dispose();
    billingAddressController.dispose();
    billingCityController.dispose();
    billingCountryController.dispose();
    shippingNameController.dispose();
    shippingAddressController.dispose();
    shippingCityController.dispose();
    shippingCountryController.dispose();
    shippingPhoneController.dispose();
  }
}
