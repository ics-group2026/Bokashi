import 'package:bokashi/data/model/image_full_url.dart';
import 'package:bokashi/features/product/domain/models/product_model.dart';
import 'package:bokashi/helper/parse_helper.dart';

class BannerModel {
  int? id;
  String? photo;
  String? bannerType;
  int? published;
  String? createdAt;
  String? updatedAt;
  String? url;
  String? resourceType;
  int? resourceId;
  Product? product;
  String? title;
  String? subTitle;
  String? buttonText;
  String? backgroundColor;
  ImageFullUrl? photoFullUrl;

  BannerModel(
      {this.id,
        this.photo,
        this.bannerType,
        this.published,
        this.createdAt,
        this.updatedAt,
        this.url,
        this.resourceType,
        this.resourceId,
        this.product,
        this.title,
        this.subTitle,
        this.buttonText,
        this.backgroundColor,
        this.photoFullUrl
      });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = parseInt(json['id']);
    photo = json['photo'];
    bannerType = json['banner_type'];
    published = parseInt(json['published']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    resourceType = json['resource_type'];
    resourceId = parseInt(json['resource_id']);
    title = json['title'];
    subTitle = json['sub_title'];
    buttonText = json['button_text'];
    backgroundColor = json['background_color'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    photoFullUrl = json['photo_full_url'] != null
      ? ImageFullUrl.fromJson(json['photo_full_url']) : null;
  }

}
