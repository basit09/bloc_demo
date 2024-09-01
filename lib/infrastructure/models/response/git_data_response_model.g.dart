// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitDataResponseModel _$GitDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    GitDataResponseModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      url: json['html_url'] as String?,
      stars: (json['stargazers_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GitDataResponseModelToJson(
        GitDataResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'html_url': instance.url,
      'stargazers_count': instance.stars,
    };
