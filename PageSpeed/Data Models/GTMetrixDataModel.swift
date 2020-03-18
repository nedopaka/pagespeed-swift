//
//  GTMetrixDataModel.swift
//  PageSpeed
//
//  Created by Admin on 18.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import RealmSwift

@objcMembers class GTMetrixResourceItem: Object {
    dynamic var screenshot: String?
    dynamic var har: String?
    dynamic var pagespeed: String?
    dynamic var pagespeedFiles: String?
    dynamic var yslow: String?
    dynamic var reportPDF: String?
    dynamic var reportPDFFull: String?
    dynamic var video: String?
    dynamic var filmstrip: String?

    convenience init(response: GTMetrixResource?) {
        self.init()
        guard let response = response else {
            return
        }
        screenshot = response.screenshot
        har = response.har
        pagespeed = response.pagespeed
        pagespeedFiles = response.pagespeedFiles
        yslow = response.yslow
        reportPDF = response.reportPDF
        reportPDFFull = response.reportPDFFull
        video = response.video
        filmstrip = response.filmstrip
    }
}

@objcMembers class GTMetrixTestResultItem: Object {
    dynamic var reportURL: String?
    dynamic var pageSpeedScore: Int = 0
    dynamic var yslowScore: Int = 0
    dynamic var htmlBytes: Int = 0
    dynamic var htmlLoadTime: Int = 0
    dynamic var pageBytes: Int = 0
    dynamic var pageLoadTime: Int = 0
    dynamic var pageElements: Int = 0
    dynamic var redirectDuration: Int = 0
    dynamic var connectDuration: Int = 0
    dynamic var backendDuration: Int = 0
    dynamic var firstPaintTime: Int = 0
    dynamic var firstContentfulPaintTime: Int = 0
    dynamic var domInteractiveTime: Int = 0
    dynamic var domContentLoadedTime: Int = 0
    dynamic var domContentLoadedDuration: Int = 0
    dynamic var onloadTime: Int = 0
    dynamic var onloadDuration: Int = 0
    dynamic var fullyLoadedTime: Int = 0
    dynamic var rumSpeedIndex: Int = 0

    convenience init(response: GTMetrixTestResult?) {
        self.init()
        guard let response = response else {
            return
        }
        reportURL = response.reportURL
        pageSpeedScore = response.pageSpeedScore ?? 0
        yslowScore = response.yslowScore ?? 0
        htmlBytes = response.htmlBytes ?? 0
        htmlLoadTime = response.htmlLoadTime ?? 0
        pageBytes = response.pageBytes ?? 0
        pageLoadTime = response.pageLoadTime ?? 0
        pageElements = response.pageElements ?? 0
        redirectDuration = response.redirectDuration ?? 0
        connectDuration = response.connectDuration ?? 0
        backendDuration = response.backendDuration ?? 0
        firstPaintTime = response.firstPaintTime ?? 0
        firstContentfulPaintTime = response.firstContentfulPaintTime ?? 0
        domInteractiveTime = response.domInteractiveTime ?? 0
        domContentLoadedTime = response.domContentLoadedTime ?? 0
        domContentLoadedDuration = response.domContentLoadedDuration ?? 0
        onloadTime = response.onloadTime ?? 0
        onloadDuration = response.onloadDuration ?? 0
        fullyLoadedTime = response.fullyLoadedTime ?? 0
        rumSpeedIndex = response.rumSpeedIndex ?? 0
    }
}

@objcMembers class GTMetrixResponseItem: Object {
    dynamic var url: String?
    dynamic var id: String?
    dynamic var state = ""
    dynamic var error = ""
    dynamic var results: GTMetrixTestResultItem?
    dynamic var resources: GTMetrixResourceItem?
    dynamic var date: Date?
    convenience init(response: GTMetrixResponse?) {
        self.init()
        guard let response = response else {
            return
        }
        url = response.url
        id = response.id
        state = response.state
        error = response.error
        results = GTMetrixTestResultItem(response:  response.results)
        resources = GTMetrixResourceItem(response: response.resources)
        date = response.date
    }
}
extension GTMetrixResponseItem: HistoryCellDelegate {
    var title: String {
        return url ?? "Unknown URL"
    }

    var subTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return "Date: \(formatter.string(from: date ?? Date()))"
    }

    var testType: TestType {
        return .gTMetrix
    }
}

extension DBManager {
    @discardableResult
    func save (object: Object) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
            return true
        } catch {
            print("Realm write error: \(error)")
            return false
        }
    }

    
    func getItems<T: Object>() -> Results<T>? {
        do {
            let realm = try Realm()
            let results: Results<T> = realm.objects(T.self)
            return results
        } catch {}
        return nil
    }
}
