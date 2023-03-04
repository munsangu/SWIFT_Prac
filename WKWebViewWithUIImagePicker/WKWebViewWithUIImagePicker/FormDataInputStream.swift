//import Foundation
//
//class FormDataInputStream: InputStream {
//    let boundary: String
//    let stream: InputStream
//    var currentPartData: Data?
//    var currentPartDataOffset = 0
//
//    init?(multipartFormData: MultipartFormData) {
//        boundary = multipartFormData.boundary
//        stream = InputStream(data: multipartFormData.data)
//        super.init(data: Data())
//    }
//
//    override convenience init(data: Data) {
//        self.init(data: data, startOffset: 0)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func open() {
//        stream.open()
//        super.open()
//    }
//
//    override func close() {
//        stream.close()
//        super.close()
//    }
//
//    override func read(_ buffer: UnsafeMutablePointer<UInt8>, maxLength len: Int) -> Int {
//        if currentPartData == nil {
//            if let partRange = getNextPartRange() {
//                currentPartData = stream.readData(ofLength: partRange.length)
//            } else {
//                return 0
//            }
//        }
//
//        let bytesRemaining = currentPartData!.count - currentPartDataOffset
//        let bytesToCopy = min(len, bytesRemaining)
//        currentPartData!.copyBytes(to: buffer, from: currentPartDataOffset..<currentPartDataOffset + bytesToCopy)
//        currentPartDataOffset += bytesToCopy
//
//        if currentPartDataOffset == currentPartData!.count {
//            currentPartData = nil
//            currentPartDataOffset = 0
//        }
//
//        return bytesToCopy
//    }
//
//    override var streamStatus: Stream.Status {
//        return stream.streamStatus
//    }
//
//    override var streamError: Error? {
//        return stream.streamError
//    }
//
//    private func getNextPartRange() -> NSRange? {
//        var partHeader = ""
//
//        repeat {
//            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
//            let bytesRead = stream.read(buffer, maxLength: 1)
//            let byteRead = bytesRead > 0 ? buffer[0] : 0
//            let byteReadString = String(bytes: [byteRead], encoding: .utf8)
//            partHeader += byteReadString ?? ""
//
//            if partHeader.count > boundary.count + 4 {
//                let startIndex = partHeader.index(partHeader.startIndex, offsetBy: partHeader.count - boundary.count - 4)
//                let endIndex = partHeader.index(partHeader.startIndex, offsetBy: partHeader.count - boundary.count)
//                let boundaryString = String(partHeader[startIndex..<endIndex])
//
//                if boundaryString == "--\(boundary)\r\n" {
//                    return NSRange(location: stream.offsetInFile, length: partHeader.count)
//                }
//            }
//        } while true
//    }
//}
