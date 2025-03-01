class NavigationItem {

  String title;

  NavigationItem(this.title);

}

List<NavigationItem> getNavigationItemList(){
  return <NavigationItem>[
    NavigationItem("Jobs"),
    NavigationItem("Applications"),
  ];
}

class Application {

  String position;
  String company;
  String status;
  String price;
  String logo;

  Application(this.position, this.company, this.status, this.price, this.logo);

}

List<Application> getApplications(){
  return <Application>[
    Application("Cleaning", "amrita desai", "Delivered", "200", "assets/images/icon-of-a-person-cleaning.png"),
    Application("Construction", "nimesh natil", "Opened", "300", "assets/images/download.png"),
    Application("Delivery", "murgesh patil", "Cancelled", "230", "assets/images/uber.png"),
    Application("Gardening", "pandit prashant", "Closed", "250", "assets/images/cartoon-gardener-logo-18260910.png"),
    Application("Electrician", "adil shah", "Not selected", "390","assets/images/optimal-electrical-logo.png"),
  ];
}

class Job {

  String position;
  String company;
  String price;
  String concept;
  String logo;
  String city;

  Job(this.position, this.company, this.price, this.concept, this.logo, this.city);

}

List<Job> getJobs(){
  return <Job>[
    Job("Cleaning", "", "200", "Full-Time", "assets/images/icon-of-a-person-cleaning.png", "Alandi,Pune"),
    Job("Construction", "", "300", "Part-Time", "assets/images/download.png", "Mundhwa , Pune"),
    Job("Delivery", "", "230", "Full-Time", "assets/images/uber.png", "Ambegaon, Pune"),
    Job("Gardening", "", "250", "Part-Time", "assets/images/cartoon-gardener-logo-18260910.png", "Bibwewadi, Pune"),
    Job("Electrician", "", "390", "Full-Time", "assets/images/optimal-electrical-logo.png", "Katraj, Pune"),
  ];
}

List<String> getJobsRequirements(){
  return <String>[
    " Stamina and Strength",
    "Attention to Safety",
    "Basic Technical Skills with tools and equipment",
    "Reliability and Punctuality",
  ];
}