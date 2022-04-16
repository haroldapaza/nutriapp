class PesoC{
  final int id;
  final int perId;
  final int peso;
  final String created;
  final String modif;
  const PesoC({
    required this.id,
    required this.perId,
    required this.peso,
    required this.created,
    required this.modif
  });

  factory PesoC.fromJson(Map<String, dynamic> json) {
    return PesoC(
      id: json['persweig_id'] as int,
      perId: json['persweig_pers_id'] as int,
      peso: json['persweig_weight'] as int,
      created: json['persweig_created'] as String,
      modif: json['persweig_modified'] as String,
      
    );
  }
}