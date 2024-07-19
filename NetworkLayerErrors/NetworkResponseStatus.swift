//
//  NetworkResponseStatus.swift
//  NetworkLayerErrors
//
//  Created by Mohammad Razipour on 7/19/24.
//

import Foundation

enum NetworkResponseStatus: Error, Equatable {
    
    static func == (lhs: NetworkResponseStatus, rhs: NetworkResponseStatus) -> Bool {
        return lhs.code == rhs.code
    }
    
    case internalStatus(status: InternalStatus, message: String? = nil)
    case informational(status: InformationalStatus, message: String?)
    case success(status: SuccessStatus, message: String?)
    case redirection(status: RedirectionStatus, message: String?)
    case clientError(status: ClientErrorStatus, message: String?)
    case serverError(status: ServerErrorStatus, message: String?)
    case nsurlError(status: NSURLError, message: String?)
    
    init(statusCode: Int?, message: String? = nil) {
        guard let code = statusCode else {
            self = .internalStatus(status: .internetAccessError, message: message)
            return
        }
        
        if let status = InformationalStatus(rawValue: code) {
            self = .informational(status: status, message: message)
            return
        }
        
        if let status = SuccessStatus(rawValue: code) {
            self = .success(status: status, message: message)
            return
        }
        
        if let status = RedirectionStatus(rawValue: code) {
            self = .redirection(status: status, message: message)
            return
        }
        
        if let status = ClientErrorStatus(rawValue: code) {
            self = .clientError(status: status, message: message)
            return
        }
        
        if let status = ServerErrorStatus(rawValue: code) {
            self = .serverError(status: status, message: message)
            return
        }
        
        if let status = NSURLError(rawValue: code) {
            self = .nsurlError(status: status, message: message)
            return
        }
        
        self = .internalStatus(status: .unknown, message: message)
    }
    
    var description: String {
        switch self {
        case .internalStatus(let status, let message):
            return "Internal Status: \(status), \(message ?? "")"
        case .informational(let status, let message):
            return "Informational Status: \(status), \(message ?? "")"
        case .success(let status, let message):
            return "Success Status: \(status), \(message ?? "")"
        case .redirection(let status, let message):
            return "Redirection Status: \(status), \(message ?? "")"
        case .clientError(let status, let message):
            return "Client Error Status: \(status), \(message ?? "")"
        case .serverError(let status, let message):
            return "Server Error Status: \(status), \(message ?? "")"
        case .nsurlError(let status, let message):
            return "NSURLError Status: \(status), \(message ?? "")"
        }
    }
    
    var code: Int {
        switch self {
        case .internalStatus(let status, _):
            return status.code
        case .informational(let status, _):
            return status.code
        case .success(let status, _):
            return status.code
        case .redirection(let status, _):
            return status.code
        case .clientError(let status, _):
            return status.code
        case .serverError(let status, _):
            return status.code
        case .nsurlError(let status, _):
            return status.code
        }
    }
}


enum NSURLError: Int, Error {
    case unknown = -1
    case cancelled = -999
    case badURL = -1000
    case timedOut = -1001
    case unsupportedURL = -1002
    case cannotFindHost = -1003
    case cannotConnectToHost = -1004
    case connectionLost = -1005
    case lookupFailed = -1006
    case HTTPTooManyRedirects = -1007
    case resourceUnavailable = -1008
    case notConnectedToInternet = -1009
    case redirectToNonExistentLocation = -1010
    case badServerResponse = -1011
    case userCancelledAuthentication = -1012
    case userAuthenticationRequired = -1013
    case zeroByteResource = -1014
    case cannotDecodeRawData = -1015
    case cannotDecodeContentData = -1016
    case cannotParseResponse = -1017
    case NSURLErrorAppTransportSecurityRequiresSecureConnection = -1022
    case fileDoesNotExist = -1100
    case fileIsDirectory = -1101
    case noPermissionsToReadFile = -1102
    case NSURLErrorDataLengthExceedsMaximum = -1103
    case secureConnectionFailed = -1200
    case serverCertificateHasBadDate = -1201
    case serverCertificateUntrusted = -1202
    case serverCertificateHasUnknownRoot = -1203
    case serverCertificateNotYetValid = -1204
    case clientCertificateRejected = -1205
    case clientCertificateRequired = -1206
    case cannotLoadFromNetwork = -2000
    case cannotCreateFile = -3000
    case cannotOpenFile = -3001
    case cannotCloseFile = -3002
    case cannotWriteToFile = -3003
    case cannotRemoveFile = -3004
    case cannotMoveFile = -3005
    case downloadDecodingFailedMidStream = -3006
    case downloadDecodingFailedToComplete = -3007
    case NSURLErrorInternationalRoamingOff = -1018
    case NSURLErrorCallIsActive = -1019
    case NSURLErrorDataNotAllowed = -1020
    case NSURLErrorRequestBodyStreamExhausted = -1021
    case NSURLErrorBackgroundSessionRequiresSharedContainer = -995
    case NSURLErrorBackgroundSessionInUseByAnotherProcess = -996
    case NSURLErrorBackgroundSessionWasDisconnected = -997
    
    var description: String { return "\(self)" }
    var code: Int { return self.rawValue }
}

/// 1xx Informational
enum InformationalStatus: Int, Error {
    case continueStatus = 100
    case switchingProtocols = 101
    case processing = 102
    
    var description: String { return "" }
    var code: Int { return self.rawValue }
}

/// 2xx Success
enum SuccessStatus: Int, Error {
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case iMUsed = 226
    
    var description: String { return "\(self)" }
    var code: Int { return self.rawValue }
}

/// 3xx Redirection
enum RedirectionStatus: Int, Error {
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case unused = 306
    case temporaryRedirect = 307
    case permanentRedirect = 308
    
    var description: String { return "\(self)" }
    var code: Int { return self.rawValue }
}

/// 4xx Client Error
enum ClientErrorStatus: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case iAmReapot = 418
    case enhanceYourCalm = 420
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case reservedForWebDAV = 425
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case noResponse = 444
    case retryWith = 449
    case blockedbyWindowsParentalControls = 450
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
    
    var description: String { return "\(self)" }
    var code: Int { return self.rawValue }
}

/// 5xx Server Error
enum ServerErrorStatus: Int, Error {
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case bandwidthLimitExceeded = 509
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case networkReadTimeoutError = 598
    case networkConnectTimeoutError = 599
    
    var description: String { return "\(self)" }
    var code: Int { return self.rawValue }
}

/// Internal Status
enum InternalStatus: Int, Error {
    case internetAccessError = 1
    case unknown = 2
    case invalidUrl = 3
    case noData = 4
    case unableToDecode = 5
    case noPermission = 6
    
    var description: String { return "\(self)" }
    
    var code: Int { return self.rawValue }
}
