//
//  temBluetooth.swift
//  My Clicker
//
//  Created by 세린맥북 on 6/20/24.
//

import SwiftUI
import CoreBluetooth
import MediaPlayer
import AVFoundation
import AudioToolbox
import Combine

//struct temBluetooth: View {
//    var body: some View {
//        
//        NavigationView{
//            
//            VStack(alignment: .leading){
//                Text("MY Clicker!")
//                    .foregroundColor(.basicGreen)
//                    .font(.system(size:20))
//                    .fontWeight(.bold)
//                Text("Bluetooth 연결하기")
//                    .font(.system(size:30))
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                Text("MY DEVICES")
//                    .font(.system(size:14))
//                
//                Spacer()
//                    .frame(height: 100)
//                
//                Text("확인")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
//                    .padding([.vertical], 18)
//                    .padding([.horizontal],161)
//                    .background{
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.lightGray)
//                    }
//                NavigationLink(destination: instructView()){
//                    Text("확인")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
//                        .padding([.vertical], 18)
//                        .padding([.horizontal],161)
//                        .background{
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.basicGreen)
//                        }
//                }
//            }
//        }
//
//        
//        
//        
//        
//        
//            .navigationBarBackButtonHidden(true)
//    }
//}
struct temBluetooth: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    //@StateObject private var volumeButtonHandler = VolumeButtonHandler()

    var body: some View {
        VStack(alignment: .leading){
            Text("MY Clicker!")
                .foregroundColor(.green)
                .font(.system(size: 20))
                .bold()
                .padding(EdgeInsets(top: 15, leading: 17, bottom: 0, trailing: 0))
            NavigationStack {
                VStack {
                    List {
                        Section(header: Text("MY DEVICES").padding(.top, -10).padding(.leading, -20).bold()) {
                            ForEach(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
                                Button(action: {
                                    bluetoothManager.connectPeripheral(peripheral)
                                }) {
                                    Text(peripheral.name ?? "Unknown")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .listRowBackground(Color.fog)
                    }
                    .padding(.top, -30)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Bluetooth 연결하기")
                                .font(.system(size: 30))
                                .bold()
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    if bluetoothManager.connectedPeripheral != nil {
                        Button(action: {}, label: {
                            NavigationLink(destination: instructView()) {
                                Text("확인")
                                    .frame(width: 353, height: 50)
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                    .background(
                                        Rectangle()
                                            .frame(width: 353, height: 50)
                                            .foregroundStyle(Color.basicGreen)
                                            .cornerRadius(8.0)
                                    )
                            }})
                        //                    VStack {
                        //                                Text("Connected to \(connectedPeripheral.name ?? "Unknown")")
                        //                                    .padding()
                        //                                Text(bluetoothManager.buttonState)
                        //                                    .padding()
                        //                                    .foregroundColor(.green)
                        //                                Text(volumeButtonHandler.message)
                        //                                    .padding()
                        //                                Text("stop vibration")
                        //                                    .onTapGesture {
                        //                                        volumeButtonHandler.stopVibration()
                        //                                    }
                        //                            }
                        //                            .onAppear {
                        //                                volumeButtonHandler.setupVolumeButtonHandling()
                        //                            }
                        //                            .onDisappear {
                        //                                        volumeButtonHandler.cleanup()
                        //                                    }
                    }
                    else {Button(action: {}, label: {
                        Text("확인")
                            .frame(width: 353, height: 50)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .background(
                                Rectangle()
                                    .frame(width: 353, height: 50)
                                    .foregroundStyle(Color.fog)
                                    .cornerRadius(8.0)
                            )
                    })
                    .disabled(true)
                    }
                }
            }
            //.padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
        }
    }
}

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var connectedPeripheral: CBPeripheral?
    @Published var buttonState: String = "Button State: Unknown"
    
    let excludedNamePrefix = "액세서리"
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth is powered on.")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth is not available.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown") at \(RSSI)")
        if let name = peripheral.name, !name.hasPrefix(excludedNamePrefix), !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func connectPeripheral(_ peripheral: CBPeripheral) {
        print("Connecting to \(peripheral.name ?? "Unknown")")
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
        peripheral.delegate = self
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown")")
        connectedPeripheral = peripheral
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("Discovered service: \(service.uuid)")
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Discovered characteristic: \(characteristic.uuid)")
                if characteristic.properties.contains(.notify) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            print("Received data on \(characteristic.uuid): \(data)")
            let buttonState = parseButtonState(from: data)
            DispatchQueue.main.async {
                self.buttonState = "Button State: \(buttonState)"
            }
            logButtonEvent(data: data)
        }
    }
    
    private func parseButtonState(from data: Data) -> String {
        // 리모컨 데이터 형식에 맞게 파싱
        return String(data: data, encoding: .utf8) ?? "Unknown"
    }
    
    private func logButtonEvent(data: Data) {
        // 리모컨 버튼 이벤트를 로깅하는 메서드
        if let buttonEvent = String(data: data, encoding: .utf8) {
            print("Button event: \(buttonEvent)")
        } else {
            print("Received unknown button event data: \(data)")
        }
    }
}
#Preview {
    temBluetooth()
}
