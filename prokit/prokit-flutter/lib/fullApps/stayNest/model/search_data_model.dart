import '../utils/images.dart';

class Searchdata {
  final String id;
  final String name;
  final String location;
  final String address;
  final double rating;
  final int reviews;
  final int price;
  final String imageUrl;

  Searchdata(
    this.id,
    this.name,
    this.location,
    this.address,
    this.rating,
    this.reviews,
    this.price,
    this.imageUrl,
  );
}

List<Searchdata> searchdata() {
  List<Searchdata> searchdatas = [];
  searchdatas.add(
    Searchdata(
      '1',
      'Le Bristol Hotel',
      'Istanbul, Turkiye',
      'No:112, Sisli, Istanbul',
      4.8,
      4981,
      27,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '2',
      'Maison Souquet',
      'Paris, France',
      '10 Rue de Bruxelles, 75009 Paris',
      4.7,
      4378,
      30,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '3',
      'Le Meurice Hotel',
      'London, United Kingdom',
      '100 Piccadilly, London W1J 7NQ',
      4.6,
      3672,
      32,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '4',
      'Plaza Athenee',
      'Rome, Italia',
      'Via Veneto, Rome, RM 00187',
      4.9,
      4100,
      45,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '5',
      'Hotel Ritz Paris',
      'Paris, France',
      '15 Place Vendôme, 75001 Paris',
      5.0,
      5725,
      50,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '6',
      'Hotel Bel-Air',
      'Los Angeles, USA',
      '701 Stone Canyon Rd, Los Angeles, CA 90077',
      4.8,
      3960,
      70,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '7',
      'The Langham',
      'London, United Kingdom',
      '1C Portland Place, London W1B 1JA',
      4.7,
      2843,
      55,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '8',
      'Four Seasons Hotel',
      'New York, USA',
      '57 E 57th St, New York, NY 10022',
      4.9,
      4891,
      65,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '9',
      'The St. Regis',
      'New York, USA',
      '2 E 55th St, New York, NY 10022',
      5.0,
      3890,
      80,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '10',
      'The Peninsula',
      'Chicago, USA',
      '108 E Superior St, Chicago, IL 60611',
      4.8,
      3200,
      75,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '11',
      'The Biltmore',
      'Los Angeles, USA',
      '506 S Grand Ave, Los Angeles, CA 90071',
      4.6,
      2201,
      40,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '12',
      'Waldorf Astoria',
      'New York, USA',
      '301 Park Ave, New York, NY 10022',
      4.9,
      5500,
      90,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '13',
      'Shangri-La Hotel',
      'Paris, France',
      '10 Avenue d Iéna, 75116 Paris',
      4.7,
      4795,
      60,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '14',
      'InterContinental',
      'Sydney, Australia',
      '117 Macquarie St, Sydney, NSW 2000',
      4.5,
      3500,
      85,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '15',
      'Grand Hyatt',
      'Tokyo, Japan',
      '6-10-3 Roppongi, Minato City, Tokyo 106-0032',
      4.8,
      4600,
      95,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '16',
      'The Ritz-Carlton',
      'Hong Kong, China',
      'Central, Hong Kong',
      5.0,
      5200,
      100,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '17',
      'Mandarin Oriental',
      'Miami, USA',
      '500 Brickell Key Dr, Miami, FL 33131',
      4.7,
      3400,
      120,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '18',
      'The Dorchester',
      'London, United Kingdom',
      '53 Park Lane, London W1K 1QA',
      4.6,
      2700,
      110,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '19',
      'Conrad Tokyo',
      'Tokyo, Japan',
      '1-9-1 Higashi-Shinbashi, Minato City, Tokyo 105-7337',
      4.8,
      2100,
      95,
      roomimage1,
    ),
  );
  searchdatas.add(
    Searchdata(
      '20',
      'Rosewood Hotel',
      'Beijing, China',
      'Jinbao St, Beijing, China',
      4.9,
      2900,
      125,
      roomimage1,
    ),
  );
  return searchdatas;
}
