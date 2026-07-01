import 'package:bokashi/data/model/image_full_url.dart';
import 'package:bokashi/features/shop/domain/models/seller_model.dart';
import 'package:bokashi/helper/parse_helper.dart';

class ShopAgainFromRecentStoreModel {
  int? id;
  String? name;
  String? slug;
  String? thumbnail;
  ImageFullUrl? thumbnailFullUrl;
  double? unitPrice;
  int? userId;
  int? reviewsCount;
  Seller? seller;
  bool? isAddedByAdmin;


  ShopAgainFromRecentStoreModel(
      {this.id,
        this.name,
        this.slug,
        this.thumbnail,
        this.thumbnailFullUrl,
        this.unitPrice,
        this.userId,
        this.reviewsCount,
        this.seller,
        this.isAddedByAdmin,
       });

  ShopAgainFromRecentStoreModel.fromJson(Map<String, dynamic> json) {
    id = parseInt(json['id']);
    name = json['name'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    unitPrice = parseDouble(json['unit_price']);
    userId = parseInt(json['user_id']);
    reviewsCount = double.parse(json['reviews_count'].toString()).toInt();
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    thumbnailFullUrl = json['thumbnail_full_url'] != null
      ? ImageFullUrl.fromJson(json['thumbnail_full_url'])
      : null;
    isAddedByAdmin = json['added_by'] == 'admin';
  }
}

