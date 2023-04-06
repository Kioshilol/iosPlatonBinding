
/// Class which contains additional functions for helping
@objc(PlatonSDKUtils)
final class PlatonSDKUtils : NSObject {
    
    /// Method find .plist file of current name and return all .plist data in Dictionary
    ///
    /// - Parameter name: .plist file name
    /// - Returns: Dictionary which contains data from .plist file
    @objc
    static func getPlist(name: String) -> AnyParams? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let dictPlist = NSDictionary(contentsOfFile: path) as? AnyParams else {
                debugPrint("Error: Can't read \"Platon-info.plist\"")
                return nil
        }
        
        return dictPlist
    }
    
    /// Convert object with all parameters to string
    ///
    /// - Parameter object: object that you want to convert
    /// - Returns: formated string
    @objc
    static func getDescribing(_ object: Any) -> String {
        var describing = "\(type(of: object)): {\n"
        let mirror = Mirror(reflecting: object)
        
        for (name, value) in mirror.children {
            describing += "    \"\(name ?? "_")\": \(value)\n"
        }
        
        var superMirror = mirror.superclassMirror
        
        while let unwSuperMirror = superMirror {
            for (name, value) in unwSuperMirror.children {
                describing += "    \"\(name ?? "_")\": \(value)\n"
            }
            superMirror = unwSuperMirror.superclassMirror
        }
        
        describing += "}"
        return describing
    }
}

//TODO: CHECK IF WORKING THIS EXTENSION
extension Dictionary: PlatonParametersProtocol {
    
    /// This function check current dictionary on valid on *PlatonParams* for using in *PlatonBaseAdapter*
    public var platonParams: PlatonParams {
        guard let dictProperties = self as? PlatonParams else {
            return PlatonParams()
        }
        
        return dictProperties
    }
    
    /// Function for appending current dictionary with another dictionaries
    ///
    /// - Parameter dictionary: another dictionary what you want to append
    /// - Returns: new dictionary which contains objects of both dictionaries
    func platonAppend<K, V>(_ dictionary: [K: V]) -> [K: V] {
        var newDict = [K: V]()
        
        for (k, v) in self {
            
            if let unwK = k as? K, let unwV = v as? V {
                newDict[unwK] = unwV
            }
            
        }
        
        for (k, v) in dictionary {
            newDict[k] = v
        }
        
        return newDict
    }
    
}

//TODO: CHECK IF WORKING THIS EXTENSION
extension Array: PlatonParametersProtocol {
    
    /// This functions getet all *PlatonParams* properies from current array and making new *PlatonPrams* object for using in *PlatonBaseAdapter*
    public var platonParams: PlatonParams {
        guard let arrPlatonParams = self as? [PlatonParametersProtocol] else {
            return PlatonParams()
        }
        
        var dictProperties = PlatonParams()
        
        for platonParam in arrPlatonParams {
            dictProperties = dictProperties.platonAppend(platonParam.platonParams)
        }
        
        return dictProperties
    }
    
}

extension Float {
    
    /// Сonverts the *Float* value according to the documentation. String in the form XXXX.XX (without leading zeros))
    var platonAmount: String? {
        return String(format: "%.2f", self)
    }
    
}

/// Implement this protocol to formatted output of your class

@objc
public protocol PlatonCustomDescribe: NSObjectProtocol {
    var customDescription: String { get }
}

extension PlatonCustomDescribe where Self: CustomStringConvertible {
    public var customDescription: String {
        return self.description
    }
}

