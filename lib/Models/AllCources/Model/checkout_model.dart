class CheckoutModel {
  final int? statusCode;
  final String? message;
  final CheckoutData? data;

  CheckoutModel({
    this.statusCode,
    this.message,
    this.data,
  });

  CheckoutModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? CheckoutData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class CheckoutData {
  final String? pageTitle;
  final List<PaymentChannels>? paymentChannels;
  final double? subTotal;
  final double? totalDiscount;
  final String? tax;
  final dynamic taxPrice;
  final dynamic total;
  final dynamic userGroup;
  final Order? order;
  final int? count;
  final int? userCharge;
  final bool? razorpay;

  CheckoutData({
    this.pageTitle,
    this.paymentChannels,
    this.subTotal,
    this.totalDiscount,
    this.tax,
    this.taxPrice,
    this.total,
    this.userGroup,
    this.order,
    this.count,
    this.userCharge,
    this.razorpay,
  });

  CheckoutData.fromJson(Map<String, dynamic> json)
      : pageTitle = json['pageTitle'] as String?,
        paymentChannels = (json['paymentChannels'] as List?)
            ?.map((dynamic e) =>
                PaymentChannels.fromJson(e as Map<String, dynamic>))
            .toList(),
        subTotal = double.parse(json['subTotal'].toString()),
        totalDiscount = double.parse(json['totalDiscount'].toString()),
        tax = json['tax'] as String?,
        taxPrice = json['taxPrice'],
        total = json['total'],
        userGroup = json['userGroup'],
        order = (json['order'] as Map<String, dynamic>?) != null
            ? Order.fromJson(json['order'] as Map<String, dynamic>)
            : null,
        count = json['count'] as int?,
        userCharge = json['userCharge'] as int?,
        razorpay = json['razorpay'] as bool?;

  Map<String, dynamic> toJson() => {
        'pageTitle': pageTitle,
        'paymentChannels': paymentChannels?.map((e) => e.toJson()).toList(),
        'subTotal': subTotal,
        'totalDiscount': totalDiscount,
        'tax': tax,
        'taxPrice': taxPrice,
        'total': total,
        'userGroup': userGroup,
        'order': order?.toJson(),
        'count': count,
        'userCharge': userCharge,
        'razorpay': razorpay
      };
}

class PaymentChannels {
  final int? id;
  final String? title;
  final String? className;
  final String? status;
  final String? image;
  final String? settings;
  final String? createdAt;

  PaymentChannels({
    this.id,
    this.title,
    this.className,
    this.status,
    this.image,
    this.settings,
    this.createdAt,
  });

  PaymentChannels.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        className = json['class_name'] as String?,
        status = json['status'] as String?,
        image = json['image'] as String?,
        settings = json['settings'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'class_name': className,
        'status': status,
        'image': image,
        'settings': settings,
        'created_at': createdAt
      };
}

class Order {
  final int? userId;
  final String? status;
  final double? amount;
  final dynamic tax;
  final double? totalDiscount;
  final dynamic totalAmount;
  final double? productDeliveryFee;
  final int? createdAt;
  final int? id;

  Order({
    this.userId,
    this.status,
    this.amount,
    this.tax,
    this.totalDiscount,
    this.totalAmount,
    this.productDeliveryFee,
    this.createdAt,
    this.id,
  });

  Order.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as int?,
        status = json['status'] as String?,
        amount = double.parse(json['amount'].toString()),
        tax = json['tax'],
        totalDiscount = double.parse(json['total_discount'].toString()),
        totalAmount = json['total_amount'],
        productDeliveryFee =
            double.parse(json['product_delivery_fee'].toString()),
        createdAt = json['created_at'] as int?,
        id = json['id'] as int?;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'status': status,
        'amount': amount,
        'tax': tax,
        'total_discount': totalDiscount,
        'total_amount': totalAmount,
        'product_delivery_fee': productDeliveryFee,
        'created_at': createdAt,
        'id': id
      };
}
