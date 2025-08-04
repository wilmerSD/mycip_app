class CourseModel {
    final bool? itIsExternal;
    final DateTime? createDate;
    final String? descriptionCourse;
    final DateTime? endDateCourse;
    final DateTime? endDateRegistration;
    final String? imageCourse;
    final int? modalityCourse;
    final String? nameCourse;
    final String? personId;
    final double? priceCourse;
    final DateTime? startDateCourse;
    final bool? stateCourse;
    final int? totalTimeHours;
    final DateTime? updatedDate;

    CourseModel({
        this.itIsExternal,
        this.createDate,
        this.descriptionCourse,
        this.endDateCourse,
        this.endDateRegistration,
        this.imageCourse,
        this.modalityCourse,
        this.nameCourse,
        this.personId,
        this.priceCourse,
        this.startDateCourse,
        this.stateCourse,
        this.totalTimeHours,
        this.updatedDate,
    });

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        itIsExternal: json["ItIsExternal"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        descriptionCourse: json["descriptionCourse"],
        endDateCourse: json["endDateCourse"] == null ? null : DateTime.parse(json["endDateCourse"]),
        endDateRegistration: json["endDateRegistration"] == null ? null : DateTime.parse(json["endDateRegistration"]),
        imageCourse: json["imageCourse"],
        modalityCourse: json["modalityCourse"],
        nameCourse: json["nameCourse"],
        personId: json["personId"],
        priceCourse: json["priceCourse"]?.toDouble(),
        startDateCourse: json["startDateCourse"] == null ? null : DateTime.parse(json["startDateCourse"]),
        stateCourse: json["stateCourse"],
        totalTimeHours: json["totalTimeHours"],
        updatedDate: json["updatedDate"] == null ? null : DateTime.parse(json["updatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "ItIsExternal": itIsExternal,
        "createDate": createDate?.toIso8601String(),
        "descriptionCourse": descriptionCourse,
        "endDateCourse": endDateCourse?.toIso8601String(),
        "endDateRegistration": endDateRegistration?.toIso8601String(),
        "imageCourse": imageCourse,
        "modalityCourse": modalityCourse,
        "nameCourse": nameCourse,
        "personId": personId,
        "priceCourse": priceCourse,
        "startDateCourse": startDateCourse?.toIso8601String(),
        "stateCourse": stateCourse,
        "totalTimeHours": totalTimeHours,
        "updatedDate": updatedDate?.toIso8601String(),
    };
}