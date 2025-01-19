class LocationState {
  final num lat;
  final num long;
  final String errorMessage;
  final String actionMessage;
  final LocationStatus status;

  LocationState({
    required this.lat,
    required this.long,
    this.errorMessage = '',
    this.actionMessage = '',
    this.status = LocationStatus.pure,
  });

  LocationState copyWith({
    String? errorMessage,
    String? actionMessage,
    LocationStatus? status,
    num? lat,
    num? long,
  }) {
    return LocationState(
      errorMessage: errorMessage ?? this.errorMessage,
      actionMessage: actionMessage ?? this.actionMessage,
      status: status ?? this.status,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  static LocationState initialValue() => LocationState(lat: 0, long: 0);
}

enum LocationStatus { denied, granted, pure, error }
