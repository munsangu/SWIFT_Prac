import Foundation

struct BluetoothData2 {
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
    let START_CELL_ID: UInt8
    let CELL_COUNT: UInt8
    let VOLTAGE: [UInt8]
    let CRC: UInt8
    let EOP: UInt8
}

func parseBluetoothData2(data: [UInt8]) -> BluetoothData2? {
    guard data.count >= 81 else {
        print("Data length is insufficient.")
        return nil
    }

    let voltageStartIndex = 19
    let voltageEndIndex = voltageStartIndex + 60

    guard voltageEndIndex <= data.count else {
        print("Voltage data range is out of bounds.")
        return nil
    }
    
    let voltageData = Array(data[voltageStartIndex..<voltageEndIndex])

    let bluetoothData = BluetoothData2(
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
        START_CELL_ID: data[17],
        CELL_COUNT: data[18],
        VOLTAGE: voltageData,
        CRC: data[79],
        EOP: data[80]
    )

    return bluetoothData
}
