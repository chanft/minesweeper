// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CellJson _$_CellJsonFromJson(Map<String, dynamic> json) {
  return _CellJson(
    item: _$enumDecodeNullable(_$ItemEnumMap, json['item']),
    cover: _$enumDecodeNullable(_$CoverEnumMap, json['cover']),
  );
}

Map<String, dynamic> _$_CellJsonToJson(_CellJson instance) => <String, dynamic>{
      'item': _$ItemEnumMap[instance.item],
      'cover': _$CoverEnumMap[instance.cover],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ItemEnumMap = {
  Item.none: 'none',
  Item.mine: 'mine',
};

const _$CoverEnumMap = {
  Cover.uncovered: 'uncovered',
  Cover.unflagged: 'unflagged',
  Cover.flagged: 'flagged',
};
