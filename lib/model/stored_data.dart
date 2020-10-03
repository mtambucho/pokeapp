class StoredData {
  final bool onBoardingShowed;

  StoredData({this.onBoardingShowed});

  Map<String, dynamic> get map => {
        'onBoardingShowed': onBoardingShowed,
      };

  factory StoredData.fromJson(Map<String, dynamic> parsedJson) {
    return StoredData(
      onBoardingShowed: parsedJson['onBoardingShowed'],
    );
  }
}
