import 'package:json_annotation/json_annotation.dart';

part 'forecast_model.g.dart';
@JsonSerializable(explicitToJson: true)
class Forecast {
    Forecast({
        this.success,
        this.result,
        this.records,
    });

    String? success;
    Result? result;
    Records? records;
    factory Forecast.fromJson(Map<String, dynamic> data) => _$ForecastFromJson(data);
    Map<dynamic, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Records {
    Records({
        this.locations,
    });

    List<RecordsLocation>? locations;
    factory Records.fromJson(Map<String, dynamic> data) => _$RecordsFromJson(data);
    Map<dynamic, dynamic> toJson() => _$RecordsToJson(this);
}

// @JsonSerializable(explicitToJson: true)
class RecordsLocation {
    RecordsLocation({
        this.datasetDescription,
        this.locationsName,
        this.dataid,
        this.location,
    });

    String? datasetDescription;
    String? locationsName;
    String? dataid;
    List<LocationLocation>? location;
    factory RecordsLocation.fromJson(Map<String, dynamic> data) => _$RecordsLocationFromJson(data);
    Map<dynamic, dynamic> toJson() => _$RecordsLocationToJson(this);
}

// @JsonSerializable(explicitToJson: true)
class LocationLocation {
    LocationLocation({
        this.locationName,
        this.geocode,
        this.lat,
        this.lon,
        this.weatherElement,
    });

    String? locationName;
    String? geocode;
    String? lat;
    String? lon;
    List<WeatherElement>? weatherElement;

    factory LocationLocation.fromJson(Map<String, dynamic> data) => _$LocationLocationFromJson(data);
    Map<dynamic, dynamic> toJson() => _$LocationLocationToJson(this);
}

// @JsonSerializable(explicitToJson: true)
class WeatherElement {
    WeatherElement({
        this.elementName,
        this.description,
        this.time,
    });

    String? elementName;
    String? description;
    List<Time>? time;
    factory WeatherElement.fromJson(Map<String, dynamic> data) => _$WeatherElementFromJson(data);
    Map<dynamic, dynamic> toJson() => _$WeatherElementToJson(this);
}

// @JsonSerializable(explicitToJson: true)
class Time {
    Time({
        this.startTime,
        this.endTime,
        this.elementValue,
        
    });
    
    DateTime? startTime;
    DateTime? endTime;
    List<ElementValue>? elementValue;

    factory Time.fromJson(Map<String, dynamic> data) => _$TimeFromJson(data);
    Map<dynamic, dynamic> toJson() => _$TimeToJson(this);
}

// @JsonSerializable()
class ElementValue {
    ElementValue({
        this.value,
        this.measures,
    });

    String? value;
    String? measures;
    factory ElementValue.fromJson(Map<String, dynamic> data) => _$ElementValueFromJson(data);
    Map<dynamic, dynamic> toJson() => _$ElementValueToJson(this);
}

// @JsonSerializable(explicitToJson: true)
class Result {
    Result({
        this.resourceId,
        this.fields,
    });

    String? resourceId;
    List<Field>? fields;

    factory Result.fromJson(Map<String, dynamic> data) => _$ResultFromJson(data);
    Map<dynamic, dynamic> toJson() => _$ResultToJson(this);
}

// @JsonSerializable()
class Field {
    Field({
        this.id,
        this.type,
    });

    String? id;
    String? type;

    factory Field.fromJson(Map<String, dynamic> data) => _$FieldFromJson(data);
    Map<dynamic, dynamic> toJson() => _$FieldToJson(this);
}

