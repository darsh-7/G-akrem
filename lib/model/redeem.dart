class Redeem {
  Redeem(
      {required this.id,
      required this.cost,
      required this.sale,
      required this.till,
      required this.description,
      required this.date
      });

  late int id;
  late int cost;
  late int sale;
  late String till;
  late String description;
  late DateTime date;
}

List<Redeem> redeems = [
  Redeem(
    id: 4,
    sale: 23,
    cost: 30,
    till: 'Abu Anas Al-Suri',
    description: '',
    date: DateTime.now(),
  ),

  Redeem(
    id: 2,
    cost: 5,
    sale: 5,
    till: 'Sayed Hanafi',
    description: '',
    date: DateTime(2024, 6, 26),

  ),
  Redeem(
    id: 3,
    sale: 10,
    cost: 30,
    till: 'kansas fried chicken',
    description: '',
    date: DateTime(2024, 6, 27),
  ),
  Redeem(
    id: 1,
    cost: 10,
    sale: 20,
    till: 'buffalo berger',
    description: '',
    date: DateTime(2024, 6, 29),

  ),
];
