/// Typed request and response models for the WooCommerce Store API checkout.
///
/// These models never contain Cart-Token or Nonce headers.
class WooCheckoutAddress {
  const WooCheckoutAddress({
    this.firstName = '',
    this.lastName = '',
    this.company = '',
    this.address1 = '',
    this.address2 = '',
    this.city = '',
    this.state = '',
    this.postcode = '',
    this.country = '',
    this.email = '',
    this.phone = '',
  });

  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  factory WooCheckoutAddress.fromJson(Map<String, dynamic>? json) {
    final value = json ?? const <String, dynamic>{};
    return WooCheckoutAddress(
      firstName: _checkoutString(value['first_name']),
      lastName: _checkoutString(value['last_name']),
      company: _checkoutString(value['company']),
      address1: _checkoutString(value['address_1']),
      address2: _checkoutString(value['address_2']),
      city: _checkoutString(value['city']),
      state: _checkoutString(value['state']),
      postcode: _checkoutString(value['postcode']),
      country: _checkoutString(value['country']),
      email: _checkoutString(value['email']),
      phone: _checkoutString(value['phone']),
    );
  }

  Map<String, String> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'address_1': address1,
        'address_2': address2,
        'city': city,
        'state': state,
        'postcode': postcode,
        'country': country,
        if (email.isNotEmpty) 'email': email,
        if (phone.isNotEmpty) 'phone': phone,
      };
}

class WooCheckoutPaymentResult {
  const WooCheckoutPaymentResult({
    this.paymentStatus = '',
    this.redirectUrl = '',
  });

  final String paymentStatus;
  final String redirectUrl;

  factory WooCheckoutPaymentResult.fromJson(Map<String, dynamic>? json) {
    final value = json ?? const <String, dynamic>{};
    return WooCheckoutPaymentResult(
      paymentStatus: _checkoutString(value['payment_status']),
      redirectUrl: _checkoutString(value['redirect_url']),
    );
  }
}

class WooCheckoutSession {
  const WooCheckoutSession({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.customerId,
    required this.customerNote,
    required this.billingAddress,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.paymentResult,
  });

  final int? orderId;
  final String orderNumber;
  final String status;
  final int? customerId;
  final String customerNote;
  final WooCheckoutAddress billingAddress;
  final WooCheckoutAddress shippingAddress;
  final String paymentMethod;
  final WooCheckoutPaymentResult? paymentResult;

  factory WooCheckoutSession.fromJson(Map<String, dynamic> json) {
    final payment = json['payment_result'];
    return WooCheckoutSession(
      orderId: _checkoutInt(json['order_id']),
      orderNumber: _checkoutString(json['order_number']),
      status: _checkoutString(json['status']),
      customerId: _checkoutInt(json['customer_id']),
      customerNote: _checkoutString(json['customer_note']),
      billingAddress: WooCheckoutAddress.fromJson(
        json['billing_address'] is Map
            ? Map<String, dynamic>.from(json['billing_address'] as Map)
            : null,
      ),
      shippingAddress: WooCheckoutAddress.fromJson(
        json['shipping_address'] is Map
            ? Map<String, dynamic>.from(json['shipping_address'] as Map)
            : null,
      ),
      paymentMethod: _checkoutString(json['payment_method']),
      paymentResult: payment is Map
          ? WooCheckoutPaymentResult.fromJson(
              Map<String, dynamic>.from(payment),
            )
          : null,
    );
  }
}

/// Only fields documented for the Store API checkout PUT operation.
class WooCheckoutUpdate {
  const WooCheckoutUpdate({
    this.paymentMethod,
    this.orderNotes,
    this.additionalFields = const {},
    this.recalculateTotals = false,
  });

  final String? paymentMethod;
  final String? orderNotes;
  final Map<String, Object?> additionalFields;
  final bool recalculateTotals;

  Map<String, Object?> toJson() => {
        if (paymentMethod != null) 'payment_method': paymentMethod,
        if (orderNotes != null) 'order_notes': orderNotes,
        if (additionalFields.isNotEmpty) 'additional_fields': additionalFields,
      };
}

/// Data for the final POST /checkout operation. Calling submitOrder can create
/// an order and invoke the selected payment gateway; it is never called by
/// initialization or tests using a live client.
class WooCheckoutOrderRequest {
  const WooCheckoutOrderRequest({
    required this.billingAddress,
    required this.shippingAddress,
    required this.paymentMethod,
    this.customerNote,
    this.paymentData = const [],
    this.expectedTotal,
  });

  final WooCheckoutAddress billingAddress;
  final WooCheckoutAddress shippingAddress;
  final String paymentMethod;
  final String? customerNote;
  final List<Map<String, Object?>> paymentData;

  /// Server cart total in the store currency's minor-unit string format.
  final String? expectedTotal;

  Map<String, Object?> toJson() => {
        'billing_address': billingAddress.toJson(),
        'shipping_address': shippingAddress.toJson(),
        'payment_method': paymentMethod,
        if (customerNote != null) 'customer_note': customerNote,
        'payment_data': paymentData,
        if (expectedTotal != null) 'expected_total': expectedTotal,
      };
}

String _checkoutString(dynamic value) => value is String ? value : '';

int? _checkoutInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse('$value');
}
