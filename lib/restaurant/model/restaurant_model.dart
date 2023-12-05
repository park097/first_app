import 'package:actual/common/const/data.dart';
import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

// 파트 파일을 지정을 한 코드가 생성이 될 수 있는
//모든 파일에서 코드를 생성시킴
part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

//클래스를 json-sreializable로 자동으로 코드를 생성시킬거다
@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  //제이슨은
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  //현재클래스를 넣어주면 됨
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
