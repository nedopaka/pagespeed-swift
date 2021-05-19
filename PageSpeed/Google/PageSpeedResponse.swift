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
    // horizontal charts FCP, FID
    let loadingExperience: LoadingExperience
    // horizontal charts FCP, FID origin
    let originLoadingExperience: LoadingExperience?
    // overall scores, details
    let lighthouseResult: LighthouseResult
    let analysisUTCTimestamp: String

    enum CodingKeys: String, CodingKey {
        case captchaResult = "captchaResult"
        case kind = "kind"
        case id = "id"
        case loadingExperience = "loadingExperience"
        case originLoadingExperience = "originLoadingExperience"
        case lighthouseResult = "lighthouseResult"
        case analysisUTCTimestamp = "analysisUTCTimestamp"
    }
}

// MARK: - PageSpeedError
struct PageSpeedError: Codable {
    let error: ProcessingError

    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}

struct ProcessingError: Codable {
    let code: Int
    let message: String
}

// MARK: - =========== LoadingExperience JSON ===========

// MARK: - LoadingExperience
struct LoadingExperience: Codable {
    let id: String?
    // horizontal charts FCP, FID
    let metrics: LoadingExperienceMetrics?
    let overallCategory: String?
    let initialURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case metrics = "metrics"
        case overallCategory = "overall_category"
        case initialURL = "initial_url"
    }
}

// MARK: - LoadingExperienceMetrics
struct LoadingExperienceMetrics: Codable {
    // horizontal charts FCP, FID
    let firstContentfulPaintMS: FirstMS
    let firstInputDelayMS: FirstMS

    enum CodingKeys: String, CodingKey {
        case firstContentfulPaintMS = "FIRST_CONTENTFUL_PAINT_MS"
        case firstInputDelayMS = "FIRST_INPUT_DELAY_MS"
    }
}

// MARK: - FirstMS
struct FirstMS: Codable {
    // horizontal charts FCP, FID - overall time in ms
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
    // horizontal charts FCP, FID
    let proportion: Double

    enum CodingKeys: String, CodingKey {
        case min = "min"
        case max = "max"
        case proportion = "proportion"
    }
}

// MARK: - =========== LighthouseResult JSON ===========

// MARK: - LighthouseResult
struct LighthouseResult: Codable {
    let requestedURL: String
    let finalURL: String
    let lighthouseVersion: String
    let userAgent: String
    let fetchTime: String
    let environment: Environment
    let runWarnings: [JSONAny]
    let configSettings: ConfigSettings
    // Time to Interactive (interactive), FCP, FMP, Speed Index, First CPU Idle, max-potential-fid
    let audits: Audits
    let categories: Categories
    let categoryGroups: CategoryGroups
    let timing: Timing
    let i18N: I18N

    enum CodingKeys: String, CodingKey {
        case requestedURL = "requestedUrl"
        case finalURL = "finalUrl"
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

// MARK: - Environment
struct Environment: Codable {
    let networkUserAgent: String
    let hostUserAgent: String
    let benchmarkIndex: Double

    enum CodingKeys: String, CodingKey {
        case networkUserAgent = "networkUserAgent"
        case hostUserAgent = "hostUserAgent"
        case benchmarkIndex = "benchmarkIndex"
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

// MARK: - Categories
struct Categories: Codable {
    // overall score
    let performance: Performance

    enum CodingKeys: String, CodingKey {
        case performance = "performance"
    }
}

// MARK: - CategoryGroups
struct CategoryGroups: Codable {
    let a11YLanguage: CategoryGroupsItem
    let a11YTablesLists: CategoryGroupsItem
    let a11YNamesLabels: CategoryGroupsItem
    let budgets: CategoryGroupsItem
    let metrics: CategoryGroupsItem
    let loadOpportunities: CategoryGroupsItem
    let pwaInstallable: CategoryGroupsItem
    let seoMobile: CategoryGroupsItem
    let diagnostics: CategoryGroupsItem
    let a11YBestPractices: CategoryGroupsItem
    let seoCrawl: CategoryGroupsItem
    let a11YColorContrast: CategoryGroupsItem
    let pwaOptimized: CategoryGroupsItem
    let seoContent: CategoryGroupsItem
    let a11YNavigation: CategoryGroupsItem
    let pwaFastReliable: CategoryGroupsItem
    let a11YAria: CategoryGroupsItem
    let a11YAudioVideo: CategoryGroupsItem

    enum CodingKeys: String, CodingKey {
        case a11YLanguage = "a11y-language"
        case a11YTablesLists = "a11y-tables-lists"
        case a11YNamesLabels = "a11y-names-labels"
        case budgets = "budgets"
        case metrics = "metrics"
        case loadOpportunities = "load-opportunities"
        case pwaInstallable = "pwa-installable"
        case seoMobile = "seo-mobile"
        case diagnostics = "diagnostics"
        case a11YBestPractices = "a11y-best-practices"
        case seoCrawl = "seo-crawl"
        case a11YColorContrast = "a11y-color-contrast"
        case pwaOptimized = "pwa-optimized"
        case seoContent = "seo-content"
        case a11YNavigation = "a11y-navigation"
        case pwaFastReliable = "pwa-fast-reliable"
        case a11YAria = "a11y-aria"
        case a11YAudioVideo = "a11y-audio-video"
    }
}

// MARK: - CategoryGroupsItem
struct CategoryGroupsItem: Codable {
    let title: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
}

// MARK: - Timing
struct Timing: Codable {
    let total: Double

    enum CodingKeys: String, CodingKey {
        case total = "total"
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

// MARK: - =========== Audits JSON ===========

// MARK: - Audits
struct Audits: Codable {
    let unminifiedJavascript: BootupTime
    let redirects: DOMSize
    let userTimings: BootupTime
    // first-meaningful-paint
    let firstMeaningfulPaint: PerformanceScore
    // resource-summary statistic
    let resourceSummary: PerformanceScore
    let finalScreenshot: FinalScreenshot
    let efficientAnimatedContent: EfficientAnimatedContent
    let metrics: EfficientAnimatedContent
    let timeToFirstByte: DOMSize
    let renderBlockingResources: DOMSize
    let usesTextCompression: EfficientAnimatedContent
    let usesOptimizedImages: EfficientAnimatedContent
    let networkRequests: CriticalRequestChains
    let usesLongCacheTTL: BootupTime
    // max-potential-fid
    let maxPotentialFid: EfficientAnimatedContent
    // Time to Interactive
    let interactive: DOMSize
    // screenshot-thumbnails
    let screenshotThumbnails: Diagnostics
    // third-party-summary
    let thirdPartySummary: PerformanceScore
    let networkRtt: PerformanceScore
    let mainThreadTasks: DOMSize
    let fontDisplay: PerformanceScore
    let totalBlockingTime: DOMSize
    // estimated-input-latency
    let estimatedInputLatency: BootupTime
    let firstContentfulPaint3G: CriticalRequestChains?
    let usesRelPreconnect: EfficientAnimatedContent
    let unminifiedCSS: DOMSize
    let bootupTime: BootupTime
    let offscreenImages: DOMSize
    let networkServerLatency: PerformanceScore
    let usesResponsiveImages: EfficientAnimatedContent
    let unusedCSSRules: BootupTime
    // speed-index
    let speedIndex: PerformanceScore
    // first-cpu-idle
    let firstCPUIdle: PerformanceScore // CriticalRequestChains
    let totalByteWeight: DOMSize
    let mainthreadWorkBreakdown: BootupTime
    // first-contentful-paint
    let firstContentfulPaint: PerformanceScore // CriticalRequestChains
    let usesWebpImages: EfficientAnimatedContent
    let diagnostics: Diagnostics
    let criticalRequestChains: CriticalRequestChains
    let domSize: DOMSize
    let usesRelPreload: EfficientAnimatedContent
    let performanceBudget: Diagnostics

    enum CodingKeys: String, CodingKey {
        case unminifiedJavascript = "unminified-javascript"
        case redirects = "redirects"
        case userTimings = "user-timings"
        case firstMeaningfulPaint = "first-meaningful-paint"
        case resourceSummary = "resource-summary"
        case finalScreenshot = "final-screenshot"
        case efficientAnimatedContent = "efficient-animated-content"
        case metrics = "metrics"
        case timeToFirstByte = "server-response-time"
        case renderBlockingResources = "render-blocking-resources"
        case usesTextCompression = "uses-text-compression"
        case usesOptimizedImages = "uses-optimized-images"
        case networkRequests = "network-requests"
        case usesLongCacheTTL = "uses-long-cache-ttl"
        case maxPotentialFid = "max-potential-fid"
        case interactive = "interactive"
        case screenshotThumbnails = "screenshot-thumbnails"
        case thirdPartySummary = "third-party-summary"
        case networkRtt = "network-rtt"
        case mainThreadTasks = "main-thread-tasks"
        case fontDisplay = "font-display"
        case totalBlockingTime = "total-blocking-time"
        case estimatedInputLatency = "estimated-input-latency"
        case firstContentfulPaint3G = "first-contentful-paint-3g"
        case usesRelPreconnect = "uses-rel-preconnect"
        case unminifiedCSS = "unminified-css"
        case bootupTime = "bootup-time"
        case offscreenImages = "offscreen-images"
        case networkServerLatency = "network-server-latency"
        case usesResponsiveImages = "uses-responsive-images"
        case unusedCSSRules = "unused-css-rules"
        case speedIndex = "speed-index"
        case firstCPUIdle = "first-cpu-idle"
        case totalByteWeight = "total-byte-weight"
        case mainthreadWorkBreakdown = "mainthread-work-breakdown"
        case firstContentfulPaint = "first-contentful-paint"
        case usesWebpImages = "uses-webp-images"
        case diagnostics = "diagnostics"
        case criticalRequestChains = "critical-request-chains"
        case domSize = "dom-size"
        case usesRelPreload = "uses-rel-preload"
        case performanceBudget = "performance-budget"
    }
}

// MARK: - BootupTime
struct BootupTime: Codable {
    let id: String
    let title: String
    let description: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: BootupTimeDetails?
    let numericValue: Double?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case displayValue = "displayValue"
        case details = "details"
        case numericValue = "numericValue"
        case warnings = "warnings"
    }
}

enum ScoreDisplayMode: String, Codable {
    case binary = "binary"
    case informative = "informative"
    case numeric = "numeric"
    case manual = "manual"
    case notApplicable = "notApplicable"
}

// MARK: - BootupTimeDetails
struct BootupTimeDetails: Codable {
    let summary: Summary?
    let headings: [BootupTimeDetailsHeading]
    let type: String
    let items: [BootupTimeDetailsItem]
    let overallSavingsMS: Int?
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case headings = "headings"
        case type = "type"
        case items = "items"
        case overallSavingsMS = "overallSavingsMs"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - BootupTimeDetailsHeading
struct BootupTimeDetailsHeading: Codable {
    let itemType: String?
    let key: String
    let text: String?
    let granularity: Double?
    let valueType: ValueType?
    let label: Label?
    let displayUnit: String?

    enum CodingKeys: String, CodingKey {
        case itemType = "itemType"
        case key = "key"
        case text = "text"
        case granularity = "granularity"
        case valueType = "valueType"
        case label = "label"
        case displayUnit = "displayUnit"
    }
}

enum Label: String, Codable {
    case potentialSavings = "Potential Savings"
    case size = "Size"
    case timeSpent = "Time Spent"
    case url = "URL"
}

enum ValueType: String, Codable {
    case bytes = "bytes"
    case thumbnail = "thumbnail"
    case timespanMS = "timespanMs"
    case url = "url"
}

// MARK: - BootupTimeDetailsItem
struct BootupTimeDetailsItem: Codable {
    let url: String?
    let total: Double?
    let scripting: Double?
    let scriptParseCompile: Double?
    let group: String?
    let duration: Double?
    let groupLabel: String?
    let totalBytes: Int?
    let wastedBytes: Double?
    let wastedPercent: Double?
    let cacheHitProbability: Double?
    let cacheLifetimeMS: Int?
    let debugData: DebugData?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case total = "total"
        case scripting = "scripting"
        case scriptParseCompile = "scriptParseCompile"
        case group = "group"
        case duration = "duration"
        case groupLabel = "groupLabel"
        case totalBytes = "totalBytes"
        case wastedBytes = "wastedBytes"
        case wastedPercent = "wastedPercent"
        case cacheHitProbability = "cacheHitProbability"
        case cacheLifetimeMS = "cacheLifetimeMs"
        case debugData = "debugData"
    }
}

// MARK: - DebugData
struct DebugData: Codable {
    let type: TypeEnum
    let maxAge: Int
    let debugDataPublic: Bool?
    let staleWhileRevalidate: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case maxAge = "max-age"
        case debugDataPublic = "public"
        case staleWhileRevalidate = "stale-while-revalidate"
    }
}

enum TypeEnum: String, Codable {
    case debugdata = "debugdata"
}

// MARK: - Summary
struct Summary: Codable {
    let wastedMS: Double?
    let wastedBytes: WastedBytes?

    enum CodingKeys: String, CodingKey {
        case wastedMS = "wastedMs"
        case wastedBytes = "wastedBytes"
    }
}

enum WastedBytes: Codable {
    case double(Double)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(WastedBytes.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WastedBytes"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CriticalRequestChains
struct CriticalRequestChains: Codable {
    let id: String
    let title: String
    let description: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: CriticalRequestChainsDetails?
    let numericValue: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case displayValue = "displayValue"
        case details = "details"
        case numericValue = "numericValue"
    }
}

// MARK: - CriticalRequestChainsDetails
struct CriticalRequestChainsDetails: Codable {
    //let chains: Chains?
    let longestChain: LongestChain?
    let type: String
    let headings: [CriticalRequestChainsDetailsHeading]?
    let items: [CriticalRequestChainsDetailsItem]?

    enum CodingKeys: String, CodingKey {
        //case chains = "chains"
        case longestChain = "longestChain"
        case type = "type"
        case headings = "headings"
        case items = "items"
    }
}

// MARK: - Chains
struct Chains: Codable {
    let the21117: The21117
    let ff79Ccb42945C4Ffcdfadcc920188Bc2: Ff79Ccb42945C4Ffcdfadcc920188Bc2

    enum CodingKeys: String, CodingKey {
        case the21117 = "21.117"
        case ff79Ccb42945C4Ffcdfadcc920188Bc2 = "FF79CCB42945C4FFCDFADCC920188BC2"
    }
}

// MARK: - Ff79Ccb42945C4Ffcdfadcc920188Bc2
struct Ff79Ccb42945C4Ffcdfadcc920188Bc2: Codable {
    let children: Children
    let request: Request

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case request = "request"
    }
}

// MARK: - Children
struct Children: Codable {
    let ff79CCB42945C4FFCDFADCC920188BC2Redirect: FF79CCB42945C4FFCDFADCC920188BC2Redirect

    enum CodingKeys: String, CodingKey {
        case ff79CCB42945C4FFCDFADCC920188BC2Redirect = "FF79CCB42945C4FFCDFADCC920188BC2:redirect"
    }
}

// MARK: - FF79CCB42945C4FFCDFADCC920188BC2Redirect
struct FF79CCB42945C4FFCDFADCC920188BC2Redirect: Codable {
    let children: [String: The21117]
    let request: Request

    enum CodingKeys: String, CodingKey {
        case children = "children"
        case request = "request"
    }
}

// MARK: - The21117
struct The21117: Codable {
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

// MARK: - CriticalRequestChainsDetailsHeading
struct CriticalRequestChainsDetailsHeading: Codable {
    let itemType: String
    let key: String
    let text: String
    let granularity: Double?
    let displayUnit: String?

    enum CodingKeys: String, CodingKey {
        case itemType = "itemType"
        case key = "key"
        case text = "text"
        case granularity = "granularity"
        case displayUnit = "displayUnit"
    }
}

// MARK: - CriticalRequestChainsDetailsItem
struct CriticalRequestChainsDetailsItem: Codable {
    let mimeType: String?
    let resourceSize: Int
    let endTime: Double? // should be checked
    let startTime: Double
    let transferSize: Int
    let url: String
    let statusCode: Int
    let resourceType: ResourceType?

    enum CodingKeys: String, CodingKey {
        case mimeType = "mimeType"
        case resourceSize = "resourceSize"
        case endTime = "endTime"
        case startTime = "startTime"
        case transferSize = "transferSize"
        case url = "url"
        case statusCode = "statusCode"
        case resourceType = "resourceType"
    }
}

enum ResourceType: String, Codable {
    case document = "Document"
    case fetch = "Fetch"
    case font = "Font"
    case image = "Image"
    case media = "Media"
    case script = "Script"
    case stylesheet = "Stylesheet"
    case xhr = "XHR"
    case other = "Other"
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

// MARK: - Diagnostics
struct Diagnostics: Codable {
    let id: String
    let title: String
    let description: String
    let score: JSONNull?
    let scoreDisplayMode: ScoreDisplayMode
    let details: DiagnosticsDetails?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
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
    let numStylesheets: Int?
    let throughput: Double?
    let numTasksOver100MS: Int?
    let numTasksOver25MS: Int?
    let numTasksOver50MS: Int?
    let numRequests: Int?
    let totalTaskTime: Double?
    let mainDocumentTransferSize: Int?
    let totalByteWeight: Int?
    let numTasks: Int?
    let numTasksOver10MS: Int?
    let rtt: Double?
    let numFonts: Int?
    let maxRtt: Double?
    let numTasksOver500MS: Int?
    let maxServerLatency: JSONNull?
    let numScripts: Int?
    let timing: Int?
    let timestamp: Double?
    let data: String?

    enum CodingKeys: String, CodingKey {
        case numStylesheets = "numStylesheets"
        case throughput = "throughput"
        case numTasksOver100MS = "numTasksOver100ms"
        case numTasksOver25MS = "numTasksOver25ms"
        case numTasksOver50MS = "numTasksOver50ms"
        case numRequests = "numRequests"
        case totalTaskTime = "totalTaskTime"
        case mainDocumentTransferSize = "mainDocumentTransferSize"
        case totalByteWeight = "totalByteWeight"
        case numTasks = "numTasks"
        case numTasksOver10MS = "numTasksOver10ms"
        case rtt = "rtt"
        case numFonts = "numFonts"
        case maxRtt = "maxRtt"
        case numTasksOver500MS = "numTasksOver500ms"
        case maxServerLatency = "maxServerLatency"
        case numScripts = "numScripts"
        case timing = "timing"
        case timestamp = "timestamp"
        case data = "data"
    }
}

// MARK: - DOMSize
struct DOMSize: Codable {
    let id: String
    let title: String
    let description: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let displayValue: String?
    let details: PurpleDetails?
    let numericValue: Double
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
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
    let headings: [TentacledHeading]
    let type: String
    let items: [StickyItem]
    let overallSavingsMS: Double?
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case headings = "headings"
        case type = "type"
        case items = "items"
        case overallSavingsMS = "overallSavingsMs"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - TentacledHeading
struct TentacledHeading: Codable {
    let text: String?
    let key: String
    let itemType: String?
    let granularity: Double?
    let valueType: ValueType?
    let label: Label?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case key = "key"
        case itemType = "itemType"
        case granularity = "granularity"
        case valueType = "valueType"
        case label = "label"
    }
}

// MARK: - StickyItem
struct StickyItem: Codable {
    let value: String?
    let statistic: String?
    let element: Element?
    let startTime: Double?
    let duration: Double?
    let wastedPercent: Double?
    let url: String?
    let requestStartTime: Double?
    let totalBytes: Int?
    let wastedBytes: Int?
    let wastedMS: Int?

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case statistic = "statistic"
        case element = "element"
        case startTime = "startTime"
        case duration = "duration"
        case wastedPercent = "wastedPercent"
        case url = "url"
        case requestStartTime = "requestStartTime"
        case totalBytes = "totalBytes"
        case wastedBytes = "wastedBytes"
        case wastedMS = "wastedMs"
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
    let description: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let details: EfficientAnimatedContentDetails?
    let numericValue: Double
    // max-potential-fid
    let displayValue: String?
    let warnings: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
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
    let overallSavingsMS: Int?
    let headings: [StickyHeading]?
    let type: String
    let items: [IndigoItem]
    let overallSavingsBytes: Int?

    enum CodingKeys: String, CodingKey {
        case overallSavingsMS = "overallSavingsMs"
        case headings = "headings"
        case type = "type"
        case items = "items"
        case overallSavingsBytes = "overallSavingsBytes"
    }
}

// MARK: - StickyHeading
struct StickyHeading: Codable {
    let valueType: ValueType
    let key: Key
    let label: Label?

    enum CodingKeys: String, CodingKey {
        case valueType = "valueType"
        case key = "key"
        case label = "label"
    }
}

enum Key: String, Codable {
    case totalBytes = "totalBytes"
    case url = "url"
    case wastedBytes = "wastedBytes"
    case wastedMS = "wastedMs"
}

// MARK: - IndigoItem
struct IndigoItem: Codable {
    let speedIndex: Int?
    let observedSpeedIndexTs: Int?
    let observedFirstContentfulPaint: Int?
    let observedNavigationStartTs: Int?
    let observedLargestContentfulPaintTs: Int?
    let observedFirstVisualChange: Int?
    let observedLoadTs: Int?
    let firstMeaningfulPaint: Int?
    let observedTraceEnd: Int?
    let observedFirstMeaningfulPaint: Int?
    let observedTraceEndTs: Int?
    let firstCPUIdle: Int?
    let observedFirstMeaningfulPaintTs: Int?
    let observedDOMContentLoaded: Int?
    let interactive: Int?
    let observedFirstVisualChangeTs: Int?
    let observedNavigationStart: Int?
    let observedFirstContentfulPaintTs: Int?
    let observedLoad: Int?
    let observedLastVisualChangeTs: Int?
    let observedLargestContentfulPaint: Int?
    let observedDOMContentLoadedTs: Int?
    let observedSpeedIndex: Int?
    let estimatedInputLatency: Int?
    let totalBlockingTime: Int?
    let observedFirstPaint: Int?
    let observedLastVisualChange: Int?
    let firstContentfulPaint: Int?
    let observedFirstPaintTs: Int?
    let lcpInvalidated: Bool?
    let url: String?
    let totalBytes: Int?
    let wastedBytes: Int?
    let fromProtocol: Bool?
    let isCrossOrigin: Bool?

    enum CodingKeys: String, CodingKey {
        case speedIndex = "speedIndex"
        case observedSpeedIndexTs = "observedSpeedIndexTs"
        case observedFirstContentfulPaint = "observedFirstContentfulPaint"
        case observedNavigationStartTs = "observedNavigationStartTs"
        case observedLargestContentfulPaintTs = "observedLargestContentfulPaintTs"
        case observedFirstVisualChange = "observedFirstVisualChange"
        case observedLoadTs = "observedLoadTs"
        case firstMeaningfulPaint = "firstMeaningfulPaint"
        case observedTraceEnd = "observedTraceEnd"
        case observedFirstMeaningfulPaint = "observedFirstMeaningfulPaint"
        case observedTraceEndTs = "observedTraceEndTs"
        case firstCPUIdle = "firstCPUIdle"
        case observedFirstMeaningfulPaintTs = "observedFirstMeaningfulPaintTs"
        case observedDOMContentLoaded = "observedDomContentLoaded"
        case interactive = "interactive"
        case observedFirstVisualChangeTs = "observedFirstVisualChangeTs"
        case observedNavigationStart = "observedNavigationStart"
        case observedFirstContentfulPaintTs = "observedFirstContentfulPaintTs"
        case observedLoad = "observedLoad"
        case observedLastVisualChangeTs = "observedLastVisualChangeTs"
        case observedLargestContentfulPaint = "observedLargestContentfulPaint"
        case observedDOMContentLoadedTs = "observedDomContentLoadedTs"
        case observedSpeedIndex = "observedSpeedIndex"
        case estimatedInputLatency = "estimatedInputLatency"
        case totalBlockingTime = "totalBlockingTime"
        case observedFirstPaint = "observedFirstPaint"
        case observedLastVisualChange = "observedLastVisualChange"
        case firstContentfulPaint = "firstContentfulPaint"
        case observedFirstPaintTs = "observedFirstPaintTs"
        case lcpInvalidated = "lcpInvalidated"
        case url = "url"
        case totalBytes = "totalBytes"
        case wastedBytes = "wastedBytes"
        case fromProtocol = "fromProtocol"
        case isCrossOrigin = "isCrossOrigin"
    }
}

// MARK: - FinalScreenshot
struct FinalScreenshot: Codable {
    let id: String
    let title: String
    let description: String
    let score: JSONNull?
    let scoreDisplayMode: ScoreDisplayMode
    let details: FinalScreenshotDetails

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case details = "details"
    }
}

// MARK: - FinalScreenshotDetails
struct FinalScreenshotDetails: Codable {
    let type: String?
    let timing: Int
    let timestamp: Int
    let data: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case timing = "timing"
        case timestamp = "timestamp"
        case data = "data"
    }
}

// MARK: - PerformanceScore
struct PerformanceScore: Codable {
    let id: String
    let title: String
    let description: String
    let score: Double?
    let scoreDisplayMode: ScoreDisplayMode
    let details: FontDisplayDetails?
    let warnings: [JSONAny]?
    let displayValue: String?
    let numericValue: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case score = "score"
        case scoreDisplayMode = "scoreDisplayMode"
        case details = "details"
        case warnings = "warnings"
        case displayValue = "displayValue"
        case numericValue = "numericValue"
    }
}

// MARK: - FontDisplayDetails
struct FontDisplayDetails: Codable {
    let headings: [CriticalRequestChainsDetailsHeading]
    let items: [IndecentItem]
    let type: String
    let summary: Summary?

    enum CodingKeys: String, CodingKey {
        case headings = "headings"
        case items = "items"
        case type = "type"
        case summary = "summary"
    }
}

// MARK: - IndecentItem
struct IndecentItem: Codable {
    let wastedMS: Double?
    let url: String?
    let resourceType: String?
    let label: String?
    let size: Int?
    let requestCount: Int?
    let blockingTime: Double?
    let entity: Entity?
    let mainThreadTime: Double?
    let transferSize: Int?

    enum CodingKeys: String, CodingKey {
        case wastedMS = "wastedMs"
        case url = "url"
        case resourceType = "resourceType"
        case label = "label"
        case size = "size"
        case requestCount = "requestCount"
        case blockingTime = "blockingTime"
        case entity = "entity"
        case mainThreadTime = "mainThreadTime"
        case transferSize = "transferSize"
    }
}

// MARK: - Entity
struct Entity: Codable {
    let url: String?
    let type: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case type = "type"
        case text = "text"
    }
}

// MARK: - Performance
struct Performance: Codable {
    let id: String
    let title: String
    // overall score - main score
    // 0 to 49 (slow): Red
    // 50 to 89 (average): Orange
    // 90 to 100 (fast): Green
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
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
