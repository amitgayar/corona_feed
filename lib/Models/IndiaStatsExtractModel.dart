class IndiaStatsExtractModel {
  List<RawData> rawData;

  IndiaStatsExtractModel({this.rawData});

  IndiaStatsExtractModel.fromJson(Map<String, dynamic> json) {
    if (json['raw_data'] != null) {
      rawData = new List<RawData>();
      json['raw_data'].forEach((v) {
        rawData.add(new RawData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rawData != null) {
      data['raw_data'] = this.rawData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RawData {
  String agebracket;
  String backupnotes;
  String contractedfromwhichpatientsuspected;
  String currentstatus;
  String dateannounced;
  String detectedcity;
  String detecteddistrict;
  String detectedstate;
  String estimatedonsetdate;
  String gender;
  String nationality;
  String notes;
  String patientnumber;
  String source1;
  String source2;
  String source3;
  String statecode;
  String statepatientnumber;
  String statuschangedate;
  String typeoftransmission;

  RawData(
      {this.agebracket,
        this.backupnotes,
        this.contractedfromwhichpatientsuspected,
        this.currentstatus,
        this.dateannounced,
        this.detectedcity,
        this.detecteddistrict,
        this.detectedstate,
        this.estimatedonsetdate,
        this.gender,
        this.nationality,
        this.notes,
        this.patientnumber,
        this.source1,
        this.source2,
        this.source3,
        this.statecode,
        this.statepatientnumber,
        this.statuschangedate,
        this.typeoftransmission});

  RawData.fromJson(Map<String, dynamic> json) {
    agebracket = json['agebracket'];
    backupnotes = json['backupnotes'];
    contractedfromwhichpatientsuspected =
    json['contractedfromwhichpatientsuspected'];
    currentstatus = json['currentstatus'];
    dateannounced = json['dateannounced'];
    detectedcity = json['detectedcity'];
    detecteddistrict = json['detecteddistrict'];
    detectedstate = json['detectedstate'];
    estimatedonsetdate = json['estimatedonsetdate'];
    gender = json['gender'];
    nationality = json['nationality'];
    notes = json['notes'];
    patientnumber = json['patientnumber'];
    source1 = json['source1'];
    source2 = json['source2'];
    source3 = json['source3'];
    statecode = json['statecode'];
    statepatientnumber = json['statepatientnumber'];
    statuschangedate = json['statuschangedate'];
    typeoftransmission = json['typeoftransmission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agebracket'] = this.agebracket;
    data['backupnotes'] = this.backupnotes;
    data['contractedfromwhichpatientsuspected'] =
        this.contractedfromwhichpatientsuspected;
    data['currentstatus'] = this.currentstatus;
    data['dateannounced'] = this.dateannounced;
    data['detectedcity'] = this.detectedcity;
    data['detecteddistrict'] = this.detecteddistrict;
    data['detectedstate'] = this.detectedstate;
    data['estimatedonsetdate'] = this.estimatedonsetdate;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['notes'] = this.notes;
    data['patientnumber'] = this.patientnumber;
    data['source1'] = this.source1;
    data['source2'] = this.source2;
    data['source3'] = this.source3;
    data['statecode'] = this.statecode;
    data['statepatientnumber'] = this.statepatientnumber;
    data['statuschangedate'] = this.statuschangedate;
    data['typeoftransmission'] = this.typeoftransmission;
    return data;
  }
}
