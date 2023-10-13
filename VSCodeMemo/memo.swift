import Foundation
import CoreBluetooth

// Define packet constants
let SOP: UInt8 = 0xFE
let EOP: UInt8 = 0xFD
let SYS_OID: UInt8 = 0x00
let OBD_OID: UInt8 = 0xA6

// Define message IDs (you need to define your specific IDs)
let SYS_CONNECT_REQ: UInt8 = 0x01
let SYS_CONNECT_RES: UInt8 = 0x02
let SYS_VERSION2_REQ: UInt8 = 0x03
let SYS_VERSION2_RES: UInt8 = 0x04
let OBD_BP_VERSION_REQ: UInt8 = 0x05
let OBD_BP_VERSION_RSP: UInt8 = 0x06
let OBD_BP_CONFIG_REQ: UInt8 = 0x07
let OBD_BP_CONFIG_RES: UInt8 = 0x08
let OBD_STATUS_RSP: UInt8 = 0x09
let OBD_STATUS_REQ: UInt8 = 0x0A
let OBD_DATA_IND: UInt8 = 0x0B

// Create a function to calculate CRC
func calculateCRC(_ data: Data) -> UInt8 {
    let crc = data.reduce(UInt8(0)) { (result, byte) in
        return result ^ byte
    }
    return crc
}

// Create a function to create a packet
func createPacket(sequenceNumber: UInt8, objectID: UInt8, messageID: UInt8, payload: Data) -> Data {
    var packet = Data()
    
    // Add Start of Packet (SOP)
    packet.append(SOP)
    
    // Calculate the length of SDU
    let sduLength = UInt8(payload.count)
    packet.append(sduLength)
    
    // Create SDU (Service Data Unit)
    var sdu = Data()
    sdu.append(sequenceNumber << 1) // Left shift to set the ACK_IND bit
    sdu.append(objectID)
    sdu.append(messageID)
    sdu.append(payload)
    
    // Calculate CRC and append it to SDU
    let crc = calculateCRC(sdu)
    sdu.append(crc)
    
    // Append SDU to the packet
    packet.append(sdu)
    
    // Add End of Packet (EOP)
    packet.append(EOP)
    
    return packet
}

// Example usage:
let sequenceNumber: UInt8 = 0x00 // Set your sequence number
let objectID: UInt8 = OBD_OID
let messageID: UInt8 = OBD_STATUS_REQ // Set your message ID
let payload: Data = Data(bytes: [0x01, 0x02, 0x03]) // Replace with your payload

let packet = createPacket(sequenceNumber: sequenceNumber, objectID: objectID, messageID: messageID, payload: payload)

// Now you can send 'packet' over Bluetooth using CoreBluetooth