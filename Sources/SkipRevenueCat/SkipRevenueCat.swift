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

/// Customer info stub for SKIP_BRIDGE mode
public struct CustomerInfo {
    public var isPremium: Bool = false
    public var entitlements: [String: EntitlementInfo] = [:]

    public init(isPremium: Bool = false) {
        self.isPremium = isPremium
    }
}

public struct EntitlementInfo {
    public var isActive: Bool = false
}

public struct Offerings {}
public struct StoreProduct {}
public struct StoreTransaction {}
public struct PurchasesError: Error {
    public var message: String = ""
    public var underlyingErrorMessage: String? = nil
}

public enum LogLevel {
    case debug, error, info, verbose, warn
    public static var DEBUG: LogLevel { .debug }
    public static var ERROR: LogLevel { .error }
    public static var INFO: LogLevel { .info }
    public static var VERBOSE: LogLevel { .verbose }
    public static var WARN: LogLevel { .warn }
}

public protocol PurchasesDelegate: AnyObject {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo)
}

/// RevenueCat stub for Skip Fuse native mode
/// Note: For full Android support, handle RevenueCat in your transpiled Kotlin layer
public class Purchases {
    public static var sharedInstance: Purchases = Purchases()
    public static var logLevel: LogLevel = .debug

    public weak var delegate: PurchasesDelegate?

    public static func configure(apiKey: String, builder: @escaping (PurchasesConfiguration.Builder) -> Void = {_ in }) {
        // Stub - implement in Kotlin layer for Android
        print("RevenueCat configure called (SKIP_BRIDGE stub)")
    }

    public func getOfferings(onError: @escaping (PurchasesError) -> Void, onSuccess: @escaping (Offerings) -> Void) {
        // Stub - implement in Kotlin layer for Android
        onSuccess(Offerings())
    }

    public func restorePurchases(onError: @escaping (PurchasesError) -> Void, onSuccess: @escaping (CustomerInfo) -> Void) {
        // Stub - implement in Kotlin layer for Android
        onSuccess(CustomerInfo())
    }
}

public struct PurchasesConfiguration {
    public struct Builder {
        public init() {}
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
