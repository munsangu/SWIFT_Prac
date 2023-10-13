import Foundation

struct BluetoothData {
    let SOP: UInt8
    let LEN: UInt8
    let SEQ: UInt8
    let OBJ: UInt8
    let MID: UInt8
    let ERROR: UInt8
    let MSG_SEQ: UInt8
    let TIMESTAMP: UInt32
    let RESERVED: UInt16
    let REM_BLOCKS: UInt16
    let NUM_BLOCKS: UInt8
    let BLOCK_LEN: UInt8
    let SOC: UInt8
    let BPI: Float
    let BPV: Float
    let CUM_I_IN: UInt32
    let CUM_I_OUT: UInt32
    let CUM_P_IN: UInt32
    let CUM_P_OUT: UInt32
    let RUN_TIME: UInt32
    let MAX_P_IN: UInt16
    let MAX_P_OUT: UInt16
    let WARNING: UInt8
    let FAULT: UInt8
    let FAST_CHARGE: UInt8
    let SOH: UInt8
    let CRC: UInt8
    let EOP: UInt8
}

struct BluetoothData3 {
    let SOP: UInt8
    let LEN: UInt8
    let SEQ: UInt8
    let OBJ: UInt8
    let MID: UInt8
    let ERROR: UInt8
    let MSG_SEQ: UInt8
    let TIMESTAMP: UInt32
    let RESERVED: UInt16
    let REM_BLOCKS: UInt16
    let NUM_BLOCKS: UInt8
    let BLOCK_LEN: UInt8
    let MODULE_COUNT: UInt8
    let TEMP: [UInt8]
    let CRC: UInt8
    let EOP: UInt8
}

func parseBluetoothData(data: [UInt8]) -> BluetoothData? {
    guard data.count >= 56 else { return nil }
    
    let bluetoothData = BluetoothData(
        SOP: data[0],
        LEN: data[1],
        SEQ: data[2],
        OBJ: data[3],
        MID: data[4],
        ERROR: data[5],
        MSG_SEQ: data[6],
        TIMESTAMP: UInt32(data[7]) << 24 | UInt32(data[8]) << 16 | UInt32(data[9]) << 8 | UInt32(data[10]),
        RESERVED: UInt16(data[11]) << 8 | UInt16(data[12]),
        REM_BLOCKS: UInt16(data[13]) << 8 | UInt16(data[14]),
        NUM_BLOCKS: data[15],
        BLOCK_LEN: data[16],
        SOC: data[17],
        BPI: Float(bitPattern: UInt32(data[18]) << 24 | UInt32(data[19]) << 16 | UInt32(data[20]) << 8 | UInt32(data[21])),
        BPV: Float(bitPattern: UInt32(data[22]) << 24 | UInt32(data[23]) << 16 | UInt32(data[24]) << 8 | UInt32(data[25])),
        CUM_I_IN: UInt32(data[26]) << 24 | UInt32(data[27]) << 16 | UInt32(data[28]) << 8 | UInt32(data[29]),
        CUM_I_OUT: UInt32(data[30]) << 24 | UInt32(data[31]) << 16 | UInt32(data[32]) << 8 | UInt32(data[33]),
        CUM_P_IN: UInt32(data[34]) << 24 | UInt32(data[35]) << 16 | UInt32(data[36]) << 8 | UInt32(data[37]),
        CUM_P_OUT: UInt32(data[38]) << 24 | UInt32(data[39]) << 16 | UInt32(data[40]) << 8 | UInt32(data[41]),
        RUN_TIME: UInt32(data[42]) << 24 | UInt32(data[43]) << 16 | UInt32(data[44]) << 8 | UInt32(data[45]),
        MAX_P_IN: UInt16(data[46]) << 8 | UInt16(data[47]),
        MAX_P_OUT: UInt16(data[48]) << 8 | UInt16(data[49]),
        WARNING: data[50],
        FAULT: data[51],
        FAST_CHARGE: data[52],
        SOH: data[53],
        CRC: data[54],
        EOP: data[55]
    )
    
    return bluetoothData
}

func parseBluetoothData3(data: [UInt8]) -> BluetoothData3? {
    guard data.count >= 38 else {
        print("Data length is insufficient.")
        return nil
    } // Ensure the array has the correct length

    let tempStartIndex = 18 // The starting index of temperature data
    let tempEndIndex = tempStartIndex + Int(data[17]) // Calculate the end index based on MODULE_COUNT

    guard tempEndIndex <= data.count else {
        print("Temperature data range is out of bounds.")
        return nil
    }

    // Extract temperature data as an array of UInt8
    let tempData = Array(data[tempStartIndex..<tempEndIndex])

    let bluetoothData = BluetoothData3(
        SOP: data[0],
        LEN: data[1],
        SEQ: data[2],
        OBJ: data[3],
        MID: data[4],
        ERROR: data[5],
        MSG_SEQ: data[6],
        TIMESTAMP: UInt32(data[7]) << 24 | UInt32(data[8]) << 16 | UInt32(data[9]) << 8 | UInt32(data[10]),
        RESERVED: UInt16(data[11]) << 8 | UInt16(data[12]),
        REM_BLOCKS: UInt16(data[13]) << 8 | UInt16(data[14]),
        NUM_BLOCKS: data[15],
        BLOCK_LEN: data[16],
        MODULE_COUNT: data[17],
        TEMP: tempData,
        CRC: data[17 + Int(data[17])], // Index for CRC
        EOP: data[18 + Int(data[17])]   // Index for EOP
    )

    return bluetoothData
}

let data: [UInt8] = [0xFE, 0x34, 0x89, 0xA6, 0x16, 0x00, 0x27, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x01, 0x25, 0x37, 0x3F, 0x66, 0x66, 0x67, 0x44, 0x28, 0xD9, 0x9A, 0x00, 0xB1, 0x25, 0xF5, 0x00, 0x01, 0x2B, 0x92, 0x00, 0x01, 0x26, 0x29, 0x00, 0x00, 0xD0, 0xD7, 0x00, 0x00, 0xC7, 0xCC, 0x09, 0xE2, 0x09, 0xE2, 0x00, 0x00, 0x00, 0x64, 0xCF, 0xFD]

if let parsedData = parseBluetoothData(data: data) {
    print(parsedData.BPI)
    print(parsedData.BPV)
    print(parsedData.SOC)
    print(parsedData.SOH)
} else {
    print("Invalid data")
}

let data4: [UInt8] = [254, 34, 137, 166, 24, 0, 74, 0, 0, 0, 10, 0, 0, 0, 0, 1, 61, 18, 68, 69, 68, 69, 68, 69, 68, 68, 69, 69, 68, 69, 68, 69, 69, 69, 68, 69, 89, 253]

if let parsedData = parseBluetoothData3(data: data4) {
    print(parsedData.TEMP)
} else {
    print("Invaild data")
}