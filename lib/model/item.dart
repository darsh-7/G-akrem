class Product {

  late String id;
  late String name;
  late double price;
  late String image;
  late int sale;
  late String location;


  Product({required this.id, required this.name, required this.price, required this.image, required this.sale, required this.location});

}
const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/devkit';
 List<Product> items = [
  Product(
      id: "1",
      name: 'Panadol Advance 500mg',
      price: 433,
      image: 'https://dkud4u09qff41.cloudfront.net/Products/ac84b8ac-e0e8-45e8-827f-7c7a3b0c5aca.jpeg',
      sale: 310,
      location: 'Nacer'
  ),

  Product(
       id: "2",
      name: 'Aerius 5mg',
      price: 2212,
      image: "https://dkud4u09qff41.cloudfront.net/Products/54f8c485-60da-43be-86f4-6a535bc6ef70.jpeg",
      sale: 37,
      location: 'Brooklyn'
  ),
  Product(
      id: "3",
      name: 'Viotic Ear Drops - 10 ML',
      price: 1643,
      image: "https://dkud4u09qff41.cloudfront.net/Products/0558d4c8-1b83-4901-a147-32bbdd32edea.jpeg",
      sale: 3,
      location: 'Brooklyn'
  ),
  Product(
      id: "4",
      name: 'Otrivin 0.1% Adult Nasal Drops 15 ML',
      price: 120,
      image: "https://dkud4u09qff41.cloudfront.net/Products/e2b4e54d-501c-4065-8778-30bf77ba729f.jpeg",
      sale: 6,
      location: 'Brooklyn'
  ),
  Product(
      id: "5",
      name: 'Voltaren 1% Emulgel 100 gm',
      price: 62,
      image: "https://dkud4u09qff41.cloudfront.net/Products/933c70c1-8e81-43b2-aed3-c2c9fb82d226.png",
      sale: 69,
      location: 'Brooklyn'
  ),
  Product(  id: "6",
      name: 'Aldomet 250mg',
      price: 433,
      image: 'https://dkud4u09qff41.cloudfront.net/Products/f4f26678-4653-479e-8c2c-57e4d089c811.jpeg',
      sale: 310,
      location: 'Brooklyn'
  ),
  Product(
      id: "7",
      name: 'Adol 500 MG 24 Caplets',
      price: 290,
      image: "https://dkud4u09qff41.cloudfront.net/Products/3d5c6047-6346-41f6-bbda-6fcbf2ecac9e.jpeg",
      sale: 23,
      location: 'Brooklyn'
  ),
  Product(
      id: "8",
      name: 'Claritine 10 mg 20 Tablet',
      price: 1152,
      image: "https://dkud4u09qff41.cloudfront.net/Products/93a57725-e92d-4b0d-82fe-0b8cc8203c29.jpeg",
      sale: 2,
      location: 'Brooklyn'
  ),
  Product(
      id: "9",
      name: 'Strepsils Orange with Vitamin c 24 Lozenges',
      price: 866,
      image: "https://dkud4u09qff41.cloudfront.net/Products/46600ddf-270e-4870-bd99-7c76ef59f074.jpeg",
      sale: 468,
      location: 'Brooklyn'
  ),
  Product(
      id: "10",
      name: 'Doliprane 1000 mg Tablets',
      price: 173,
      image: "https://dkud4u09qff41.cloudfront.net/Products/ad8a59f1-81d3-4f64-9796-dba9a2b0ca2c.png",
      sale: 23,
      location: 'Brooklyn'
  ),
  Product(
      id: "11",
      name: 'Alphintern - 30 F.C. Tablet',
      price: 183,
      image: "https://dkud4u09qff41.cloudfront.net/Products/473e3abb-1daa-4c41-9c66-5e691d763bb5.jpeg",
      sale: 9,
      location: 'Brooklyn'
  ),
  Product(
      id: "12",
      name: 'Panadol Extra 24 tablets',
      price: 349,
      image: "https://dkud4u09qff41.cloudfront.net/Products/4bb1309e-54da-4ae2-bb2b-6778cc2600b0.jpeg",
      sale: 86,
      location: 'Brooklyn'
  ),
  Product(
      id: "13",
      name: 'Motilium 10mg 40 tablets',
      price: 11,
      image: "https://dkud4u09qff41.cloudfront.net/Products/8f9a6eb6-8462-4850-92db-d522f86ed6d5.jpeg",
      sale: 3247,
      location: 'Brooklyn'
  ),
  Product(
      id: "14",
      name: 'Aerius 5mg 20 tablets',
      price: 38,
      image: "https://dkud4u09qff41.cloudfront.net/Products/54f8c485-60da-43be-86f4-6a535bc6ef70.jpeg",
      sale: 574,
      location: 'Brooklyn'
  ),
  Product(
      id: "15",
      name: 'Xithrone 500 mg - 5 F.C. Tablet',
      price: 35,
      image: "https://dkud4u09qff41.cloudfront.net/Products/149a11f9-231b-463d-8540-4b76e83aaa94.jpeg",
      sale: 285,
      location: 'Brooklyn'
  ),
  Product(
      id: "16",
      name: 'Vitamax Plus - 20 Capsules',
      price: 220,
      image: "https://dkud4u09qff41.cloudfront.net/Products/d893f8b3-836f-4715-ae9e-517e1e72d812.jpeg",
      sale: 24,
      location: 'Brooklyn'
  ),
  Product(
      id: "17",
      name: 'Bebelac 1 Milk Powder 400 GM',
      price: 4.9,
      image: "https://dkud4u09qff41.cloudfront.net/Products/e83c5e09-d4e8-43f2-83af-e5c6325a257e.jpeg",
      sale: 751,
      location: 'Brooklyn'
  ),
  Product(
      id: "18",
      name: 'Perfectil Original - 30 Tablet',
      price: 8.6,
      image: "https://dkud4u09qff41.cloudfront.net/Products/01262d60-7599-4995-83aa-9528ac3804a7.png",
      sale: 540,
      location: 'Brooklyn'
  ),
  Product(
      id: "19",
      name: 'Omega-3 Plus - 30 Capsules',
      price: 46.6,
      image: "https://dkud4u09qff41.cloudfront.net/Products/394a9c02-d4dc-48f7-a33c-23b3d37d96ab.jpeg",
      sale: 146,
      location: 'Brooklyn'
  ),
  Product(
      id: "20",
      name: 'Limitless Man Max 30 Tablets',
      price: 333,
      image: "https://dkud4u09qff41.cloudfront.net/Products/5c77c8fc-6fad-4fc1-ac72-9437169059c6.jpeg",
      sale: 33,
      location: 'Brooklyn'
  )
];