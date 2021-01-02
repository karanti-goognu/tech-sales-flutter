class DealerModel {
  String _dealerId;
  String _dealerName;
  bool _isSelected;

  DealerModel(this._dealerId, this._dealerName, this._isSelected);

  String get dealerName => _dealerName;

  set dealerName(String value) {
    _dealerName = value;
  }

  String get dealerId => _dealerId;

  set dealerId(String value) {
    _dealerId = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}

class DealerModelSelected {
  String _dealerId;
  String _dealerName;

  DealerModelSelected(this._dealerId, this._dealerName);

  String get dealerName => _dealerName;

  set dealerName(String value) {
    _dealerName = value;
  }

  String get dealerId => _dealerId;

  set dealerId(String value) {
    _dealerId = value;
  }
}
