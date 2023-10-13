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
