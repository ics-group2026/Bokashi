
import 'package:bokashi/features/shop/domain/models/seller_model.dart';
import 'package:bokashi/helper/parse_helper.dart';

class CouponItemModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<Coupons>? coupons;

  CouponItemModel({this.totalSize, this.limit, this.offset, this.coupons});

  CouponItemModel.fromJson(Map<String, dynamic> json) {
    totalSize = parseInt(json['total_size']);
    limit = parseInt(json['limit']);
    offset = parseInt(json['offset']);
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
  }

}

class Coupons {
  int? id;
  String? addedBy;
  String? couponType;
  String? couponBearer;
  int? sellerId;
  String? title;
  String? code;
  int? limit;
  Seller? seller;
  String? expireDate;
  String? expireDatePlanText;
  String? planExpireDate;
  double? discount;
  String? discountType;
  double? minPurchase;
  int? orderCount;

  Coupons(
      {this.id,
        this.addedBy,
        this.couponType,
        this.couponBearer,
        this.sellerId,
        this.title,
        this.code,
        this.limit,
        this.seller,
        this.expireDate,
        this.planExpireDate,
        this.expireDatePlanText,
        this.discount,
        this.discountType,
        this.minPurchase,
        this.orderCount,
      });

  Coupons.fromJson(Map<String, dynamic> json) {
    id = parseInt(json['id']);
    addedBy = json['added_by'];
    couponType = json['coupon_type'];
    couponBearer = json['coupon_bearer'];
    title = json['title'];
    code = json['code'];
    sellerId = parseInt(json['seller_id']);
    if(json['limit'] != null){
      limit = double.parse(json['limit'].toString()).toInt();
    }

    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    expireDate = json['expire_date'];
    planExpireDate = json['plain_expire_date'];
    expireDatePlanText = json['plain_expire_date'];
    if(json['discount'] != null){
      discount = parseDouble(json['discount']);
    }
    if(json['min_purchase'] != null){
      minPurchase = parseDouble(json['min_purchase']);
    }

    discountType = json['discount_type'];
    if(json['order_count'] != null){
      try{
        orderCount = parseInt(json['order_count']);
      }catch(e){
        orderCount = double.parse(json['order_count'].toString()).toInt();
      }
    }else{
      orderCount = 0;
    }

  }

}
