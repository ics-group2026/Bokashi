import 'package:bokashi/data/model/image_full_url.dart';
import 'package:bokashi/helper/parse_helper.dart';

class MostDemandedProductModel {
  int? id;
  String? banner;
  ImageFullUrl? bannerFullUrl;
  int? productId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? reviewCount;
  int? orderCount;
  int? deliveryCount;
  int? wishlistCount;

  MostDemandedProductModel(
      {this.id,
        this.banner,
        this.bannerFullUrl,
        this.productId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.reviewCount,
        this.orderCount,
        this.deliveryCount,
        this.wishlistCount});

  MostDemandedProductModel.fromJson(Map<String, dynamic> json) {
    id = parseInt(json['id']);
    banner = json['banner'];
    productId = parseInt(json['product_id']);
    status = parseInt(json['status']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    reviewCount = parseInt(json['review_count'], defaultValue: 0);
    orderCount = parseInt(json['order_count'], defaultValue: 0);
    deliveryCount = parseInt(json['delivery_count'], defaultValue: 0);
    wishlistCount = parseInt(json['wishlist_count'], defaultValue: 0);
    bannerFullUrl = json['banner_full_url'] != null
        ? ImageFullUrl.fromJson(json['banner_full_url'])
        : null;
  }

}
