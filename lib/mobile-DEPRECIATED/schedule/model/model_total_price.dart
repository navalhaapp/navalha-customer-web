class TotalPriceService {
  double? totalPriceWithoutDicount;
  double? discount;
  String? totalWithDicount;

  TotalPriceService({
    this.totalPriceWithoutDicount,
    this.discount,
    this.totalWithDicount,
  });

  void clear() {
    totalPriceWithoutDicount = 0;
    discount = 0;
    totalWithDicount = '';
  }
}
