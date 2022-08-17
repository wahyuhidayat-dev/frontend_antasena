import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final int asset_id;
  final String periode;
  final int revenue_usd;
  final int rate_idr;
  final int revenue_idr;
  final int label_revenue;
  final int get_ugc;
  final int marketing;
  final int share_revenue;
  final int tax;
  final int final_revenue;
  final int share;
  final int ads;

  Report({
    required this.id,
    required this.asset_id,
    required this.periode,
    required this.revenue_usd,
    required this.rate_idr,
    required this.revenue_idr,
    required this.label_revenue,
    required this.get_ugc,
    required this.marketing,
    required this.share_revenue,
    required this.tax,
    required this.final_revenue,
    required this.share,
    required this.ads,
  });

  factory Report.fromJson(Map<String, dynamic> data) => Report(
        id: data['id'],
        asset_id: data['asset_id'],
        periode: data['periode'],
        revenue_usd: data['revenue_usd'],
        rate_idr: data['rate_idr'],
        revenue_idr: data['revenue_idr'],
        label_revenue: data['label_revenue'],
        get_ugc: data['get_ugc'],
        marketing: data['marketing'],
        share_revenue: data['share_revenue'],
        tax: data['tax'],
        final_revenue: data['final_revenue'],
        share: data['share'],
        ads: data['ads'],
      );

  Report copyWith({
    required int id,
    required int asset_id,
    required String periode,
    required int revenue_usd,
    required int rate_idr,
    required int revenue_idr,
    required int label_revenue,
    required int get_ugc,
    required int marketing,
    required int share_revenue,
    required int tax,
    required int final_revenue,
    required int share,
    required int ads,
  }) =>
      Report(
          id: this.id,
          asset_id: this.asset_id,
          periode: this.periode,
          revenue_usd: this.revenue_usd,
          rate_idr: this.rate_idr,
          revenue_idr: this.revenue_idr,
          label_revenue: this.label_revenue,
          get_ugc: this.get_ugc,
          marketing: this.marketing,
          share_revenue: this.share_revenue,
          tax: this.tax,
          final_revenue: this.final_revenue,
          share: this.share,
          ads: this.ads);

  @override
  List<Object> get props => [
        id,
        asset_id,
        periode,
        revenue_usd,
        rate_idr,
        revenue_idr,
        label_revenue,
        get_ugc,
        marketing,
        share_revenue,
        tax,
        final_revenue,
        share,
        ads
      ];
}
