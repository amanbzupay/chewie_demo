import 'package:flutter/cupertino.dart';
import 'dart:convert';

class ZuAppDimensions {
  ZuAppDimensions._();
  // Headings
  static final double heading1TextSize = SizeConfig.deviceHeight! * 4.5;
  static final double heading2TextSize = SizeConfig.deviceHeight! * 3.75;
  static final double heading3TextSize = SizeConfig.deviceHeight! * 3;
  static final double heading4TextSize = SizeConfig.deviceHeight! * 2.5;
  static final double heading5TextSize = SizeConfig.deviceHeight! * 2.25;

  //body
  static final double body1TextSize = SizeConfig.deviceHeight! * 2;
  static final double body2TextSize = SizeConfig.deviceHeight! * 1.75;
  static final double smallTextSize = SizeConfig.deviceHeight! * 1.5;
  //
  static final double buttonPaddingTop = SizeConfig.deviceHeight! * 2;
  static final double buttonPaddingBottom = SizeConfig.deviceHeight! * 2;
  static final double buttonPaddingLeft = SizeConfig.deviceWidth! * 8;
  static final double buttonPaddingRight = SizeConfig.deviceWidth! * 8;
  //
  static final double paddingTop = SizeConfig.deviceHeight! * 2;
  static final double paddingBottom = SizeConfig.deviceHeight! * 2;
  static final double paddingLeft = SizeConfig.deviceWidth! * 3;
  static final double paddingRight = SizeConfig.deviceWidth! * 8;
  static final double paddingAllSides = SizeConfig.deviceWidth! * 3;

  static final EdgeInsets zuAcademyTopBarPadding = EdgeInsets.only(
    top: SizeConfig.deviceHeight! * 1.25,
    bottom: SizeConfig.deviceHeight! * 1,
  );

  static final double paddingMinimum = SizeConfig.deviceHeight! * 0.8;
  static final double kAvatarRadius = SizeConfig.deviceWidth! * 6;

  //border_radius,padding,
  static const double smallBorderRadius = 12;
  static const double mediumBorderRadius = 16;
  static const double largeBorderRadius = 20;
  static const double extraBorderRadius = 32;
  static const double buttonBorderRadius = 28;
  static const double maxBorderRadius = 24;

  static final EdgeInsets standardSymmetricPadding = EdgeInsets.symmetric(
    vertical: SizeConfig.deviceHeight! * 1,
    horizontal: SizeConfig.deviceWidth! * 4.444,
  );
}

final SizedBox vSizedBox1 = SizedBox(
  height: SizeConfig.deviceHeight! * 0.5,
);
final SizedBox vSizedBox2 = SizedBox(
  height: SizeConfig.deviceHeight! * 1,
);
final SizedBox vSizedBox3 = SizedBox(
  height: SizeConfig.deviceHeight! * 1.5,
);
final SizedBox vSizedBox4 = SizedBox(
  height: SizeConfig.deviceHeight! * 2,
);
final SizedBox vSizedBox5 = SizedBox(
  height: SizeConfig.deviceHeight! * 3,
);
final SizedBox vSizedBox6 = SizedBox(
  height: SizeConfig.deviceHeight! * 4,
);

final SizedBox hSizedBox2 = SizedBox(
  width: SizeConfig.deviceWidth! * 2,
);

final SizedBox hSizedBox10 = SizedBox(
  width: SizeConfig.deviceWidth! * 10,
);
final SizedBox hSizedBox30 = SizedBox(
  width: SizeConfig.deviceWidth! * 30,
);

final SizedBox hSizedBox1 = SizedBox(
  width: SizeConfig.deviceWidth! * 1,
);
final SizedBox hSizedBoxSmall = SizedBox(
  width: SizeConfig.deviceWidth! * 0.4,
);
final SizedBox hSizedBox4 = SizedBox(
  width: SizeConfig.deviceWidth! * 4,
);
final SizedBox hSizedBox6 = SizedBox(
  width: SizeConfig.deviceWidth! * 6,
);

class SizeConfig {
  late MediaQueryData _mediaQueryData;
  static double? deviceWidth;
  static double? deviceHeight;
  static bool? isDarkMode;
  static bool? isLightMode;
  static Orientation? orientation;
  static Brightness? brightness;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    deviceWidth = _mediaQueryData.size.width / 100;
    deviceHeight = _mediaQueryData.size.height / 100;
    orientation = _mediaQueryData.orientation;
    brightness = _mediaQueryData.platformBrightness;

    //Hardcoded as false for 1.0.0 release which will go only in light mode
    isDarkMode = false;

    // isDarkMode = _mediaQueryData.platformBrightness == Brightness.dark;
    // isLightMode = _mediaQueryData.platformBrightness == Brightness.light;
  }

  static double calculateHeightRatio(
      {required double designPixels, double designHeight = 800}) {
    print(SizeConfig.deviceHeight! * 30);
    print((designPixels * (100 / designHeight)) * deviceHeight!);
    return (designPixels * (100 / designHeight)) * deviceHeight!;
  }

  static double calculateWidthRatio(
      {double designWidth = 360, required double designPixels}) {
    return (designPixels * (100 / designWidth)) * deviceWidth!;
  }
}

class PromoListModel {
  PromoListModel({
    required this.nonFeaturePromoList,
    required this.featurePromoList,
  });

  final List<PromoModel> nonFeaturePromoList;
  final List<PromoModel> featurePromoList;

  factory PromoListModel.fromRawJson(String str) =>
      PromoListModel.fromJson(json.decode(str) as Map<String, dynamic>);

  // String toRawJson() => json.encode(toJson());

  factory PromoListModel.fromJson(Map<String, dynamic> json) => PromoListModel(
      nonFeaturePromoList: List<PromoModel>.from(
        (json["data"] as List).map(
          (x) => PromoModel.fromJson(x as Map<String, dynamic>),
        ),
      ).where((element) => !element.isFeature).toList(),
      featurePromoList: List<PromoModel>.from(
        (json["data"] as List).map(
          (x) => PromoModel.fromJson(x as Map<String, dynamic>),
        ),
      ).where((element) => element.isFeature).toList());

// Map<String, dynamic> toJson() => {
//       "data": List<dynamic>.from(
//         nonFeaturePromoList.map(
//           (x) => x.toJson(),
//         ),
//       ),
//     };
}

class PromoModel {
  PromoModel({
    required this.imageUrl,
    required this.altText,
    required this.intent,
    required this.thumbNail,
    required this.intentType,
    required this.isFeature,
    required this.dimensions,
    required this.apiOnCall,
  });

  final String imageUrl;
  final String altText;
  final String intent;
  final String intentType;
  final String thumbNail;
  final bool isFeature;
  final String dimensions;
  final String apiOnCall;

  factory PromoModel.fromRawJson(String str) =>
      PromoModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        imageUrl: json["image_url"] as String,
        altText: json["alt_text"] as String,
        intent: json["intent"] as String,
        intentType: json["intent_type"] as String,
        thumbNail:
            json.containsKey('thumb_url') ? json["thumb_url"] as String : '',
        isFeature: json['feature'] as bool,
        dimensions: json.containsKey("dimensions")
            ? json["dimensions"] as String
            : "34x98",
        apiOnCall: (json['api_on_click'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions,
        "image_url": imageUrl,
        "alt_text": altText,
        "intent": intent,
        "intent_type": intentType,
        "feature": isFeature,
        "api_on_click": apiOnCall,
      };
}
