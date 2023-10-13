import Foundation

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

func parseBluetoothData3(data: [UInt8]) -> BluetoothData3? {
    guard data.count >= 38 else {
        print("Data length is insufficient.")
        return nil
    }
    
    let tempStartIndex = 18
    let tempEndIndex = tempStartIndex + Int(data[17])
    
    guard tempEndIndex <= data.count else {
        print("Temperature data range is out of bounds.")
        return nil
    }

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
        CRC: data[17 + Int(data[17])],
        EOP: data[18 + Int(data[17])]
    )

    return bluetoothData
}
