
import Foundation

/// Types of error.
///
/// - noInternet: No internet connection
/// - sdkAuth: When you are not configure SDK or configure with empty fields.
/// - fromServer: When you receive error from server(about bad params, etc.)
/// - parse: When SDK can't parse server data to any Platon Models.
/// - unknown: When you receive unknown error
@objc
public enum PlatonErrorType: Int, Decodable {
    case noInternet = 1
    case sdkAuth = 2
    case fromServer = 3
    case parse = 4
    case unknown = 5
    
    public var stringValue: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .sdkAuth:
            return "SDK initialization error"
        case .fromServer:
            return "Error from server"
        case .parse:
            return "Server data parsing fail"
        case .unknown:
            return "Unowned error"
        }
    }
}

@objc(PlatonError)
public class PlatonError: PlatonBaseProtocol {
    
    /// Specified message
    public let message: String
    
    /// Types of error.
    public let type: PlatonErrorType
    
    /// Error code
    public let code: Int

    public init (result: PlatonResult = .error, message: String? = nil, type: PlatonErrorType = .unknown, code: Int = 0) {
        self.code = code
        
        if type == .unknown && code == -1009 {
            self.type = .noInternet
        } else {
            self.type = type
        }
        
        if let unwMessage = message {
            self.message = unwMessage
        } else {
            self.message = type.stringValue
        }
        
        try super.init(action: PlatonMethodAction.capture, result: result, orderId: "", transId: "")
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        //self.result = try container.decode(PlatonResult.self, forKey: .result)
        self.message = try container.decode(String.self, forKey: .message)
        self.type = .fromServer
        self.code = 0
        
        try super.init(from: decoder)
    }

            
            enum CodingKeys: String, CodingKey {
                case result = "result"
                case message = "error_message"
                case action = "action"
            }
        }
        /// Error model which using for all failure response




