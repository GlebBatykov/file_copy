///
class CopyProgress {
  ///
  final int total;

  ///
  final int remains;

  ///
  double get progress => 1 - regress;

  ///
  double get regress => remains / total;

  CopyProgress(this.total, this.remains);
}
