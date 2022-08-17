import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final int id;
  final int user_id;
  final String url_video;
  final String video_name;
  final String channel_name;

  Asset(
      {required this.id,
      required this.user_id,
      required this.url_video,
      required this.video_name,
      required this.channel_name});

  factory Asset.fromJson(Map<String, dynamic> data) => Asset(
        id: data['id'],
        user_id: data['user_id'],
        url_video: data['url_video'],
        video_name: data['video_name'],
        channel_name: data['channel_name'],
      );

  Asset copyWith({
    required int id,
    required String user_id,
    required String url_video,
    required String video_name,
    required String channel_name,
  }) =>
      Asset(
          id: this.id,
          user_id: this.user_id,
          url_video: this.url_video,
          video_name: this.video_name,
          channel_name: this.channel_name);

  @override
  List<Object> get props => [id, user_id, url_video, video_name, channel_name];
}

Asset mockUser = Asset(
  id: 1,
  user_id: 1,
  url_video: 'Jalan Jenderal Sudirman',
  video_name: 'Bandung',
  channel_name: '1234',
);
