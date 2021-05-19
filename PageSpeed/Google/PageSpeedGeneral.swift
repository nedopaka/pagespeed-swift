//
//  PageSpeedGeneral.swift
//  PageSpeed
//
//  Created by Alex on 3/28/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

enum PageSpeedResult {
    case mobile
    case desktop
}

enum PageSpeedColor: String {
    case green = "#0cce6b"
    case greenSecondary = "#018642"
    case orange = "#ffa400"
    case orangeSecondary = "#d04900"
    case red = "#ff4e42"
    case redSecondary = "#eb0f00"
}

enum PageSpeedCategory: String {
    case FAST
    case AVERAGE
    case SLOW
    case NODATA = """
    Field Data:
    The Chrome User Experience Report does not have sufficient real-world speed data for this page.
    """
}

enum PageSpeedLabData: CaseIterable {
    case fcp
    case fmp
    case speedIndex
    case firstCPUIdle
    case timeToInteractive
    case maxPotentialFirstInputDelay
}

// swiftlint:disable line_length
let labDataInfo = [
    PageSpeedLabData.fcp: (
        title: "First Contentful Paint",
        description: "First Contentful Paint marks the time at which the first text or image is painted. [Learn more](https://web.dev/first-contentful-paint)."
    ),
    PageSpeedLabData.fmp: (
        title: "First Meaningful Paint",
        description: "First Meaningful Paint measures when the primary content of a page is visible. [Learn more](https://web.dev/first-meaningful-paint)."
    ),
    PageSpeedLabData.speedIndex: (
        title: "Speed Index",
        description: "Speed Index shows how quickly the contents of a page are visibly populated. [Learn more](https://web.dev/speed-index)."
    ),
    PageSpeedLabData.firstCPUIdle: (
        title: "First CPU Idle",
        description: "First CPU Idle marks the first time at which the page's main thread is quiet enough to handle input.  [Learn more](https://web.dev/first-cpu-idle)."
    ),
    PageSpeedLabData.timeToInteractive: (
        title: "Time to Interactive",
        description: "Time to interactive is the amount of time it takes for the page to become fully interactive. [Learn more](https://web.dev/interactive)."
    ),
    PageSpeedLabData.maxPotentialFirstInputDelay: (
        title: "Max Potential First Input Delay",
        description: "The maximum potential First Input Delay that your users could experience is the duration, in milliseconds, of the longest task. [Learn more](https://developers.google.com/web/updates/2018/05/first-input-delay)."
    )
]
// swiftlint:enable line_length
