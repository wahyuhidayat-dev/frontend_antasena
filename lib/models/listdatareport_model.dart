import 'package:equatable/equatable.dart';

class ListReport extends Equatable {
  final String url_video;
  final String video_name;
  final int share;

  ListReport(
      {required this.url_video, required this.video_name, required this.share});

  factory ListReport.fromJson(Map<String, dynamic> data) => ListReport(
        url_video: data['url_video'],
        video_name: data['video_name'],
        share: data['share'],
      );

  ListReport copyWith({
    required String url_video,
    required String video_name,
    required String share,
  }) =>
      ListReport(
          url_video: this.url_video,
          video_name: this.video_name,
          share: this.share);

  @override
  List<Object> get props => [url_video, video_name, share];
}

ListReport mockUser = ListReport(
  url_video: 'Jalan Jenderal Sudirman',
  video_name: 'Bandung',
  share: 1234,
);
