import '../../../../../utils/images.dart';

class LatestMovie {
  String? image;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? duration;
  String? rating;
  String? language;
  String? review;

  LatestMovie({
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

List<LatestMovie> getLatestMovieList() {
  List<LatestMovie> tempBranchList = [];

  tempBranchList.add(
    LatestMovie(
        image: latestMovie1,
        title: "Avengers : infinity War",
        subtitle: "Hollywood Movie",
        description:
            "Iron Man, Thor, the Hulk and the rest of the Avengers unite to battle their most powerful enemy yet -- the evil Thanos. On a mission to collect all six Infinity Stones, Thanos plans to use the artifacts to inflict his twisted will on reality. The fate of the planet and existence itself has never been more uncertain as everything the Avengers have fought for has led up to this moment.",
        type: "comedy",
        duration: "2h 30m ",
        rating: " 9.0/10",
        language: "English, Hindi",
        review: "4.5"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie2,
        title: "Doctor Strange",
        subtitle: "Hollywood Movie",
        description:
            "Stephen Strange, a wealthy, acclaimed, and arrogant neurosurgeon, severely injures his hands in a car crash while en route to a speaking conference, leaving him permanently unable to operate. Fellow surgeon Christine Palmer tries to help him move on, but Strange vainly pursues experimental surgeries to heal his hands.",
        type: "comedy",
        duration: "2h 30m",
        rating: " 9.7/10",
        language: "English",
        review: "4.0"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie3,
        title: "Jumanji",
        subtitle: "Hollywood Movie",
        description:
            "Welcome to the Jungle ​runs off of the theme of life, and how you choose to live it. In the movie, all of the teenagers' decisions are faced with major consequences, as they determine whether or not to enter dangerous situations, to leave the game, or continue the tasks they are given.",
        type: "comedy",
        duration: "2h 30m",
        rating: " 9.6/10",
        language: "English, Hindi",
        review: "4.2"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie4,
        title: "Pathaan",
        subtitle: "Bollywood Movie",
        description:
            "It revolves around Pathaan (Khan), an ex-armyman turned undercover agent who gets caught on a mission. He has now returned to save his country from a former R&AW agent Jim (Abraham) who has turned rogue after he was wronged by his own people. The film introduces its characters with solid back stories.",
        type: "comedy",
        duration: "3h 00",
        rating: " 9.5/10",
        language: "English, Hindi",
        review: "5.0"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie5,
        title: "3 Idiots",
        subtitle: "Hollywood Movie",
        description:
            "The movie challenges the idea that success is measured by grades, degrees, and job titles. It suggests that success should be defined by one's personal goals and happiness. Don't let fear hold you back: The movie teaches us that we should not let fear hold us back from pursuing our dreams.",
        type: "comedy ",
        duration: "3h 30m",
        rating: "9.4/10",
        language: "English, Hindi",
        review: "4.0"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie6,
        title: "Pyaar ka Punchan..",
        subtitle: "Hollywood Movie",
        description: "Nishant starts dating Charu while his roommates Rajat and Vikrant already have girlfriends in Neha and Rhea respectively. Trouble starts when the guys feel that their girlfriends are dominating them.",
        type: "comedy",
        duration: "2h 30m",
        rating: " 9.3/10",
        language: "English, Hindi",
        review: "4.8"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie7,
        title: "Khatta Meetha",
        subtitle: "Hollywood Movie",
        description: "Sachin Tichkule is an ambitious contractor who faces opposition from everyone, both at home and at work. But he continues to struggle while his family members continue to pocket ill-gained money.",
        type: "comedy",
        duration: "2h 20m",
        rating: " 9.2/10",
        language: "English, Hindi",
        review: "3.5"),
  );

  tempBranchList.add(
    LatestMovie(
        image: latestMovie8,
        title: "Satyaprem Ki Katha",
        subtitle: "Hollywood Movie",
        description:
            "the film introduces viewers to the life of Sattu, a jovial but jobless young man dreaming of marital bliss. His world changes when he meets Katha, a beautiful girl from an affluent family. Sattu first meets Katha at a garba celebration, where she performs a dance number.",
        type: "comedy",
        duration: "3h 25m",
        rating: " 9.1/10",
        language: "English, Hindi",
        review: "4.2"),
  );

  return tempBranchList;
}
