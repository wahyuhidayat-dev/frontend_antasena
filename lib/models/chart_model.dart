import 'package:equatable/equatable.dart';

class Chart extends Equatable {
  final String periode;
  final String usd;

  Chart({
    required this.periode,
    required this.usd,
  });

  factory Chart.fromJson(Map<String, dynamic> data) => Chart(
        periode: data['periode'],
        usd: data['usd'],
      );

  Chart copyWith({
    required String periode,
    required int usd,
  }) =>
      Chart(periode: this.periode, usd: this.usd);

  @override
  List<Object> get props => [periode, usd];
}

Chart mockUser = Chart(
  periode: "1123",
  usd: "1",
);
