class Job {
  String jobId;
  String clientId;
  String profession;
  String state;
  String date;
  double paymentOffer;
  String resume;
  String shortDescription;
  String city;
  String neighborhood;
  String address;

  Job({
    required this.jobId,
    required this.clientId,
    required this.profession,
    required this.state,
    required this.date,
    required this.paymentOffer,
    required this.resume,
    required this.shortDescription,
    required this.city,
    required this.neighborhood,
    required this.address,
  });

  // Create fromJson method using named constructor
  Job.fromJson(Map<String, dynamic> json)
      : jobId = json['jobId'],
        clientId = json['clientId'],
        profession = json['profession'],
        state = json['state'],
        date = json['date'],
        paymentOffer = json['paymentOffer'].toDouble(),
        resume = json['resume'],
        shortDescription = json['shortDescription'],
        city = json['city'],
        neighborhood = json['neighborhood'],
        address = json['address'];

  Map<String, dynamic> toJson() => {
        'jobId': jobId,
        'clientId': clientId,
        'profession': profession,
        'state': state,
        'date': date,
        'paymentOffer': paymentOffer,
        'resume': resume,
        'shortDescription': shortDescription,
        'city': city,
        'neighborhood': neighborhood,
        'address': address,
      };
}
