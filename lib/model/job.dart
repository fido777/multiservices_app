class Job {
  String jobId;
  String clientId;
  String profession;
  String state;
  String date;
  double paymentOffer;
  String resume;
  String description;
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
    required this.description,
    required this.city,
    required this.neighborhood,
    required this.address,
  });

  // Método fromJson para crear un objeto Job desde un mapa JSON
  Job.fromJson(Map<String, dynamic> json)
      : jobId = json['idTrabajo'],
        clientId = json['idCliente'],
        profession = json['clase'],
        state = json['estado'],
        date = json['fecha'],
        paymentOffer = json['ofertaDePago'],
        resume = json['resumen'],
        description = json['descripcion'],
        city = json['ciudad'],
        neighborhood = json['barrio'],
        address = json['direccion']
        ;

  // Método toJson para convertir un objeto Job a un mapa JSON
  Map<String, dynamic> toJson() => {
        'idTrabajo': jobId,
        'idCliente': clientId,
        'clase': profession,
        'estado': state,
        'fecha': date,
        'ofertaDePago': paymentOffer,
        'resumen': resume,
        'descripcion': description,
        'ciudad': city,
        'barrio': neighborhood,
        'direccion': address,
      };
}
