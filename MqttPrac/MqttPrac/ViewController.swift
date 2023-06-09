//
//  ViewController.swift
//  MqttPrac
//
//  Created by 문상우 on 2023/06/09.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    
    let defaultHost = "url"
    var mqtt5: CocoaMQTT5?
    var receivedMSG: String?
    let mqttClientID = UserDefaults.standard.string(forKey: "clientID") ?? "iOS-\(String(ProcessInfo().processIdentifier))"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mqttSetting()
    }
    
    private func mqttSetting() {
        // 클라이언트 식별자와 MQTT 브로커의 호스트 주소를 지정하여 CocoaMQTT 클라이언트 객체의 인스턴스를 생성, 연결을 위한 포트 번호도 제공
        mqtt5 = CocoaMQTT5(clientID: mqttClientID, host: defaultHost, port: 1883)
        // 클라이언트가 기록하는 디버깅 정보의 수준을 설정
        mqtt5!.logLevel = .debug
        // 'MqttConnectProperties' 인스턴스가 생성되고 해당 속성이 설정됨
        let connectProperties = MqttConnectProperties()
        // 주제 별칭이 사용되지 않음을 의미(0) <-> 1
        connectProperties.topicAliasMaximum = 0
        // 클라이언트 연결이 끊어진 후 세션이 지속되지 않음을 의미(0) <-> 1
        connectProperties.sessionExpiryInterval = 0
        // 클라이언트가 한 번에 최대 100개의 메시지를 수신할 수 있음을 의미
        connectProperties.receiveMaximum = 100
        // 최대 패킷 크기
        connectProperties.maximumPacketSize = 500
        mqtt5!.connectProperties = connectProperties
        // 브로커에 연결할 때 인증
        mqtt5!.username = "username"
        mqtt5!.password = "password"
        // 클라이언트가 브로커에서 예기치 않게 연결이 끊어지는 경우 특정 주제로 전송될 메시지를 지정
        //        let lastWillMessage = CocoaMQTT5Message(topic: "Lockdown from iOS/\(fcmToken!)", string: "iOS is LockDOWN!!")
        //         메세지타입
        //        lastWillMessage.contentType = "JSON"
        // 클라이언트가 브로커에서 예기치 않게 연결이 끊어지는 경우 게시할 주제의 경로
        //        lastWillMessage.willResponseTopic = "/Lockdown from iOS/"
        // 서버에서 지정한 최대 만료 간격에 도달할 때까지 메시지가 지속됨
        //        lastWillMessage.willExpiryInterval = .max
        // 메시지가 게시되기 전에 지연이 없음
        //        lastWillMessage.willDelayInterval = 0
        // 메세지 품질 설정
        //        lastWillMessage.qos = .qos1
        //        mqtt5!.willMessage = lastWillMessage
        let authProperties = MqttAuthProperties()
        mqtt5!.auth(reasonCode: CocoaMQTTAUTHReasonCode.continueAuthentication, authProperties: authProperties)
        // 클라이언트가 연결을 유지하기 위해 ping 요청을 보내기 전에 브로커의 응답을 기다려야 하는 최대 시간 간격(초)을 지정
        mqtt5!.keepAlive = 60
        // 현재 클래스(또는 객체)가 CocoaMQTT 클라이언트에서 생성된 이벤트 및 콜백을 처리하기 위한 대리자 역할
        mqtt5!.delegate = self
        _ = mqtt5!.connect()
    }
}

extension ViewController {
    
    func TRACE(_ message: String = "", fun: String = #function) {
        let names = fun.components(separatedBy: ":")
        var prettyName: String
        if names.count == 2 {
            prettyName = names[0]
        } else {
            prettyName = names[1]
        }
        if fun == "mqttDidDisconnect(_:withError:)" {
            prettyName = "didDisconnect"
        }
        print("[TRACE] [\(prettyName)]: \(message)")
    }
    
}

extension Optional {
    // Unwrap optional value for printing log only
    var description: String {
        if let self = self {
            return "\(self)"
        }
        return ""
    }
}

extension ViewController: CocoaMQTT5Delegate{
    
    // MQTT 클라이언트가 브로커로부터 연결 해제 이유를 나타내는 이유 코드와 함께 DISCONNECT 패킷을 수신할 때 호출됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveDisconnectReasonCode reasonCode: CocoaMQTTDISCONNECTReasonCode) {
        print("disconnect res : \(reasonCode)")
    }
    
    // MQTT 클라이언트가 인증 결과를 나타내는 이유 코드와 함께 브로커로부터 AUTH 패킷을 수신할 때 호출됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveAuthReasonCode reasonCode: CocoaMQTTAUTHReasonCode) {
        print("auth res : \(reasonCode)")
    }
    
    // Optional ssl CocoaMQTT5Delegate
    // MQTT 클라이언트가 SSL/TLS를 통해 브로커로부터 신뢰 시도를 수신할 때 호출되며, 서버를 신뢰할지 여부를 알리기 위해 제공된 completionHandler가 제공됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        TRACE("trust: \(trust)")
        completionHandler(true)
    }
    
    // MQTT 클라이언트가 성공적으로 브로커와의 연결을 설정할 때 호출되며 연결 확인 코드는 연결 설정 결과를 나타내고 connAckData는 추가 연결 속성을 제공
    func mqtt5(_ mqtt5: CocoaMQTT5, didConnectAck ack: CocoaMQTTCONNACKReasonCode, connAckData: MqttDecodeConnAck?) {
        TRACE("ack: \(ack)")
        if ack == .success {
            if(connAckData != nil){
                print("properties maximumPacketSize: \(String(describing: connAckData!.maximumPacketSize))")
                print("properties topicAliasMaximum: \(String(describing: connAckData!.topicAliasMaximum))")
            }
        }
    }
    
    // MQTT 클라이언트의 연결 상태가 새로운 상태로 변경될 때 호출됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didStateChangeTo state: CocoaMQTTConnState) {
        TRACE("new state: \(state)")
        switch state {
        case .disconnected:
            _ = mqtt5.connect()
        case .connected:
            print("연결 성공")
        default:
            print("연결 상태 확인중")
        }
        
    }
    
    // MQTT 클라이언트가 메시지 콘텐츠 및 게시된 메시지의 ID와 함께 브로커에 메시지를 성공적으로 게시할 때 호출됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishMessage message: CocoaMQTT5Message, id: UInt16) {
        TRACE("message: \(message.description), id: \(id)")
    }
    
    // MQTT 클라이언트가 브로커로부터 메시지가 브로커에 성공적으로 게시되었음을 나타내는 PUBACK 패킷을 수신할 때 호출됨
    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishAck id: UInt16, pubAckData: MqttDecodePubAck?) {
        TRACE("id: \(id)")
        if(pubAckData != nil){
            print("pubAckData reasonCode: \(String(describing: pubAckData!.reasonCode))")
        }
    }
    
    // MQTT 클라이언트가 브로커로부터 PUBREC 패킷을 수신할 때 호출되며, 이는 메시지가 브로커에 의해 수신되었고 의도된 수신자에게 전달하기 위해 저장되었음을 나타냄
    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishRec id: UInt16, pubRecData: MqttDecodePubRec?) {
        TRACE("id: \(id)")
        if(pubRecData != nil){
            print("pubRecData reasonCode: \(String(describing: pubRecData!.reasonCode))")
        }
    }
    
    // MQTT 클라이언트가 브로커로부터 PUBCOMP 패킷을 수신할 때 호출되어 메시지가 의도한 수신자에게 성공적으로 전달되었음을 나타냄
    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishComplete id: UInt16,  pubCompData: MqttDecodePubComp?){
        TRACE("id: \(id)")
        if(pubCompData != nil){
            print("pubCompData reasonCode: \(String(describing: pubCompData!.reasonCode))")
        }
    }
    
    // MQTT 클라이언트가 브로커로부터 메시지를 수신할 때 호출됨
    // 메시지 내용 및 수신된 메시지의 ID와 수신된 메시지의 추가 속성을 제공하는 publishData 메시지
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveMessage message: CocoaMQTT5Message, id: UInt16, publishData: MqttDecodePublish?) {
        if let publishData = publishData {
            print("publish.contentType \(String(describing: publishData.contentType))")
        }
        TRACE("message: \(message.string.description)")
 
    }
    
    // MQTT 클라이언트가 브로커에서 하나 이상의 주제를 성공적으로 구독할 때 호출되며 success 사전은 구독된 각 주제의 QoS 수준을 나타내고 failed는 구독에 실패한 주제의 이름을 포함하는 배열 및 추가 구독 속성을 제공하는 'subAckData'.
    func mqtt5(_ mqtt5: CocoaMQTT5, didSubscribeTopics success: NSDictionary, failed: [String], subAckData: MqttDecodeSubAck?) {
        TRACE("subscribed: \(success), failed: \(failed)")
        if(subAckData != nil){
            print("subAckData.reasonCodes \(String(describing: subAckData!.reasonCodes))")
        }
    }
    
    // MQTT 클라이언트가 성공적으로 브로커의 하나 이상의 주제에서 구독을 취소할 때 호출됩니다. topics 배열에는 구독 취소된 주제의 이름이 포함되고 UnsubAckData는 추가 구독 취소를 제공
    func mqtt5(_ mqtt5: CocoaMQTT5, didUnsubscribeTopics topics: [String], UnsubAckData: MqttDecodeUnsubAck?) {
        TRACE("topic: \(topics)")
        if(UnsubAckData != nil){
            print("UnsubAckData.reasonCodes \(String(describing: UnsubAckData!.reasonCodes))")
        }
        print("----------------------")
    }
    
    // MQTT 클라이언트가 keep-alive 메커니즘의 일부로 브로커에 PINGREQ 패킷을 보낼 때 호출됨
    func mqtt5DidPing(_ mqtt5: CocoaMQTT5) {
        TRACE()
    }
    
    // MQTT 클라이언트가 브로커로부터 PINGREQ 패킷에 대한 응답으로 PINGRESP 패킷을 수신할 때 호출됨
    func mqtt5DidReceivePong(_ mqtt5: CocoaMQTT5) {
        TRACE()
    }
    
    // MQTT 클라이언트가 브로커에서 연결 해제될 때 호출되며 연결 해제 이유를 나타내는 선택적 err ->> 여기에서 재연결 설정을 해야함 ->> 특정 메세지를 전역 변수에 저장해서 그 메세지가 있을 때만 다시 실행되도록 설정
    func mqtt5DidDisconnect(_ mqtt5: CocoaMQTT5, withError err: Error?) {
        TRACE("\(err.description)")
    }
    
}
