import '../../../../../utils/images.dart';

class FavouriteMovie {
  String? image;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? duration;
  String? rating;
  String? language;
  String? review;

  FavouriteMovie({
    this.image,
    this.title,
    this.subtitle,
    this.description,
    this.type,
    this.duration,
    this.rating,
    this.language,
    this.review,
  });
}

List<FavouriteMovie> getFavourItemMovieList() {
  List<FavouriteMovie> tempBranchList = [];

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie1,
        title: "De De Pyar De",
        subtitle: "Bollywood movie",
        description:
            "When Ashish falls in love with Ayesha, a woman almost half his age, he introduces her to his ex-wife and children. However, their unacceptance threatens to ruin their relationship. The first schedule will be extensively shot in Mumbai where two grand sets have been created, followed by shooting schedules in London and Punjab",
        type: "comedy",
        duration: "2h 00m",
        rating: "8.7/10",
        language: "English, Hindi",
        review: "4.5"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie2,
        title: "Sultan",
        subtitle: "Bollywood movie",
        description:
            "During the final match, Sultan overcomes his pain to defeat his opponent and ultimately wins the tournament. Reunited with his wife, Sultan opens a blood bank using the prize money and Aarfa resumes wrestling. A few years later, she gives birth to a baby girl, whom Sultan begins to train as a wrestler. After the death of his son, Sultan Ali Khan, a middle-aged wrestler, gives up the sport. Years later, he sets out to revive his career as he needs the prize money and wants to regain his lost respect.",
        type: "comedy",
        duration: "1h 00m ",
        rating: "8.6/10",
        language: "English",
        review: "4.0"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie3,
        title: "Fast & Furious7",
        subtitle: "Hollywood movie",
        description:
            "After defeating international terrorist Owen Shaw, Dominic Toretto (Vin Diesel), Brian O'Conner (Paul Walker) and the rest of the crew have separated to return to more normal lives. However, Deckard Shaw (Jason Statham), Owen's older brother, is thirsty for revenge. A slick government agent offers to help Dom and company take care of Shaw in exchange for their help in rescuing a kidnapped computer hacker who has developed a powerful surveillance program.",
        type: "comedy",
        duration: "2h 00m ",
        rating: "8.0/10",
        language: "English",
        review: "4.0"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie4,
        title: "Hindi Medium",
        subtitle: "Bollywood movie",
        description:
            "'Hindi Medium' is about the struggle of parents who go to extreme lengths to get their daughter the best in education. Zeenat Lakhani & Saket Chaudhary's Screenplay intelligently treats a serious social-message, with genuinely funny humor. Raj and Mita Batra yearn to get Pia, their daughter, educated from a posh school. When they learn that their background is holding her back, they are willing to go to any lengths to change her fate.",
        type: "comedy",
        duration: "3h 00m ",
        rating: "8.5/10",
        language: "English, Hindi",
        review: "4.2"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie5,
        title: "Jurassic World",
        subtitle: "Hollywood movie",
        description:
            "The Jurassic World theme park lets guests experience the thrill of witnessing actual dinosaurs, but something ferocious lurks behind the park's attractions—a genetically hybridized dinosaur with savage capabilities. When the massive creature escapes, chaos erupts across the island and working theme park. Located off the coast of Costa Rica, the Jurassic World luxury resort provides a habitat for an array of genetically engineered dinosaurs, including the vicious and intelligent Indominus rex. When the massive creature escapes, it sets off a chain reaction that causes the other dinos to run amok.",
        type: "comedy",
        duration: "4h 00m ",
        rating: "8.4/10",
        language: "English, Hindi",
        review: "5.0"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie6,
        title: "Spider Man",
        subtitle: "Hollywood movie",
        description:
            " Peter Parker's secret identity is revealed to the entire world. Desperate for help, Peter turns to Doctor Strange to make the world forget that he is Spider-Man. The spell goes horribly wrong and shatters the multiverse, bringing in monstrous villains that could destroy the world.American teenager Peter Parker, a poor sickly orphan, is bitten by a radioactive spider. As a result of the bite, he gains superhuman strength, speed, and agility, along with the ability to cling to walls, turning him into Spider-Man.",
        type: "comedy",
        duration: "5h 00m",
        rating: "8.3/10",
        language: "English, Hindi",
        review: "4.0"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie7,
        title: "Sita Ramam",
        subtitle: "Hollywood movie",
        description:
            "Set in 1964, it tells the story of Lieutenant Ram, an orphaned army officer serving at the Kashmir border, gets anonymous love letters from Sita Mahalakshmi, after which Ram is on a mission to find Sita and propose his love. The principal photography commenced in April 2021 and ended in April 2022 with filming taking place in Hyderabad, Kashmir and Russia. The film's music was composed by Vishal Chandrasekhar with cinematography by P. S. Vinod and Shreyaas Krishna.",
        type: "comedy",
        duration: "6h 00m",
        rating: "8.2/10",
        language: "English, Hindi",
        review: "3.5"),
  );

  tempBranchList.add(
    FavouriteMovie(
        image: favMovie8,
        title: "Bawaal",
        subtitle: "Bollywood movie",
        description:
            "Ajay Dixit is an image-conscious narcissist, who teaches history at a school in Lucknow. He hates his life of lies, despite the respect he is held in, thanks to his philosophical tendency to fake it till you make it. He has grounded his beautiful epileptic wife Nisha, who is much more intelligent than him, since he does not want her seizures to ruin his reputation.",
        type: "comedy",
        duration: "7h 00m ",
        rating: "8.1/10",
        language: "English, Hindi",
        review: "4.2"),
  );

  return tempBranchList;
}
