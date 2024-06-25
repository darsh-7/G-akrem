

class DonationHistory {
  int? id;
  int? medicineCategoryId;
  String? medicineCategoryName;
  String? expirationDate;
  bool? isExpired;
  Null? storageId;
  Null? storageType;
  String? correctName;
  String? correctConcentration;
  String? imagePath;
  int? medicineForm;
  bool? isRevisioned;
  int? donationOrderId;

  DonationHistory(
      {this.id,
        this.medicineCategoryId,
        this.medicineCategoryName,
        this.expirationDate,
        this.isExpired,
        this.storageId,
        this.storageType,
        this.correctName,
        this.correctConcentration,
        this.imagePath,
        this.medicineForm,
        this.isRevisioned,
        this.donationOrderId});

  DonationHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicineCategoryId = json['medicineCategoryId'];
    medicineCategoryName = json['medicineCategoryName'];
    expirationDate = json['expirationDate'];
    isExpired = json['isExpired'];
    storageId = json['storageId'];
    storageType = json['storageType'];
    correctName = json['correctName'];
    correctConcentration = json['correctConcentration'];
    imagePath = json['imagePath'];
    medicineForm = json['medicineForm'];
    isRevisioned = json['isRevisioned'];
    donationOrderId = json['donationOrderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicineCategoryId'] = this.medicineCategoryId;
    data['medicineCategoryName'] = this.medicineCategoryName;
    data['expirationDate'] = this.expirationDate;
    data['isExpired'] = this.isExpired;
    data['storageId'] = this.storageId;
    data['storageType'] = this.storageType;
    data['correctName'] = this.correctName;
    data['correctConcentration'] = this.correctConcentration;
    data['imagePath'] = this.imagePath;
    data['medicineForm'] = this.medicineForm;
    data['isRevisioned'] = this.isRevisioned;
    data['donationOrderId'] = this.donationOrderId;
    return data;
  }
}