// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardJson _$_BoardJsonFromJson(Map<String, dynamic> json) {
  return _BoardJson(
    width: json['width'] as int,
    height: json['height'] as int,
    cells: (json['cells'] as List)
        ?.map((e) => (e as List)
            ?.map((e) =>
                e == null ? null : Cell.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$_BoardJsonToJson(_BoardJson instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'cells': instance.cells
          ?.map((e) => e?.map((e) => e?.toJson())?.toList())
          ?.toList(),
    };
