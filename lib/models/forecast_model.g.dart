// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      success: json['success'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      records: json['records'] == null
          ? null
          : Records.fromJson(json['records'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result?.toJson(),
      'records': instance.records?.toJson(),
    };

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => RecordsLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
    };

RecordsLocation _$RecordsLocationFromJson(Map<String, dynamic> json) =>
    RecordsLocation(
      datasetDescription: json['datasetDescription'] as String?,
      locationsName: json['locationsName'] as String?,
      dataid: json['dataid'] as String?,
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => LocationLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsLocationToJson(RecordsLocation instance) =>
    <String, dynamic>{
      'datasetDescription': instance.datasetDescription,
      'locationsName': instance.locationsName,
      'dataid': instance.dataid,
      'location': instance.location?.map((e) => e.toJson()).toList(),
    };

LocationLocation _$LocationLocationFromJson(Map<String, dynamic> json) =>
    LocationLocation(
      locationName: json['locationName'] as String?,
      geocode: json['geocode'] as String?,
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
      weatherElement: (json['weatherElement'] as List<dynamic>?)
          ?.map((e) => WeatherElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationLocationToJson(LocationLocation instance) =>
    <String, dynamic>{
      'locationName': instance.locationName,
      'geocode': instance.geocode,
      'lat': instance.lat,
      'lon': instance.lon,
      'weatherElement':
          instance.weatherElement?.map((e) => e.toJson()).toList(),
    };

WeatherElement _$WeatherElementFromJson(Map<String, dynamic> json) =>
    WeatherElement(
      elementName: json['elementName'] as String?,
      description: json['description'] as String?,
      time: (json['time'] as List<dynamic>?)
          ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherElementToJson(WeatherElement instance) =>
    <String, dynamic>{
      'elementName': instance.elementName,
      'description': instance.description,
      'time': instance.time?.map((e) => e.toJson()).toList(),
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      elementValue: (json['elementValue'] as List<dynamic>?)
          ?.map((e) => ElementValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'elementValue': instance.elementValue?.map((e) => e.toJson()).toList(),
    };

ElementValue _$ElementValueFromJson(Map<String, dynamic> json) => ElementValue(
      value: json['value'] as String?,
      measures: json['measures'] as String?,
    );

Map<String, dynamic> _$ElementValueToJson(ElementValue instance) =>
    <String, dynamic>{
      'value': instance.value,
      'measures': instance.measures,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      resourceId: json['resourceId'] as String?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'resourceId': instance.resourceId,
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      id: json['id'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
