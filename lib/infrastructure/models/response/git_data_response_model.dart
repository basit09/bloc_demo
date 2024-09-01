import 'package:json_annotation/json_annotation.dart';

part 'git_data_response_model.g.dart';

@JsonSerializable()
class GitDataResponseModel {
  final int id;
  final String? name;
  final String? description;
  @JsonKey(name: 'html_url')
  final String? url;
  @JsonKey(name: 'stargazers_count')
  final int? stars;

  GitDataResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
  });

  factory GitDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GitDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GitDataResponseModelToJson(this);
}
