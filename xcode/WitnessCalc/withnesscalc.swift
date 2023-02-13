import Foundation

enum LoadingError: Error {
    case fileNotFound(name: String?, ext: String)
    case dataLoadingFailed
}

enum ConversionError: Error {
    case negativeInt
}

func castIntToUInt(_ intValue: Int) throws -> UInt {
    if intValue >= 0 {
        if let uintValue = UInt(exactly: intValue) {
            return uintValue
        }
    }
    throw ConversionError.negativeInt
}

func loadBundleFile(forResource name: String?, ofType ext: String) throws -> (UnsafePointer<UInt8>, UInt) {
    let bundle = Bundle.main
    if let path = bundle.path(forResource: name, ofType: ext) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let buffer = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> UnsafePointer<UInt8> in
                bytes.bindMemory(to: UInt8.self).baseAddress!
            }
            return (buffer, try castIntToUInt(data.count))
        } catch {
            throw LoadingError.dataLoadingFailed
        }
    } else {
        throw LoadingError.fileNotFound(name: name, ext: ext)
    }
}

typealias onAddLeafArgs = [String]

let WitnessBufferSize = 4 * 1024 * 1024
let ErrorMessageSize = MemoryLayout<Int8>.size * 256
let circuitName = "onAddLeaf"

func runProof() {
    do {
        let zkey = try loadBundleFile(forResource: circuitName, ofType: "zkey")
        let json = try loadBundleFile(forResource: circuitName, ofType: "json")
        let circuit = try loadBundleFile(forResource: circuitName, ofType: "dat")
        let wtns = UnsafeMutablePointer<UInt8>.allocate(capacity: WitnessBufferSize)
        let wtns_size = UnsafeMutablePointer<UInt>.allocate(capacity: MemoryLayout<Int8>.size)
        let error_message = UnsafeMutablePointer<UInt8>.allocate(capacity: ErrorMessageSize)
//        let result = witnesscalc_authV2(circuit.0, circuit.1, json.0, json.1, wtns, wtns_size, error_message, UInt(ErrorMessageSize))
        let result = witnesscalc_Oal(circuit.0, circuit.1, json.0, json.1, wtns, wtns_size, error_message, UInt(ErrorMessageSize))
        if(result == 0) {
            
        } else {
            
        }
    } catch {
        print("Error converting Int to UInt: \(error)")
    }
}

