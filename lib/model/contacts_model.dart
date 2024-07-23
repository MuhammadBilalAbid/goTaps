class Connection {
  final int connectionId;
  final String connectionFirstName;
  final String connectionLastName;
  final String connectionUserName;
  final String connectionJobTitle;
  final String connectionCompany;
  final String connectionPhoto;
  final int connectionVerified;
  final int connectionTaps;

  Connection({
    required this.connectionId,
    required this.connectionFirstName,
    required this.connectionLastName,
    required this.connectionUserName,
    required this.connectionJobTitle,
    required this.connectionCompany,
    required this.connectionPhoto,
    required this.connectionVerified,
    required this.connectionTaps,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      connectionId: json['connection_id'] ?? 0,
      connectionFirstName: json['connection_first_name'] ?? '',
      connectionLastName: json['connection_last_name'] ?? '',
      connectionUserName: json['connection_user_name'] ?? '',
      connectionJobTitle: json['connection_job_title'] ?? '',
      connectionCompany: json['connection_company'] ?? '',
      connectionPhoto: json['connection_photo'] ?? '',
      connectionVerified: json['connection_verified'] ?? 0,
      connectionTaps: json['connection_taps'] ?? 0,
    );
  }
}
