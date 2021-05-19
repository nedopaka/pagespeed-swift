//
//  PageSpeedDataModel.swift
//  PageSpeed
//
//  Created by Alex on 3/13/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class PageSpeedV5Item: Object {
    dynamic var id = UUID().uuidString

    dynamic var url: String = ""
    dynamic var strategy: String = ""
    dynamic var performanceScore: Double = 0
    dynamic var overallCategory: String?
    dynamic var metrics: PageSpeedV5Metrics?
    dynamic var labData: PageSpeedV5LabData?
    dynamic var finalScreenshot: String = ""
    dynamic var analysisUTCTimestamp: String = ""

    convenience init(response: PageSpeedResponse) {
        self.init()

        self.url = response.id
        self.strategy = response.lighthouseResult.configSettings.emulatedFormFactor
        self.performanceScore = response.lighthouseResult.categories.performance.score

        self.overallCategory = response.loadingExperience.overallCategory

        let metrics = response.loadingExperience.metrics
        let audits = response.lighthouseResult.audits

        if let metrics = metrics {
            self.metrics = PageSpeedV5Metrics(metrics: metrics)
        }
        self.labData = PageSpeedV5LabData(audits: audits)

        self.finalScreenshot = response.lighthouseResult.audits.finalScreenshot.details.data
        self.analysisUTCTimestamp = response.analysisUTCTimestamp
    }

    override static func primaryKey() -> String? {
        "id"
    }
}

@objcMembers class PageSpeedV5Metrics: Object {
    dynamic var id = UUID().uuidString
    // FCP
    dynamic var percentileFCP: Int = 0
    dynamic var fastProportionFCP: Double = 0
    dynamic var averageProportionFCP: Double = 0
    dynamic var slowProportionFCP: Double = 0
    dynamic var categoryFCP: String = ""
    // FID
    dynamic var percentileFID: Int = 0
    dynamic var fastProportionFID: Double = 0
    dynamic var averageProportionFID: Double = 0
    dynamic var slowProportionFID: Double = 0
    dynamic var categoryFID: String = ""

    let testEntity = LinkingObjects(fromType: PageSpeedV5Item.self, property: "metrics")

    convenience init(metrics: LoadingExperienceMetrics) {
        self.init()

        // FCP
        self.percentileFCP = metrics.firstContentfulPaintMS.percentile
        self.fastProportionFCP = metrics.firstContentfulPaintMS.distributions[0].proportion
        self.averageProportionFCP = metrics.firstContentfulPaintMS.distributions[1].proportion
        self.slowProportionFCP = metrics.firstContentfulPaintMS.distributions[2].proportion
        self.categoryFCP = metrics.firstContentfulPaintMS.category

        // FID
        self.percentileFID = metrics.firstInputDelayMS.percentile
        self.fastProportionFID = metrics.firstInputDelayMS.distributions[0].proportion
        self.averageProportionFID = metrics.firstInputDelayMS.distributions[1].proportion
        self.slowProportionFID = metrics.firstInputDelayMS.distributions[2].proportion
        self.categoryFID = metrics.firstInputDelayMS.category
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

@objcMembers class PageSpeedV5LabData: Object {
    dynamic var id = UUID().uuidString

    dynamic var displayValueFCP: String?
    let scoreFCP = RealmOptional<Double>()

    dynamic var displayValueFMP: String?
    let scoreFMP = RealmOptional<Double>()

    dynamic var displayValueSpeedIndex: String?
    let scoreSpeedIndex = RealmOptional<Double>()

    dynamic var displayValueFirstCPUIdle: String?
    let scoreFirstCPUIdle = RealmOptional<Double>()

    dynamic var displayValueInteractive: String?
    let scoreInteractive = RealmOptional<Double>()

    dynamic var displayValueMaxPotentialFID: String?
    let scoreMaxPotentialFID = RealmOptional<Double>()

    let testEntity = LinkingObjects(fromType: PageSpeedV5Item.self, property: "labData")

    convenience init(audits: Audits) {
        self.init()

        self.displayValueFCP = audits.firstContentfulPaint.displayValue
        self.scoreFCP.value = audits.firstContentfulPaint.score

        self.displayValueFMP = audits.firstMeaningfulPaint.displayValue
        self.scoreFMP.value = audits.firstMeaningfulPaint.score

        self.displayValueSpeedIndex = audits.speedIndex.displayValue
        self.scoreSpeedIndex.value = audits.speedIndex.score

        self.displayValueFirstCPUIdle = audits.firstCPUIdle.displayValue
        self.scoreFirstCPUIdle.value = audits.firstCPUIdle.score

        self.displayValueInteractive = audits.interactive.displayValue
        self.scoreInteractive.value = audits.interactive.score

        self.displayValueMaxPotentialFID = audits.maxPotentialFid.displayValue
        self.scoreMaxPotentialFID.value = audits.maxPotentialFid.score
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

@objcMembers class LabDataInfo: Object {
    dynamic var id: String?
    dynamic var title: String = ""
    dynamic var descriptionMD: String = ""

    override class func primaryKey() -> String? {
        "id"
    }
}
