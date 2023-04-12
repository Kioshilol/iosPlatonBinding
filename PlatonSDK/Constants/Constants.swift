
/// Used as meta-data name for initialization
///
/// - clientKey: Unique key to identify the account in Payment Platform (used as request parameter)
/// - clientPass: Password for Client authentication in Payment Platform (used for calculating hash parameter)
/// - paymentUrl: URL to request the Payment Platform
/// - termUrl3ds: URL to which Customer should be returned after 3D-Secure. This field is (Required) when your account support 3DSecure (string up to 1024 symbols). Used as request parameter in *PlatonMethodAction.sale*.
enum PlatonSDKConstants: String {
    case clientKey = "CLIENT_KEY"
    case clientPass = "CLIENT_PASS"
    case paymentUrl = "PAYMENT_URL"
    case termUrl3ds = "TERM_URL_3DS"
    case stateUrl = "STATE_URL"
}

/// When you make request to Payment Platform, you need to specify action, that needs to be done
///
/// Note: that last 3 actions can’t be made by request, they’re created by Payment Platform in certain circumstances (e.g. issuer initiated chargeback) and you receive callback as a result
///
/// - capture: Creates CAPTURE transaction
/// - chargeback: CHARGEBACK transaction was created in Payment Platform
/// - creditvoid: Creates REVERSAL or REFUND transaction
/// - deschedule: Disables schedule for recurring transactions
/// - getTransDetails: Gets details of the order from Payment platform
/// - getTransStatus: Gets status of transaction in Payment Platform
/// - recurringSale: Creates SALE transaction using previously used cardholder data
/// - sale: Creates SALE or *PlatonMethodProperties.auth* transaction
/// - schedule: Creates schedule for recurring transactions
/// - secondChargeback: SECOND_CHARGEBACK transaction was created in Payment Platform
/// - secondPresentment: SECOND_PRESENTMENT transaction was created in Payment Platform
@objc
public enum PlatonMethodAction: Int, Decodable, PlatonParametersProtocol {
    case capture = 0
    case chargeback = 1
    case creditvoid = 2
    case deschedule = 3
    case getTransDetails = 4
    case getTransStatus = 5
    case recurringSale = 6
    case sale = 7
    case tokenSale = 8
    case schedule = 9
    case secondChargeback = 10
    case secondPresentment = 11
    case applePay = 12
    case transactionState = 13

    public var platonParams: [PlatonMethodProperty : Any?] {
        return [
            //TODO: check if there is difference between rawValue and stringValue
            PlatonMethodProperty.action: self.stringValue
        ]
    }
    
    public var stringValue: String {
        switch self {
        case .capture:
            return "CAPTURE"
        case .chargeback:
            return "CHARGEBACK"
        case .creditvoid:
            return "CREDITVOID"
        case .deschedule:
            return "DESCHEDULE"
        case .getTransDetails:
            return "GET_TRANS_DETAILS"
        case .getTransStatus:
            return "GET_TRANS_STATUS"
        case .recurringSale:
            return "RECURRING_SALE"
        case .sale:
            return "SALE"
        case .tokenSale:
            return "TOKEN_SALE"
        case .schedule:
            return "SCHEDULE"
        case .secondChargeback:
            return "SECOND_CHARGEBACK"
        case .secondPresentment:
            return "SECOND_PRESENTMENT"
        case .applePay:
            return "APPLEPAY"
        case .transactionState:
            return "GET_TRANS_STATUS_BY_ORDER"
        }
    }
}

/// against field means that it is REQUIRED by request
///
/// - action: Value : *PlatonMethodAction*
/// - address: Buyer's street address for web payments. 123 Sample Street
/// - amount:  The amount for partial capture/ partial refund. That ONLY ONE partial capture allowed in * PlatonMethodAction.capture*. That SEVERAL partial refunds allowed in *PlatonMethodAction.creditvoid*. Numbers in the form XXXX.XX (without leading zeros)
/// - async: Asynchronous or synchronous mode. Used in conjunction with *PlatonOption* only. Default *PlatonOption.no*
/// - auth: Indicates that transaction must be only authenticated, but not captured. Used in conjunction with * PlatonOption* only. Default *PlatonOption.no*
/// - cardCvv2: CVV/CVC2 credit card verification. 3-4 symbols
/// - cardExpMonth: Month of expiry of the credit card. Month in the form XX (begin with 1)
/// - cardExpYear: Year of expiry of the credit card. Year in the form XXXX
/// - cardNumber: [Credit PlatonCard](https://en.wikipedia.org/wiki/Payment_card_number)
/// - channelId: Payment channel (Sub-account)
/// - city: Buyer's city for web payments
/// - clientKey: Unique client key which is stored in *PlatonCredentials*
/// - country: Buyer's country code for web payments
/// - currency: PlatonProduct currency. Value: 3-characters string (USD,EUR, etc.)
/// - data: Properties of the product (price, title, description). Base64-encoded data
/// - description: PlatonProduct name in web payments. Value: String up to 30 characters
/// - email: Buyer's email address for web payments
/// - errorUrl: Optional URL to which the Buyer will be returned after three unsuccessful purchase attempts
/// - ext1: Client Parameter 1
/// - ext2: Client Parameter 2
/// - ext3: Client Parameter 3
/// - ext4: Client Parameter 4
/// - firstName: Buyer's first name for web payments
/// - formId: Specific payment page identifier for web payments. (In case the Client's account has multiple payment pages configured)
/// - hash: Special signature to validate your request to Payment Platform
/// - initPeriod: Delay in days before performing the first payment. Numbers in the form XXX (without leading zeros)
/// - initialDelay: Initial period in days before the first recurring payment to be created
/// - key: Key for Client identification
/// - lang: Localization language to be selected on the payment page by default. Value: en, fr, de (ISO 639-1)
/// - lastName: Buyer's last name for web payments
/// - md: Set of redirect params which used for 3DS
/// - order: PlatonOrder ID for web payments. String up to 30 characters
/// - orderAmount: The amount of the transaction. Numbers in the form XXXX.XX (without leading zeros)
/// - orderCurrency: The amount of the transaction. Currency 3-letter code (ISO 4217)
/// - orderDescription: Description of the transaction (product name). String up to 1024 characters
/// - orderId: PlatonTransaction ID in the Clients system. String up to 255 characters
/// - paReq: Set of redirect params which used for 3DS
/// - payerAddress: Customer’s address. String up to 255 characters
/// - payerCity: Customer’s city. String up to 32 characters
/// - payerCountry: Customer’s country. Country 2-letter code (ISO 3166-1 alpha-2)
/// - payerEmail: Customer’s email. String up to 256 characters
/// - payerFirstName: Customer’s first name. String up to 32 characters
/// - payerIp: IP-address of the Customer. Format XXX.XXX.XXX.XXX. [Min length IP address](https://stackoverflow.com/questions/22288483/whats-the-minimum-length-of-an-ip-address-in-string-representation) and [max length IP address](https://stackoverflow.com/questions/1076714/max-length-for-client-ip-address#answer-7477384)
/// - payerLastName: Customer’s surname. String up to 32 characters
/// - payerPhone: Customer’s phone. String up to 32 characters
/// - payerState: Customer’s state. 2-letter code for countries without states)
/// - payerZip: ZIP-code of the Customer. String up to 32 characters
/// - payment: Payment method code
/// - period: Period in days to perform the payments. Numbers in the form XXX (without leading zeros)
/// - phone: Buyer's phone number for web payments
/// - rcId: PlatonRecurring ID (will be received with the first payment) in web payments
/// - rcToken: Additional parameter for further recurring (will be received with the first payment) in web payments. String 32 characters
/// - reccuringInit: Initialization of the transaction with possible following recurring. Used in conjunction with *PlatonOption* only. Default *PlatonOption.no*
/// - recurring: Flag to initialize the possibility of the further recurring payments
/// - recurringFirstTransId: PlatonTransaction ID of the primary transaction in the Payment Platform. String up to 255 characters
/// - recurringToken: Value obtained during the primary transaction. String up to 255 characters
/// - selected: PlatonProduct, selected by default in products list
/// - sign: Special signature to validate your request to Payment Platform
/// - state: Buyer's country region code (state, provice, etc.) for web payments. Applied only for US, CA and AU. TX (ISO 3166-2)
/// - termUrl: Set of redirect params which used for 3DS
/// - termsUrl3ds: URL to which Customer should be returned after 3D-Secure. If your account support 3D-Secure this parameter is required. String up to 1024 characters
/// - times: The number of times the payments will be done. Not provided or zero value means unlimited number of payments. Numbers in the form XXX (without leading zeros)
/// - transId: PlatonTransaction ID in the Payment Platform
/// - url: URL to which the Buyer will be redirected after the successful payment
/// - zip: Buyer's zip code for web payments.
@objc
public enum PlatonMethodProperty: Int, Decodable {
    case action = 1
    case address = 2
    case amount = 3
    case async = 4
    case auth = 5
    case cardCvv2 = 6
    case cardExpMonth = 7
    case cardExpYear = 8
    case cardNumber = 9
    case channelId = 10
    case city = 11
    case clientKey = 12
    case country = 13
    case currency = 14
    case data = 15
    case description = 16
    case email = 17
    case errorUrl = 18
    case ext1 = 19
    case ext2 = 20
    case ext3 = 21
    case ext4 = 22
    case ext5 = 23
    case ext6 = 24
    case ext7 = 25
    case ext8 = 26
    case ext9 = 27
    case ext10 = 28
    case firstName = 29
    case formId = 30
    case hash = 31
    case initPeriod = 32
    case initialDelay = 33
    case key = 34
    case lang = 35
    case lastName = 36
    case md = 37
    case order = 38
    case req_token = 39
    case orderAmount = 40
    case orderCurrency = 41
    case orderDescription = 42
    case orderId = 43
    case paReq = 44
    case payerAddress = 45
    case payerAddress2 = 46
    case payerBirthDate = 47
    case payerCity = 48
    case payerCountry = 49
    case payerEmail = 50
    case payerFirstName = 51
    case payerIp = 52
    case payerMidleName = 53
    case payerLastName = 54
    case payerPhone = 55
    case payerState = 56
    case payerZip = 57
    case payment = 58
    case paymentToken = 59
    case period = 60
    case phone = 61
    case rcId = 62
    case rcToken = 63
    case reccuringInit = 64
    case recurring = 65
    case recurringFirstTransId = 66
    case recurringToken = 67
    case selected = 68
    case sign = 69
    case state = 70
    case termUrl = 71
    case termsUrl3ds = 72
    case times = 73
    case transId = 74
    case url = 75
    case zip = 76
    case cardToken = 77
    case bankId = 78
    case payerId = 79
    
    public var stringValue: String {
        switch self {
        case .action:
            return "action"
        case .address:
            return "address"
        case .amount:
            return "amount"
        case .async:
            return "async"
        case .auth:
            return "auth"
        case .cardCvv2:
            return "card_cvv2"
        case .cardExpMonth:
            return "card_exp_month"
        case .cardExpYear:
            return "card_exp_year"
        case .cardNumber:
            return "card_number"
        case .channelId:
            return "channel_id"
        case .city:
            return "city"
        case .clientKey:
            return "client_key"
        case .country:
            return "country"
        case .currency:
            return "currency"
        case .data:
            return "data"
        case .description:
            return "description"
        case .email:
            return "email"
        case .errorUrl:
            return "error_url"
        case .ext1:
            return "ext1"
        case .ext2:
            return "ext2"
        case .ext3:
            return "ext3"
        case .ext4:
            return "ext4"
        case .ext5:
            return "ext5"
        case .ext6:
            return "ext6"
        case .ext7:
            return "ext7"
        case .ext8:
            return "ext8"
        case .ext9:
            return "ext9"
        case .ext10:
            return "ext10"
        case .firstName:
            return "first_name"
        case .formId:
            return "formid"
        case .hash:
            return "hash"
        case .initPeriod:
            return "init_period"
        case .initialDelay:
            return "initial_delay"
        case .key:
            return "key"
        case .lang:
            return "lang"
        case .lastName:
            return "lastName"
        case .md:
            return "MD"
        case .order:
            return "order"
        case .req_token:
            return "req_token"
        case .orderAmount:
            return "order_amount"
        case .orderCurrency:
            return "order_currency"
        case .orderDescription:
            return "order_description"
        case .orderId:
            return "order_id"
        case .paReq:
            return "paReq"
        case .payerAddress:
            return "payer_address"
        case .payerAddress2:
            return "payer_address2"
        case .payerBirthDate:
            return "payer_birth_date"
        case .payerCity:
            return "payer_city"
        case .payerCountry:
            return "payer_country"
        case .payerEmail:
            return "payer_email"
        case .payerFirstName:
            return "payer_first_name"
        case .payerIp:
            return "payer_ip"
        case .payerMidleName:
            return "payer_middle_name"
        case .payerLastName:
            return "payer_last_name"
        case .payerPhone:
            return "payer_phone"
        case .payerState:
            return "payer_state"
        case .payerZip:
            return "payer_zip"
        case .payment:
            return "payment"
        case .paymentToken:
            return "payment_token"
        case .period:
            return "period"
        case .phone:
            return "phone"
        case .rcId:
            return "rc_id"
        case .rcToken:
            return "rc_token"
        case .reccuringInit:
            return "reccuring_init"
        case .recurring:
            return "recurring"
        case .recurringFirstTransId:
            return "recurring_first_trans_id"
        case .recurringToken:
            return "recurring_token"
        case .selected:
            return "selected"
        case .sign:
            return "sign"
        case .state:
            return "state"
        case .termUrl:
            return "TermUrl"
        case .termsUrl3ds:
            return "term_url_3ds"
        case .times:
            return "times"
        case .transId:
            return "trans_id"
        case .url:
            return "url"
        case .zip:
            return "zip"
        case .cardToken:
            return "card_token"
        case .bankId:
            return "bank_id"
        case .payerId:
            return "payer_id"
        }
    }
}

/// Used as convenient variable while creating different requests
///
/// - no: N
/// - yes: Y
@objc
public enum PlatonOption: Int, Decodable {
    case no = 0
    case yes = 1
    
    public var stringValue: String {
        switch self {
        case .no:
            return "N"
        case .yes:
            return "Y"
        }
    }
}

/// Result – value that system returns on request
///
/// - accepted: Action was accepted by Payment Platform, but will be completed later
/// - declined: Result of unsuccessful action in Payment Platform
/// - error: Request has errors and was not validated by Payment Platform
/// - redirect: Additional action required from requester (redirect to 3ds)
/// - success: Action was successfully completed in Payment Platform
@objc
public enum PlatonResult: Int, Decodable {
    case accepted = 0
    case declined = 1
    case error = 2
    case redirect = 3
    case success = 4
    
    public var stringValue: String {
        switch self {
        case .accepted:
            return "ACCEPTED"
        case .declined:
            return "DECLINED"
        case .error:
            return "ERROR"
        case .redirect:
            return "REDIRECT"
        case .success:
            return "SUCCESS"
        }
    }
}

/// Status – actual status of transaction in Payment Platform
///
/// - chargeback: Transaction for which chargeback was made
/// - declined: Not successful transaction
/// - panding: The transaction awaits CAPTURE
/// - refound: Transaction for which refund was made
/// - reversal: Transaction for which reversal was made
/// - secondChargeback: Transaction for which second chargeback was made
/// - secondRepresentment: Transaction for which second presentment was made
/// - secure3d: The transaction awaits 3D-Secure validation
/// - settled: Successful transaction
/// - disabled: Disabled scheduling option for order (deschedule)
/// - enabled: Enabled scheduling option for order
@objc
public enum PlatonStatus: Int, Decodable {
    case chargeback = 0
    case declined = 1
    case pending = 2
    case refund = 3
    case reversal = 4
    case secondChargeback = 5
    case secondPresentment = 6
    case secure3d = 7
    case settled = 8
    case disabled = 9
    case enabled = 10
    
    public var stringValue: String {
        switch self {
        case .chargeback:
            return "CHARGEBACK"
        case .declined:
            return "DECLINED"
        case .pending:
            return "PENDING"
        case .refund:
            return "REFUND"
        case .reversal:
            return "REVERSAL"
        case .secondChargeback:
            return "SECOND_CHARGEBACK"
        case .secondPresentment:
            return "SECOND_PRESENTMENT"
        case .secure3d:
            return "3DS"
        case .settled:
            return "SETTLED"
        case .disabled:
            return "DISABLED"
        case .enabled:
            return "ENABLED"
        }
    }
}
    
    /// Used when fetch transaction data
    ///
    /// - failure: Transaction was failed
    /// - success: Transaction was successful
    @objc
    public enum TransactionStatus: Int, Decodable {
        case failure = 0
        case success = 1
    }
    
    /// Used when fetch transaction data
    ///
    /// - auth: Transaction of authentication only without capturing. Customer may authenticate many transaction (formed in batch) before they will be captured. First stage of Dual Message System (DMS). On authorization stage in processing
    /// - capture: Transaction of payment capturing during second phase of DMS. Funds is transferred from Issuer Bank account through Acquiring Bank down to Merchant Commercial Bank Account. On successful approval by manager
    /// - chargeback: Holds that this dispute transaction at the stage of consideration (prior to obtaining evidences and documents)
    /// - initialize: Tech status when user will its data on payment page
    /// - refound: Transaction of refunding cost
    /// - reversal: Transaction of successfully transferring hold money back
    /// - sale: Status for transaction with successful immediate payment
    /// - secondChargeback: Second request for refund OR transaction is on arbitrary stage (dispute on "dispute transaction")
    /// - secondPresentment: Holds that this dispute transaction at the stage of consideration (prior to obtaining evidences and documents)
    /// - secure3d: 3DS verification card sending
    @objc
    public enum TransactionType: Int, Decodable {
        case auth = 0
        case capture = 1
        case chargeback = 2
        case initialize = 3
        case refound = 4
        case reversal = 5
        case sale = 6
        case secondChargeback = 7
        case secondPresentment = 8
        case secure3d = 9
        
        public var stringValue: String {
            switch self {
            case .auth:
                return "AUTH"
            case .capture:
                return "CAPTURE"
            case .chargeback:
                return "CHARGEBACK"
            case .initialize:
                return "INIT"
            case .refound:
                return "REFUND"
            case .reversal:
                return "REVERSAL"
            case .sale:
                return "SALE"
            case .secondChargeback:
                return "SECOND CHARGEBACK"
            case .secondPresentment:
                return "SECOND PRESENTMENT"
            case .secure3d:
                return "3DS"
            }
        }
    }
    
    /// List of typical request types
    ///
    /// - options: OPTIONS
    /// - get: GET
    /// - head: HEAD
    /// - post: POST
    /// - put: PUT
    /// - patch: PATCH
    /// - delete: DELETE
    /// - trace: TRACE
    /// - connect: CONNECT
    @objc
    public enum PlatonHTTPMethod: Int, Decodable {
        case options = 0
        case get = 1
        case head = 2
        case post = 3
        case put = 4
        case patch = 5
        case delete = 6
        case trace = 7
        case connect = 8
        
        public var stringValue: String {
            switch self {
            case .options:
                return "OPTIONS"
            case .get:
                return "GET"
            case .head:
                return "HEAD"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .patch:
                return "PATCH"
            case .delete:
                return "DELETE"
            case .trace:
                return "TRACE"
            case .connect:
                return "CONNECT"
            }
        }
    }
    
    /// Payment method code
    ///
    /// - CC: for payment cards
    /// - RF: for one-click payment
    @objc
    public enum PlatonWebPaymentType: Int, Decodable {
        case CC = 0
        case RF = 1
        case CCT = 2
        case C2A = 3
        case C2AT = 4
        
        public var stringValue: String {
            switch self {
            case .CC:
                return "CC"
            case .RF:
                return "RF"
            case .CCT:
                return "CCT"
            case .C2A:
                return "C2A"
            case .C2AT:
                return "C2AT"
            }
        }
    }
