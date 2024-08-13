
class Pharmacy {
  String img;
  String? name;
  String? locName;
  String location;
  int? time;
  double boxStorage;
  String? phone;

  Pharmacy({
    required this.img,
    required this.name,
    required this.locName,
    required this.location,
    this.time,
    required this.boxStorage,
    this.phone,
  });

  static List<Pharmacy> pharmacyList = [
    Pharmacy(
        img: "https://i.pinimg.com/originals/e4/37/30/e437307f4baf5f8c6a9236c82886bbd4.jpg",
        name: 'Pharmacy1Pharmacy1',
        locName: '8502 Preston Rd. Inglewood, Maine 98380',
        location: "iqkuwhdiauwdiaw12783",
        time: 15,
        boxStorage:  0.6,
        phone: "01012345678"),
    Pharmacy(
        img: "https://frenchly.us/wp-content/uploads/2023/02/Pharmacy-front-shutterstock.jpg",
        name: 'Pharmacy2',
        locName: 'Cairo',
        location: "iqkuwhdiauw213diaw12783",
        time: 15,
        boxStorage: 0.3,
        phone: "01012345678"),
    Pharmacy(
        img: "https://pbs.twimg.com/media/DjLwIwJXcAAl1xW.jpg",
        name: 'Pharmacy1Pharmacy1',
        locName: '8502 Preston Rd. Inglewood, Maine 98380',
        location: "iqkuwhdiauwdiaw12783",
        time: 15,
        boxStorage:  0.9,
        phone: "01012345678"),
    Pharmacy(
        img:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_6UxZS5E87vjuXTgTQ4Qw3MAvtv3srWQwpg&usqp=CAU",
        name: 'Pharmacy2',
        locName: 'Cairo',
        location: "iqkuwhdiauw213diaw12783",
        time: 15,
        boxStorage:  0.1,
        phone: "01012345678"),
    // Pharmacy(
    //     img:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxZS5E87vjuXTgTQ4Qw3MAvtv3srWQwpg&usqp=CAU",
    //     name: 'Pharmacy no pic',
    //     locName: 'Cairo',
    //     location: "iqkuwhdiauw213diaw12783",
    //     time: 15,
    //     boxStorage:  0.1,
    //     phone: "01012345678"),

  ];
}
