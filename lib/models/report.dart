class Report {
    final int? status;
    final ReportItems? reportItems;

    Report({
        this.status,
        this.reportItems,
    });

    factory Report.fromMap(Map<String, dynamic> json) => Report(
        status: json["status"],
        reportItems: json["items"] == null ? null : ReportItems.fromMap(json["items"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "items": reportItems?.toMap(),
    };
}

class ReportItems {
    final Reports? reports;
    final List<Type>? types;

    ReportItems({
        this.reports,
        this.types,
    });

    factory ReportItems.fromMap(Map<String, dynamic> json) => ReportItems(
        reports: json["reports"] == null ? null : Reports.fromMap(json["reports"]),
        types: json["types"] == null ? [] : List<Type>.from(json["types"]!.map((x) => Type.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "reports": reports?.toMap(),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x.toMap())),
    };
}

class Reports {
    final int? currentPage;
    final List<dynamic>? data;
    final String? firstPageUrl;
    final dynamic from;
    final int? lastPage;
    final String? lastPageUrl;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final dynamic to;
    final int? total;
    final String? url;

    Reports({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
        this.url,
    });

    factory Reports.fromMap(Map<String, dynamic> json) => Reports(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
        "url": url,
    };
}

class Type {
    final int? id;
    final String? title;

    Type({
        this.id,
        this.title,
    });

    factory Type.fromMap(Map<String, dynamic> json) => Type(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
    };
}