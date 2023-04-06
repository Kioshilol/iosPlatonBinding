
import Foundation

/// Base sale model of response which used for extended sale models and in callback of *PlatonApplePayAdapter* requests

@objc(PlatonApplePay)
public class PlatonApplePay: PlatonBaseResponseModel, PlatonSaleProtocol {
    
    @objc
    public let transDate: String
    
    @objc
    public init(action: PlatonMethodAction, result: PlatonResult, orderId: String, transId: String, transDate: String) {
        self.transDate = transDate
        
        super.init(action: action, result: result, orderId: orderId, transId: transId)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        transDate = try container.decode(type(of: transDate), forKey: .transDate)
        
        try super.init(from: decoder)
    }
    
    @objc
    private enum CodingKeys: Int, CodingKey, Decodable {
        case transDate = 1
        
        public var stringValue: String {
            switch self {
            case .transDate:
                return "trans_date"
            }
        }
    }
}

@objc(PlatonApplePaySuccess)
public class PlatonApplePaySuccess: PlatonApplePay, PlatonStatusProtocol {
    
    @objc
    public let descriptor: String?
    
    @objc
    public let status: PlatonStatus
    
    @objc
    public init(action: PlatonMethodAction, result: PlatonResult, orderId: String, transId: String, descriptor: String?, status: PlatonStatus, transDate: String) {
        self.descriptor = descriptor
        self.status = status

        super.init(action: action, result: result, orderId: orderId, transId: transId, transDate: transDate)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        descriptor = try container.decode(type(of: descriptor), forKey: .descriptor)
        status = try container.decode(type(of: status), forKey: .status)

        try super.init(from: decoder)
    }
    
    @objc
    private enum CodingKeys: Int, CodingKey, Decodable {
        case descriptor = 1
        case status = 2
        case recurringToken = 3
        
        public var stringValue: String {
            switch self {
            case .descriptor:
                return "descriptor"
            case .status:
                return "status"
            case .recurringToken:
                return "recurring_token"
            }
        }
    }
}

@objc(PlatonApplePayUnsuccess)
final public class PlatonApplePayUnsuccess: PlatonApplePay, PlatonDeclineReasonProtocol, PlatonStatusProtocol {
    
    @objc
    public let declineReason: String
    
    @objc
    public let status: PlatonStatus
    
    @objc
    public init(action: PlatonMethodAction, result: PlatonResult, orderId: String, transId: String, transDate: String, declineReason: String, status: PlatonStatus) {
        self.declineReason = declineReason
        self.status = status
        
        super.init(action: action, result: result, orderId: orderId, transId: transId, transDate: transDate)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        declineReason = try container.decode(type(of: declineReason), forKey: .declineReason)
        status = try container.decode(type(of: status), forKey: .status)
        
        try super.init(from: decoder)
    }
    
    @objc
    private enum CodingKeys: Int, CodingKey, Decodable {
        case declineReason = 1
        case status = 2
        
        public var stringValue: String {
            switch self {
            case .declineReason:
                return "decline_reason"
            case .status:
                return "status"
                
            }
        }
    }
}

/**
 After the successful request in *PlatonCalback* you should get *submit3dsDataRequest* and load this request in WKWebView where will be the button which will submit your 3ds data and verify payment
 ```
 ...
 PlatonPostPayment.applePay.pay(payer: PlatonPayerApplePay, paymentToken: paymentToken, clientKey: clientKey, channelId: channelId, orderId: orderId, orderDescription: orderDescription, amount: amountl, termsUrl3ds: termsUrl3ds) { (result) in
 
 switch result {
 ...
     case .secure3d(let sale3ds):
     if let request = sale3ds.submit3dsDataRequest?.request {
         webView?.loadRequest(request)
     }
 }
 ...
 }
 ```
 */

@objc(PlatonApplePay3DS)
final public class PlatonApplePay3DS: PlatonApplePay, PlatonStatusProtocol, PlatonRedirectProtocol {
    @objc
    public let status: PlatonStatus
    @objc
    public let redirectUrl: String
    
    public let redirectParams: PlatonRedirectParams
    @objc
    public let redirectMethod: PlatonHTTPMethod
        
    /// Request whcich you should load in Webview for submit your 3ds data and verify payment
    @objc
    public var submit3dsDataRequest: URLRequest? {
        guard let baseUrl = URL(string: "\(redirectUrl)") else {
            return nil
        }
        var request = URLRequest(url: baseUrl)
        request.httpMethod = redirectMethod.stringValue
        request.httpBody = redirectParams.anyParams.prepareQuery().data(using: .utf8)

        return request
    }
    
    @objc
    public init(action: PlatonMethodAction, result: PlatonResult, orderId: String, transId: String, transDate: String, status: PlatonStatus, redirectUrl: String, redirectParams: PlatonRedirectParams, redirectMethod: PlatonHTTPMethod) {
        self.status = status
        self.redirectUrl = redirectUrl
        self.redirectParams = redirectParams
        self.redirectMethod = redirectMethod
        
        super.init(action: action, result: result, orderId: orderId, transId: transId, transDate: transDate)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(type(of: status), forKey: .status)
        self.redirectUrl = try container.decode(type(of: redirectUrl), forKey: .redirectUrl)
        self.redirectParams = try container.decode(PlatonRedirectParams.self, forKey: .redirectParams)
        self.redirectMethod = try container.decode(type(of: redirectMethod), forKey: .redirectMethod)
        
        try super.init(from: decoder)
    }
    
    @objc
    private enum CodingKeys: Int, CodingKey, Decodable {
        case status = 1
        case redirectUrl = 2
        case redirectParams = 3
        case redirectMethod = 4
        
        public var stringValue: String {
            switch self {
            case .status:
                return "status"
            case .redirectUrl:
                return "redirect_url"
            case .redirectParams:
                return "redirect_params"
            case .redirectMethod:
                return "redirect_method"
            }
        }
    }
}
