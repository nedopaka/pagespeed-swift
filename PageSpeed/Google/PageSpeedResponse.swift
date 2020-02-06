//
//  PageSpeedResponse.swift
//  PageSpeed
//
//  Created by Alex on 2/4/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

// MARK: - PageSpeedResponse
struct PageSpeedResponse: Codable {
    let captchaResult: String
    let kind: String
    let id: String
    let loadingExperience: LoadingExperience
    let originLoadingExperience: LoadingExperience
    let lighthouseResult: LighthouseResult
    let analysisUtcTimestamp: String

    enum CodingKeys: String, CodingKey {
        case captchaResult = "captchaResult"
        case kind = "kind"
        case id = "id"
        case loadingExperience = "loadingExperience"
        case originLoadingExperience = "originLoadingExperience"
        case lighthouseResult = "lighthouseResult"
        case analysisUtcTimestamp = "analysisUTCTimestamp"
    }
}

// MARK: - LighthouseResult
struct LighthouseResult: Codable {
    let requestedUrl: String
    let finalUrl: String
    let lighthouseVersion: String
    let userAgent: String
    let fetchTime: String
    let environment: Environment
    let runWarnings: [JSONAny]
    let configSettings: ConfigSettings
    let audits: Audits
    let categories: Categories
    let categoryGroups: CategoryGroups
    let timing: Timing
    let i18N: I18N

    enum CodingKeys: String, CodingKey {
        case requestedUrl = "requestedUrl"
        case finalUrl = "finalUrl"
        case lighthouseVersion = "lighthouseVersion"
        case userAgent = "userAgent"
        case fetchTime = "fetchTime"
        case environment = "environment"
        case runWarnings = "runWarnings"
        case configSettings = "configSettings"
        case audits = "audits"
        case categories = "categories"
        case categoryGroups = "categoryGroups"
        case timing = "timing"
        case i18N = "i18n"
    }
}

// MARK: - Audits
struct Audits: Codable {
    let redirects: BootupTime
    let userTimings: BootupTime
    let firstMeaningfulPaint: CriticalRequestChains
    let resourceSummary: BootupTime
    let efficientAnimatedContent: EfficientAnimatedContent
    let finalScreenshot: FinalScreenshot
    let metrics: CriticalRequestChains
    let timeToFirstByte: DOMSize
    let renderBlockingResources: BootupTime
    let usesTextCompression: DOMSize
    let usesOptimizedImages: CriticalRequestChains
    let networkRequests: DOMSize
    let usesLongCacheTtl: CriticalRequestChains
    let maxPotentialFid: CriticalRequestChains
    let interactive: DOMSize
    let screenshotThumbnails: Diagnostics
    let thirdPartySummary: BootupTime
    let networkRtt: BootupTime
    let mainThreadTasks: DOMSize
    let fontDisplay: DOMSize
    let totalBlockingTime: EfficientAnimatedContent
    let estimatedInputLatency: BootupTime
    let usesRelPreconnect: DOMSize
    let unminifiedCss: EfficientAnimatedContent
    let bootupTime: BootupTime
    let networkServerLatency: BootupTime
    let offscreenImages: BootupTime
    let usesResponsiveImages: DOMSize
    let speedIndex: BootupTime
    let unusedCssRules: BootupTime
    let firstCpuIdle: CriticalRequestChains
    let totalByteWeight: EfficientAnimatedContent
    let mainthreadWorkBreakdown: DOMSize
    let firstContentfulPaint: CriticalRequestChains
    let usesWebpImages: EfficientAnimatedContent
    let diagnostics: Diagnostics
    let criticalRequestChains: CriticalRequestChains
    let domSize: DOMSize
    let usesRelPreload: DOMSize
    let performanceBudget: Diagnostics
    let unminifiedJavascript: BootupTime

    enum CodingKeys: String, CodingKey {
        case redirects = "redirects"
        case userTimings = "user-timings"
        case firstMeaningfulPaint = "first-meaningful-paint"
        case resourceSummary = "resource-summary"
        case efficientAnimatedContent = "efficient-animated-content"
        case finalScreenshot = "final-screenshot"
        case metrics = "metrics"
        case timeToFirstByte = "time-to-first-byte"
        case renderBlockingResources = "render-blocking-resources"
        case usesTextCompression = "uses-text-compression"
        case usesOptimizedImages = "uses-optimized-images"
        case networkRequests = "network-requests"
        case usesLongCacheTtl = "uses-long-cache-ttl"
        case maxPotentialFid = "max-potential-fid"
        case interactive = "interactive"
        case screenshotThumbnails = "screenshot-thumbnails"
        case thirdPartySummary = "third-party-summary"
        case networkRtt = "network-rtt"
        case mainThreadTasks = "main-thread-tasks"
        case fontDisplay = "font-display"
        case totalBlockingTime = "total-blocking-time"
        case estimatedInputLatency = "estimated-input-latency"
        case usesRelPreconnect = "uses-rel-preconnect"
        case unminifiedCss = "unminified-css"
        case bootupTime = "bootup-time"
        case networkServerLatency = "network-server-latency"
        case offscreenImages = "offscreen-images"
        case usesResponsiveImages = "uses-responsive-images"
        case speedIndex = "speed-index"
        case unusedCssRules = "unused-css-rules"
        case firstCpuIdle = "first-cpu-idle"
        case totalByteWeight = "total-byte-weight"
        case mainthreadWorkBreakdown = "mainthread-work-breakdown"
        case firstContentfulPaint = "first-contentful-paint"
        case usesWebpImages = "uses-webp-images"
        case diagnostics = "diagnostics"
        case criticalRequestChains = "critical-request-chains"
        case domSize = "dom-size"
        case usesRelPreload = "uses-rel-preload"
        case performanceBudget = "performance-budget"
        case unminifiedJavascript = "unminified-javascript"
    }
}

// MARK: - BootupTime
struct BootupTime: Codable {
    let id: String
    let title: String
    let bootupTimeDescription: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: PurpleDetails?
    let numericValue: Double?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case bootupTimeDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case displayValue = "displayValue"
        case details = "details"
        case numericValue = "numericValue"
        case warnings = "warnings"
    }
}

// MARK: - PurpleDetails
struct PurpleDetails: Codable {
    let headings: [PurpleHeading]
    let type: TypeEnum
    let items: [PurpleItem]
    let summary: PurpleSummary?
    let overallSavingsMs: Int?
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case headings = "headings"
        case type = "type"
        case items = "items"
        case summary = "summary"
        case overallSavingsMs = "overallSavingsMs"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - PurpleHeading
struct PurpleHeading: Codable {
    let text: String?
    let key: String
    let itemType: String?
    let granularity: Double?
    let label: String?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case key = "key"
        case itemType = "itemType"
        case granularity = "granularity"
        case label = "label"
        case valueType = "valueType"
    }
}

// MARK: - PurpleItem
struct PurpleItem: Codable {
    let url: String?
    let total: Double?
    let scripting: Double?
    let scriptParseCompile: Double?
    let wastedMs: Int?
    let resourceType: String?
    let label: String?
    let size: Int?
    let requestCount: Int?
    let mainThreadTime: Double?
    let transferSize: Int?
    let blockingTime: Double?
    let entity: Entity?
    let duration: Double?
    let timingType: String?
    let startTime: Double?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case total = "total"
        case scripting = "scripting"
        case scriptParseCompile = "scriptParseCompile"
        case wastedMs = "wastedMs"
        case resourceType = "resourceType"
        case label = "label"
        case size = "size"
        case requestCount = "requestCount"
        case mainThreadTime = "mainThreadTime"
        case transferSize = "transferSize"
        case blockingTime = "blockingTime"
        case entity = "entity"
        case duration = "duration"
        case timingType = "timingType"
        case startTime = "startTime"
        case name = "name"
    }
}

// MARK: - Entity
struct Entity: Codable {
    let type: String
    let text: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case text = "text"
        case url = "url"
    }
}

// MARK: - PurpleSummary
struct PurpleSummary: Codable {
    let wastedMs: Double
    let wastedBytes: Int?

    enum CodingKeys: String, CodingKey {
        case wastedMs = "wastedMs"
        case wastedBytes = "wastedBytes"
    }
}

enum TypeEnum: String, Codable {
    case opportunity = "opportunity"
    case table = "table"
}

enum ScoreDisplayMode: String, Codable {
    case binary = "binary"
    case informative = "informative"
    case numeric = "numeric"
}

// MARK: - CriticalRequestChains
struct CriticalRequestChains: Codable {
    let id: String
    let title: String
    let criticalRequestChainsDescription: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: CriticalRequestChainsDetails?
    let numericValue: Double?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case criticalRequestChainsDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case displayValue = "displayValue"
        case details = "details"
        case numericValue = "numericValue"
        case warnings = "warnings"
    }
}

// MARK: - CriticalRequestChainsDetails
struct CriticalRequestChainsDetails: Codable {
    let chains: Chains?
    let longestChain: LongestChain?
    let type: String
    let items: [FluffyItem]?
    let summary: FluffySummary?
    let headings: [JSONAny]?
    let overallSavingsMs: Int?
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case chains = "chains"
        case longestChain = "longestChain"
        case type = "type"
        case items = "items"
        case summary = "summary"
        case headings = "headings"
        case overallSavingsMs = "overallSavingsMs"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - Chains
struct Chains: Codable {
    let the40D0A89E63C918B71228E3446894332F: The40D0A89E63C918B71228E3446894332F

    enum CodingKeys: String, CodingKey {
        case the40D0A89E63C918B71228E3446894332F = "40D0A89E63C918B71228E3446894332F"
    }
}

// MARK: - The40D0A89E63C918B71228E3446894332F
struct The40D0A89E63C918B71228E3446894332F: Codable {
    let children: Children
    let request: Request

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case request = "request"
    }
}

// MARK: - Children
struct Children: Codable {
    let the40D0A89E63C918B71228E3446894332FRedirect: The40D0A89E63C918B71228E3446894332FRedirect

    enum CodingKeys: String, CodingKey {
        case the40D0A89E63C918B71228E3446894332FRedirect = "40D0A89E63C918B71228E3446894332F:redirect"
    }
}

// MARK: - The40D0A89E63C918B71228E3446894332FRedirect
struct The40D0A89E63C918B71228E3446894332FRedirect: Codable {
    let request: Request

    enum CodingKeys: String, CodingKey {
        case request = "request"
    }
}

// MARK: - Request
struct Request: Codable {
    let url: String
    let responseReceivedTime: Double
    let endTime: Double
    let startTime: Double
    let transferSize: Int

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case responseReceivedTime = "responseReceivedTime"
        case endTime = "endTime"
        case startTime = "startTime"
        case transferSize = "transferSize"
    }
}

// MARK: - FluffyItem
struct FluffyItem: Codable {
    let observedDomContentLoadedTs: Int?
    let observedSpeedIndex: Int?
    let estimatedInputLatency: Int?
    let totalBlockingTime: Int?
    let observedFirstPaint: Int?
    let observedLastVisualChange: Int?
    let firstContentfulPaint: Int?
    let observedFirstPaintTs: Int?
    let speedIndex: Int?
    let observedSpeedIndexTs: Int?
    let observedFirstContentfulPaint: Int?
    let observedNavigationStartTs: Int?
    let observedLargestContentfulPaintTs: Int?
    let observedFirstVisualChange: Int?
    let observedLoadTs: Int?
    let firstMeaningfulPaint: Int?
    let observedFirstMeaningfulPaint: Int?
    let observedTraceEnd: Int?
    let firstCpuIdle: Int?
    let observedTraceEndTs: Int?
    let observedFirstMeaningfulPaintTs: Int?
    let observedDomContentLoaded: Int?
    let observedFirstVisualChangeTs: Int?
    let observedNavigationStart: Int?
    let interactive: Int?
    let observedFirstContentfulPaintTs: Int?
    let observedLastVisualChangeTs: Int?
    let observedLoad: Int?
    let observedLargestContentfulPaint: Int?
    let lcpInvalidated: Bool?

    enum CodingKeys: String, CodingKey {
        case observedDomContentLoadedTs = "observedDomContentLoadedTs"
        case observedSpeedIndex = "observedSpeedIndex"
        case estimatedInputLatency = "estimatedInputLatency"
        case totalBlockingTime = "totalBlockingTime"
        case observedFirstPaint = "observedFirstPaint"
        case observedLastVisualChange = "observedLastVisualChange"
        case firstContentfulPaint = "firstContentfulPaint"
        case observedFirstPaintTs = "observedFirstPaintTs"
        case speedIndex = "speedIndex"
        case observedSpeedIndexTs = "observedSpeedIndexTs"
        case observedFirstContentfulPaint = "observedFirstContentfulPaint"
        case observedNavigationStartTs = "observedNavigationStartTs"
        case observedLargestContentfulPaintTs = "observedLargestContentfulPaintTs"
        case observedFirstVisualChange = "observedFirstVisualChange"
        case observedLoadTs = "observedLoadTs"
        case firstMeaningfulPaint = "firstMeaningfulPaint"
        case observedFirstMeaningfulPaint = "observedFirstMeaningfulPaint"
        case observedTraceEnd = "observedTraceEnd"
        case firstCpuIdle = "firstCPUIdle"
        case observedTraceEndTs = "observedTraceEndTs"
        case observedFirstMeaningfulPaintTs = "observedFirstMeaningfulPaintTs"
        case observedDomContentLoaded = "observedDomContentLoaded"
        case observedFirstVisualChangeTs = "observedFirstVisualChangeTs"
        case observedNavigationStart = "observedNavigationStart"
        case interactive = "interactive"
        case observedFirstContentfulPaintTs = "observedFirstContentfulPaintTs"
        case observedLastVisualChangeTs = "observedLastVisualChangeTs"
        case observedLoad = "observedLoad"
        case observedLargestContentfulPaint = "observedLargestContentfulPaint"
        case lcpInvalidated = "lcpInvalidated"
    }
}

// MARK: - LongestChain
struct LongestChain: Codable {
    let transferSize: Int
    let duration: Double
    let length: Int

    enum CodingKeys: String, CodingKey {
        case transferSize = "transferSize"
        case duration = "duration"
        case length = "length"
    }
}

// MARK: - FluffySummary
struct FluffySummary: Codable {
    let wastedBytes: Int

    enum CodingKeys: String, CodingKey {
        case wastedBytes = "wastedBytes"
    }
}

// MARK: - Diagnostics
struct Diagnostics: Codable {
    let id: String
    let title: String
    let diagnosticsDescription: String
    let score: JSONNull?
    let scoreDisplayMode: String
    let details: DiagnosticsDetails?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case diagnosticsDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case details = "details"
    }
}

// MARK: - DiagnosticsDetails
struct DiagnosticsDetails: Codable {
    let type: String
    let items: [TentacledItem]
    let scale: Int?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case items = "items"
        case scale = "scale"
    }
}

// MARK: - TentacledItem
struct TentacledItem: Codable {
    let numTasks: Int?
    let numTasksOver10Ms: Int?
    let rtt: Double?
    let numFonts: Int?
    let maxRtt: Double?
    let numTasksOver500Ms: Int?
    let numScripts: Int?
    let maxServerLatency: JSONNull?
    let numStylesheets: Int?
    let numTasksOver100Ms: Int?
    let throughput: Double?
    let numTasksOver25Ms: Int?
    let numTasksOver50Ms: Int?
    let numRequests: Int?
    let totalTaskTime: Double?
    let mainDocumentTransferSize: Int?
    let totalByteWeight: Int?
    let timing: Int?
    let timestamp: Int?
    let data: String?

    enum CodingKeys: String, CodingKey {
        case numTasks = "numTasks"
        case numTasksOver10Ms = "numTasksOver10ms"
        case rtt = "rtt"
        case numFonts = "numFonts"
        case maxRtt = "maxRtt"
        case numTasksOver500Ms = "numTasksOver500ms"
        case numScripts = "numScripts"
        case maxServerLatency = "maxServerLatency"
        case numStylesheets = "numStylesheets"
        case numTasksOver100Ms = "numTasksOver100ms"
        case throughput = "throughput"
        case numTasksOver25Ms = "numTasksOver25ms"
        case numTasksOver50Ms = "numTasksOver50ms"
        case numRequests = "numRequests"
        case totalTaskTime = "totalTaskTime"
        case mainDocumentTransferSize = "mainDocumentTransferSize"
        case totalByteWeight = "totalByteWeight"
        case timing = "timing"
        case timestamp = "timestamp"
        case data = "data"
    }
}

// MARK: - DOMSize
struct DOMSize: Codable {
    let id: String
    let title: String
    let domSizeDescription: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: FluffyDetails?
    let numericValue: Double?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case domSizeDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case displayValue = "displayValue"
        case details = "details"
        case numericValue = "numericValue"
        case warnings = "warnings"
    }
}

// MARK: - FluffyDetails
struct FluffyDetails: Codable {
    let headings: [FluffyHeading]
    let type: TypeEnum
    let items: [StickyItem]
    let overallSavingsMs: Double?
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case headings = "headings"
        case type = "type"
        case items = "items"
        case overallSavingsMs = "overallSavingsMs"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - FluffyHeading
struct FluffyHeading: Codable {
    let key: String
    let itemType: String?
    let text: String?
    let granularity: Int?
    let displayUnit: String?
    let valueType: String?
    let label: String?

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case itemType = "itemType"
        case text = "text"
        case granularity = "granularity"
        case displayUnit = "displayUnit"
        case valueType = "valueType"
        case label = "label"
    }
}

// MARK: - StickyItem
struct StickyItem: Codable {
    let statistic: String?
    let value: String?
    let element: Element?
    let startTime: Double?
    let duration: Double?
    let group: String?
    let groupLabel: String?
    let mimeType: String?
    let endTime: Double?
    let resourceSize: Int?
    let transferSize: Int?
    let url: String?
    let statusCode: Int?
    let resourceType: String?
    let totalBytes: Int?
    let wastedBytes: Int?
    let wastedPercent: Double?

    enum CodingKeys: String, CodingKey {
        case statistic = "statistic"
        case value = "value"
        case element = "element"
        case startTime = "startTime"
        case duration = "duration"
        case group = "group"
        case groupLabel = "groupLabel"
        case mimeType = "mimeType"
        case endTime = "endTime"
        case resourceSize = "resourceSize"
        case transferSize = "transferSize"
        case url = "url"
        case statusCode = "statusCode"
        case resourceType = "resourceType"
        case totalBytes = "totalBytes"
        case wastedBytes = "wastedBytes"
        case wastedPercent = "wastedPercent"
    }
}

// MARK: - Element
struct Element: Codable {
    let type: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
    }
}

// MARK: - EfficientAnimatedContent
struct EfficientAnimatedContent: Codable {
    let id: String
    let title: String
    let efficientAnimatedContentDescription: String
    let score: Int
    let scoreDisplayMode: ScoreDisplayMode
    let details: EfficientAnimatedContentDetails?
    let numericValue: Int
    let displayValue: String?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case efficientAnimatedContentDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case details = "details"
        case numericValue = "numericValue"
        case displayValue = "displayValue"
        case warnings = "warnings"
    }
}

// MARK: - EfficientAnimatedContentDetails
struct EfficientAnimatedContentDetails: Codable {
    let headings: [TentacledHeading]
    let type: TypeEnum
    let items: [IndigoItem]
    let overallSavingsBytes: Int?
    let overallSavingsMs: Int?

    enum CodingKeys: String, CodingKey {
        case headings = "headings"
        case type = "type"
        case items = "items"
        case overallSavingsBytes = "overallSavingsBytes"
        case overallSavingsMs = "overallSavingsMs"
    }
}

// MARK: - TentacledHeading
struct TentacledHeading: Codable {
    let text: String
    let key: String
    let itemType: String
    let granularity: Double?
    let displayUnit: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case key = "key"
        case itemType = "itemType"
        case granularity = "granularity"
        case displayUnit = "displayUnit"
    }
}

// MARK: - IndigoItem
struct IndigoItem: Codable {
    let url: String
    let totalBytes: Int

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case totalBytes = "totalBytes"
    }
}

// MARK: - FinalScreenshot
struct FinalScreenshot: Codable {
    let id: String
    let title: String
    let finalScreenshotDescription: String
    let score: JSONNull?
    let scoreDisplayMode: ScoreDisplayMode
    let details: FinalScreenshotDetails

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case finalScreenshotDescription = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case details = "details"
    }
}

// MARK: - FinalScreenshotDetails
struct FinalScreenshotDetails: Codable {
    let timing: Int
    let timestamp: Int
    let data: String
    let type: String?

    enum CodingKeys: String, CodingKey {
        case timing = "timing"
        case timestamp = "timestamp"
        case data = "data"
        case type = "type"
    }
}

// MARK: - Categories
struct Categories: Codable {
    let performance: Performance

    enum CodingKeys: String, CodingKey {
        case performance = "performance"
    }
}

// MARK: - Performance
struct Performance: Codable {
    let id: String
    let title: String
    let score: Double
    let auditRefs: [AuditRef]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case score = "score"
        case auditRefs = "auditRefs"
    }
}

// MARK: - AuditRef
struct AuditRef: Codable {
    let id: String
    let weight: Int
    let group: Group?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case weight = "weight"
        case group = "group"
    }
}

enum Group: String, Codable {
    case budgets = "budgets"
    case diagnostics = "diagnostics"
    case loadOpportunities = "load-opportunities"
    case metrics = "metrics"
}

// MARK: - CategoryGroups
struct CategoryGroups: Codable {
    let pwaInstallable: PwaFastReliableClass
    let seoMobile: A11YAria
    let diagnostics: A11YAria
    let a11YBestPractices: A11YAria
    let seoCrawl: A11YAria
    let a11YColorContrast: A11YAria
    let seoContent: A11YAria
    let pwaOptimized: PwaFastReliableClass
    let a11YNavigation: A11YAria
    let pwaFastReliable: PwaFastReliableClass
    let a11YAria: A11YAria
    let a11YAudioVideo: A11YAria
    let a11YLanguage: A11YAria
    let a11YTablesLists: A11YAria
    let a11YNamesLabels: A11YAria
    let budgets: A11YAria
    let metrics: PwaFastReliableClass
    let loadOpportunities: A11YAria

    enum CodingKeys: String, CodingKey {
        case pwaInstallable = "pwa-installable"
        case seoMobile = "seo-mobile"
        case diagnostics = "diagnostics"
        case a11YBestPractices = "a11y-best-practices"
        case seoCrawl = "seo-crawl"
        case a11YColorContrast = "a11y-color-contrast"
        case seoContent = "seo-content"
        case pwaOptimized = "pwa-optimized"
        case a11YNavigation = "a11y-navigation"
        case pwaFastReliable = "pwa-fast-reliable"
        case a11YAria = "a11y-aria"
        case a11YAudioVideo = "a11y-audio-video"
        case a11YLanguage = "a11y-language"
        case a11YTablesLists = "a11y-tables-lists"
        case a11YNamesLabels = "a11y-names-labels"
        case budgets = "budgets"
        case metrics = "metrics"
        case loadOpportunities = "load-opportunities"
    }
}

// MARK: - A11YAria
struct A11YAria: Codable {
    let title: String
    let a11YAriaDescription: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case a11YAriaDescription = "description"
    }
}

// MARK: - PwaFastReliableClass
struct PwaFastReliableClass: Codable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}

// MARK: - ConfigSettings
struct ConfigSettings: Codable {
    let emulatedFormFactor: String
    let locale: String
    let onlyCategories: [String]
    let channel: String

    enum CodingKeys: String, CodingKey {
        case emulatedFormFactor = "emulatedFormFactor"
        case locale = "locale"
        case onlyCategories = "onlyCategories"
        case channel = "channel"
    }
}

// MARK: - Environment
struct Environment: Codable {
    let networkUserAgent: String
    let hostUserAgent: String
    let benchmarkIndex: Int

    enum CodingKeys: String, CodingKey {
        case networkUserAgent = "networkUserAgent"
        case hostUserAgent = "hostUserAgent"
        case benchmarkIndex = "benchmarkIndex"
    }
}

// MARK: - I18N
struct I18N: Codable {
    let rendererFormattedStrings: RendererFormattedStrings

    enum CodingKeys: String, CodingKey {
        case rendererFormattedStrings = "rendererFormattedStrings"
    }
}

// MARK: - RendererFormattedStrings
struct RendererFormattedStrings: Codable {
    let varianceDisclaimer: String
    let opportunityResourceColumnLabel: String
    let opportunitySavingsColumnLabel: String
    let errorMissingAuditInfo: String
    let errorLabel: String
    let warningHeader: String
    let auditGroupExpandTooltip: String
    let passedAuditsGroupTitle: String
    let notApplicableAuditsGroupTitle: String
    let manualAuditsGroupTitle: String
    let toplevelWarningsMessage: String
    let crcLongestDurationLabel: String
    let crcInitialNavigation: String
    let lsPerformanceCategoryDescription: String
    let labDataTitle: String

    enum CodingKeys: String, CodingKey {
        case varianceDisclaimer = "varianceDisclaimer"
        case opportunityResourceColumnLabel = "opportunityResourceColumnLabel"
        case opportunitySavingsColumnLabel = "opportunitySavingsColumnLabel"
        case errorMissingAuditInfo = "errorMissingAuditInfo"
        case errorLabel = "errorLabel"
        case warningHeader = "warningHeader"
        case auditGroupExpandTooltip = "auditGroupExpandTooltip"
        case passedAuditsGroupTitle = "passedAuditsGroupTitle"
        case notApplicableAuditsGroupTitle = "notApplicableAuditsGroupTitle"
        case manualAuditsGroupTitle = "manualAuditsGroupTitle"
        case toplevelWarningsMessage = "toplevelWarningsMessage"
        case crcLongestDurationLabel = "crcLongestDurationLabel"
        case crcInitialNavigation = "crcInitialNavigation"
        case lsPerformanceCategoryDescription = "lsPerformanceCategoryDescription"
        case labDataTitle = "labDataTitle"
    }
}

// MARK: - Timing
struct Timing: Codable {
    let total: Double

    enum CodingKeys: String, CodingKey {
        case total = "total"
    }
}

// MARK: - LoadingExperience
struct LoadingExperience: Codable {
    let id: String
    let metrics: LoadingExperienceMetrics
    let overallCategory: String
    let initialUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case metrics = "metrics"
        case overallCategory = "overall_category"
        case initialUrl = "initial_url"
    }
}

// MARK: - LoadingExperienceMetrics
struct LoadingExperienceMetrics: Codable {
    let firstInputDelayMs: FirstMs
    let firstContentfulPaintMs: FirstMs

    enum CodingKeys: String, CodingKey {
        case firstInputDelayMs = "FIRST_INPUT_DELAY_MS"
        case firstContentfulPaintMs = "FIRST_CONTENTFUL_PAINT_MS"
    }
}

// MARK: - FirstMs
struct FirstMs: Codable {
    let percentile: Int
    let distributions: [Distribution]
    let category: String

    enum CodingKeys: String, CodingKey {
        case percentile = "percentile"
        case distributions = "distributions"
        case category = "category"
    }
}

// MARK: - Distribution
struct Distribution: Codable {
    let min: Int
    let max: Int?
    let proportion: Double

    enum CodingKeys: String, CodingKey {
        case min = "min"
        case max = "max"
        case proportion = "proportion"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
