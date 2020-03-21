//
//  GTMertixStructs.swift
//  PageSpeed
//
//  Created by Ilya on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import RealmSwift

struct GTMetrixTestResponse: Decodable {
    var creditsLeft: Int
    var testID: String
    var pollStateURL: String
    enum CodingKeys: String, CodingKey {
        case creditsLeft = "credits_left"
        case testID = "test_id"
        case pollStateURL = "poll_state_url"
    }
}

// MARK: - GTMetrixTestResult
struct GTMetrixTestResult: Decodable {
    var reportURL: String?
    var pageSpeedScore: Int?
    var yslowScore: Int?
    var htmlBytes: Int?
    var htmlLoadTime: Int?
    var pageBytes: Int?
    var pageLoadTime: Int?
    var pageElements: Int?
    var redirectDuration: Int?
    var connectDuration: Int?
    var backendDuration: Int?
    var firstPaintTime: Int?
    var firstContentfulPaintTime: Int?
    var domInteractiveTime: Int?
    var domContentLoadedTime: Int?
    var domContentLoadedDuration: Int?
    var onloadTime: Int?
    var onloadDuration: Int?
    var fullyLoadedTime: Int?
    var rumSpeedIndex: Int?

    enum CodingKeys: String, CodingKey {
        case reportURL = "report_url"
        case pageSpeedScore = "pagespeed_score"
        case yslowScore = "yslow_score"
        case htmlBytes = "html_bytes"
        case htmlLoadTime = "html_load_time"
        case pageBytes = "page_bytes"
        case pageLoadTime = "page_load_time"
        case pageElements = "page_elements"
        case redirectDuration = "redirect_duration"
        case connectDuration = "connect_duration"
        case backendDuration = "backend_duration"
        case firstPaintTime = "first_paint_time"
        case firstContentfulPaintTime = "first_contentful_paint_time"
        case domInteractiveTime = "dom_interactive_time"
        case domContentLoadedTime = "dom_content_loaded_time"
        case domContentLoadedDuration = "dom_content_loaded_duration"
        case onloadTime = "onload_time"
        case onloadDuration = "onload_duration"
        case fullyLoadedTime = "fully_loaded_time"
        case rumSpeedIndex = "rum_speed_index"
    }
}

enum TestState: String {
    case queued, started, completed, error
}

// MARK: - GTMetrixResponse
struct GTMetrixResponse: Decodable {
    var url: String?
    var id: String?
    var state: String
    var error: String
    var results: GTMetrixTestResult?
    var resources: GTMetrixResource?
    var date: Date?
}

// MARK: - GTMetrixResource
struct GTMetrixResource: Decodable {
    var screenshot: String?
    var har: String?
    var pagespeed: String?
    var pagespeedFiles: String?
    var yslow: String?
    var reportPDF: String?
    var reportPDFFull: String?
    var video: String?
    var filmstrip: String?

    enum CodingKeys: String, CodingKey {
        case screenshot = "screenshot"
        case har = "har"
        case pagespeed = "pagespeed"
        case pagespeedFiles = "pagespeed_files"
        case yslow = "yslow"
        case reportPDF = "report_pdf"
        case reportPDFFull = "report_pdf_full"
        case video = "video"
        case filmstrip = "filmstrip"
    }
}
