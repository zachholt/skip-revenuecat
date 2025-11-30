// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

// Skip transpiles this to: import multi.platform.library.*

#if os(macOS)
// MacOS is not currently supported in KMP
// https://github.com/RevenueCat/purchases-kmp/tree/main?tab=readme-ov-file#requirements
@_exported import RevenueCat
@_exported import RevenueCatUI

public typealias PurchasesError = Error
public extension Purchases {
    static var sharedInstance: Purchases {
        RevenueCat.Purchases.shared
    }
}
public typealias KotlinBoolean = Bool
public typealias KotlinUnit = Void
#endif

#if os(iOS)
@_exported import SkipRevenueCatLibrary
import PurchasesHybridCommon
import PurchasesHybridCommonUI

public typealias CustomerInfo = ModelsCustomerInfo
public typealias Offerings = ModelsOfferings
public typealias StoreProduct = ModelsStoreProduct
public typealias PurchasesError = ModelsPurchasesError
public typealias StoreTransaction = ModelsStoreTransaction

public extension LogLevel {
    static var DEBUG: LogLevel {
        return .debug
    }
    static var ERROR: LogLevel {
        return .error
    }
    static var INFO: LogLevel {
        return .info
    }
    static var VERBOSE: LogLevel {
        return .verbose
    }
    static var WARN: LogLevel {
        return .warn
    }
}

public extension Purchases {
    static var isConfigured: Bool {
        Purchases.companion.isConfigured
    }
    
    static var sharedInstance: Purchases {
        Purchases.companion.sharedInstance
    }
    
    static var logLevel: LogLevel {
        get {
            Purchases.companion.logLevel
        }
        
        set {
            Purchases.companion.logLevel = newValue
        }
    }
}
#elseif SKIP
import com.revenuecat.purchases.kmp.__
// I cannot re-export packages here, so I use typealiases
public typealias Purchases = com.revenuecat.purchases.kmp.Purchases
public typealias CustomerInfo = com.revenuecat.purchases.kmp.models.CustomerInfo
public typealias Offerings = com.revenuecat.purchases.kmp.models.Offerings
public typealias StoreProduct = com.revenuecat.purchases.kmp.models.StoreProduct
public typealias PurchasesDelegate = com.revenuecat.purchases.kmp.PurchasesDelegate
public typealias PurchasesError = com.revenuecat.purchases.kmp.models.PurchasesError
public typealias StoreTransaction = com.revenuecat.purchases.kmp.models.StoreTransaction
public typealias KotlinBoolean = Bool
public typealias KotlinUnit = Unit
public typealias LogLevel = com.revenuecat.purchases.kmp.LogLevel
#elseif SKIP_BRIDGE
// Skip Fuse native mode - Swift compiled for Android
// For full Android RevenueCat support in native mode, handle RevenueCat
// initialization and calls in your app's Kotlin/transpiled code layer.
// These are stub types that allow Swift code to compile for Android.

// MARK: - Price Types

/// Price representation for SKIP_BRIDGE mode
public struct ModelsPrice {
    public var formatted: String
    public var amountMicros: Int64
    public var currencyCode: String

    public init(formatted: String = "$0.00", amountMicros: Int64 = 0, currencyCode: String = "USD") {
        self.formatted = formatted
        self.amountMicros = amountMicros
        self.currencyCode = currencyCode
    }
}

// MARK: - Store Product

/// Store product stub for SKIP_BRIDGE mode
public struct StoreProduct {
    public var productIdentifier: String
    public var title: String
    public var description: String
    public var price: ModelsPrice

    public init(productIdentifier: String = "", title: String = "", description: String = "", price: ModelsPrice = ModelsPrice()) {
        self.productIdentifier = productIdentifier
        self.title = title
        self.description = description
        self.price = price
    }
}

public typealias ModelsStoreProduct = StoreProduct

// MARK: - Package

/// Package stub for SKIP_BRIDGE mode
public struct ModelsPackage {
    public var identifier: String
    public var storeProduct: StoreProduct

    public init(identifier: String = "", storeProduct: StoreProduct = StoreProduct()) {
        self.identifier = identifier
        self.storeProduct = storeProduct
    }
}

// MARK: - Offering

/// Offering stub for SKIP_BRIDGE mode
public struct ModelsOffering {
    public var identifier: String
    public var availablePackages: [ModelsPackage]
    public var weekly: ModelsPackage?
    public var monthly: ModelsPackage?
    public var annual: ModelsPackage?
    public var lifetime: ModelsPackage?

    public init(
        identifier: String = "",
        availablePackages: [ModelsPackage] = [],
        weekly: ModelsPackage? = nil,
        monthly: ModelsPackage? = nil,
        annual: ModelsPackage? = nil,
        lifetime: ModelsPackage? = nil
    ) {
        self.identifier = identifier
        self.availablePackages = availablePackages
        self.weekly = weekly
        self.monthly = monthly
        self.annual = annual
        self.lifetime = lifetime
    }

    public func getPackage(identifier: String) -> ModelsPackage? {
        return availablePackages.first { $0.identifier == identifier }
    }
}

// MARK: - Offerings

/// Offerings stub for SKIP_BRIDGE mode
public struct Offerings {
    public var current: ModelsOffering?
    public var all: [String: ModelsOffering]

    public init(current: ModelsOffering? = nil, all: [String: ModelsOffering] = [:]) {
        self.current = current
        self.all = all
    }
}

public typealias ModelsOfferings = Offerings

// MARK: - Entitlements

/// Entitlement info stub for SKIP_BRIDGE mode
public struct EntitlementInfo {
    public var isActive: Bool
    public var identifier: String
    public var latestPurchaseDateMillis: Int64?
    public var expirationDateMillis: Int64?

    public init(
        isActive: Bool = false,
        identifier: String = "",
        latestPurchaseDateMillis: Int64? = nil,
        expirationDateMillis: Int64? = nil
    ) {
        self.isActive = isActive
        self.identifier = identifier
        self.latestPurchaseDateMillis = latestPurchaseDateMillis
        self.expirationDateMillis = expirationDateMillis
    }
}

/// Entitlements collection stub for SKIP_BRIDGE mode
/// Provides both dictionary-style subscript and get(s:) method for KMP compatibility
public struct EntitlementInfos {
    private var entitlements: [String: EntitlementInfo]

    public init(_ entitlements: [String: EntitlementInfo] = [:]) {
        self.entitlements = entitlements
    }

    /// KMP-style getter
    public func get(s key: String) -> EntitlementInfo? {
        return entitlements[key]
    }

    /// Dictionary-style subscript
    public subscript(key: String) -> EntitlementInfo? {
        return entitlements[key]
    }
}

// MARK: - Customer Info

/// Customer info stub for SKIP_BRIDGE mode
public struct CustomerInfo {
    public var isPremium: Bool
    public var entitlements: EntitlementInfos
    public var activeSubscriptions: Set<String>
    public var allPurchasedProductIdentifiers: Set<String>

    public init(
        isPremium: Bool = false,
        entitlements: EntitlementInfos = EntitlementInfos(),
        activeSubscriptions: Set<String> = [],
        allPurchasedProductIdentifiers: Set<String> = []
    ) {
        self.isPremium = isPremium
        self.entitlements = entitlements
        self.activeSubscriptions = activeSubscriptions
        self.allPurchasedProductIdentifiers = allPurchasedProductIdentifiers
    }
}

public typealias ModelsCustomerInfo = CustomerInfo

// MARK: - Transaction

/// Store transaction stub for SKIP_BRIDGE mode
public struct StoreTransaction {
    public var transactionIdentifier: String
    public var productIdentifier: String

    public init(transactionIdentifier: String = "", productIdentifier: String = "") {
        self.transactionIdentifier = transactionIdentifier
        self.productIdentifier = productIdentifier
    }
}

public typealias ModelsStoreTransaction = StoreTransaction

// MARK: - Error

/// Purchases error stub for SKIP_BRIDGE mode
public struct PurchasesError: Error {
    public var message: String
    public var underlyingErrorMessage: String?
    public var code: Int

    public init(message: String = "", underlyingErrorMessage: String? = nil, code: Int = 0) {
        self.message = message
        self.underlyingErrorMessage = underlyingErrorMessage
        self.code = code
    }
}

public typealias ModelsPurchasesError = PurchasesError

// MARK: - Log Level

public enum LogLevel {
    case debug, error, info, verbose, warn
    public static var DEBUG: LogLevel { .debug }
    public static var ERROR: LogLevel { .error }
    public static var INFO: LogLevel { .info }
    public static var VERBOSE: LogLevel { .verbose }
    public static var WARN: LogLevel { .warn }
}

// MARK: - Delegate

/// Purchases delegate protocol for SKIP_BRIDGE mode
public protocol PurchasesDelegate: AnyObject {
    func onCustomerInfoUpdated(customerInfo: CustomerInfo)
    func onPurchasePromoProduct(
        product: StoreProduct,
        startPurchase: @escaping (
            @escaping (PurchasesError, KotlinBoolean) -> KotlinUnit,
            @escaping (StoreTransaction, CustomerInfo) -> KotlinUnit
        ) -> Void
    )
}

// Default implementations
public extension PurchasesDelegate {
    func onPurchasePromoProduct(
        product: StoreProduct,
        startPurchase: @escaping (
            @escaping (PurchasesError, KotlinBoolean) -> KotlinUnit,
            @escaping (StoreTransaction, CustomerInfo) -> KotlinUnit
        ) -> Void
    ) {
        // Default no-op
    }
}

// MARK: - Purchases

/// RevenueCat stub for Skip Fuse native mode
/// Note: For full Android support, handle RevenueCat in your transpiled Kotlin layer
public class Purchases {
    public static var sharedInstance: Purchases = Purchases()
    public static var logLevel: LogLevel = .debug
    public static var isConfigured: Bool = false

    public weak var delegate: PurchasesDelegate?

    public init() {}

    public static func configure(apiKey: String, builder: @escaping (PurchasesConfiguration.Builder) -> Void = {_ in }) {
        // Stub - implement in Kotlin layer for Android
        print("RevenueCat configure called (SKIP_BRIDGE stub)")
        isConfigured = true
    }

    public func getOfferings(onError: @escaping (PurchasesError) -> Void, onSuccess: @escaping (Offerings) -> Void) {
        // Stub - implement in Kotlin layer for Android
        print("RevenueCat getOfferings called (SKIP_BRIDGE stub)")
        onSuccess(Offerings())
    }

    public func restorePurchases(onError: @escaping (PurchasesError) -> Void, onSuccess: @escaping (CustomerInfo) -> Void) {
        // Stub - implement in Kotlin layer for Android
        print("RevenueCat restorePurchases called (SKIP_BRIDGE stub)")
        onSuccess(CustomerInfo())
    }

    public func purchase(
        packageToPurchase: ModelsPackage,
        onError: @escaping (PurchasesError, Bool) -> Void,
        onSuccess: @escaping (StoreTransaction, CustomerInfo) -> Void,
        isPersonalizedPrice: Bool = false,
        oldProductId: String? = nil,
        replacementMode: String? = nil
    ) {
        // Stub - implement in Kotlin layer for Android
        print("RevenueCat purchase called (SKIP_BRIDGE stub)")
        // Simulate success for compilation - real implementation in Kotlin
        onSuccess(StoreTransaction(), CustomerInfo())
    }
}

// MARK: - Configuration

public struct PurchasesConfiguration {
    public var apiKey: String

    public struct Builder {
        public init() {}
    }

    public init(apiKey: String = "", builder: @escaping (Builder) -> Void = {_ in }) {
        self.apiKey = apiKey
    }
}

public typealias KotlinBoolean = Bool
public typealias KotlinUnit = Void
#endif

#if os(iOS) || SKIP
public extension Purchases {
    static func configure(apiKey: String, builder: @escaping (PurchasesConfiguration.Builder) -> Void = {_ in }) {
        #if !SKIP
        Purchases.companion.configure(apiKey: apiKey, builder: builder)
        #else
        Purchases.configure(PurchasesConfiguration(apiKey: apiKey, builder: builder))
        Void
        #endif
    }
}
#endif
