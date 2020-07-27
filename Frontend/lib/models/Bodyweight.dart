class Bodyweight {
  double value;
  DateTime date;
  bool isLb;

  Bodyweight({this.value, this.date, this.isLb = false});

  double toKg() => this.isLb
      ? double.parse((this.value / 2.205).toStringAsFixed(1))
      : this.value;

  double toLb() => !this.isLb
      ? double.parse((this.value * 2.205).toStringAsFixed(1))
      : this.value;
}
