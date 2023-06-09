
import Foundation

/// Schedule options for *PlatonMethodAction.schedule* request
@objc
public class PlatonScheduleAdditonal: NSObject, PlatonParametersProtocol {
    /// Delay in days before performing the first payment
    ///
    /// If not provided, the first payment will be done as soon as possible
    /// 
    @objc
    public var initDelayDays: Int
    
    ///  The number of times the payments will be done
    ///
    /// Not provided or zero value means unlimited number of payments
    @objc
    public var repeatTimes: Int
    
    @objc
    public init(initDelayDays: Int, repeatTimes: Int) {
        self.initDelayDays = initDelayDays
        self.repeatTimes = repeatTimes
    }
    
    public var platonParams: PlatonParams {
        return [
            PlatonMethodProperty.initPeriod: initDelayDays,
            PlatonMethodProperty.times: repeatTimes,
        ]
    }
    
}

/// Schedule options for web SCHEDULE request
public struct PlatonWebScheduleAdditonal: PlatonParametersProtocol {
    
    /// Initial period in days before the first recurring payment to be created
    let initialDelay: Int
    
    /// Total number of recurring payments
    ///
    /// The zero value means unlimited number of recurring payments
    let repeatTimes: Int
    
    /// Period in days between further recurring payments
    let period: Int
    
    public init(initialDelay: Int, period: Int, repeatTimes: Int) {
        self.initialDelay = initialDelay
        self.period = period
        self.repeatTimes = repeatTimes
    }
    
    public var platonParams: PlatonParams {
        return [
            PlatonMethodProperty.initialDelay: initialDelay,
            PlatonMethodProperty.period: period,
            PlatonMethodProperty.times: repeatTimes,
        ]
    }
    
}
