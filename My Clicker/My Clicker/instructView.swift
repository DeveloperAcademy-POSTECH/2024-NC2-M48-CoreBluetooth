//
//  instructView(1).swift
//  My Clicker
//
//  Created by 세린맥북 on 6/18/24.
//

import SwiftUI
import CoreBluetooth
import MediaPlayer
import AVFoundation
import AudioToolbox
import Combine


//@State var addViewSheet = false

struct customIndicator: View {
    var numberOfPages: Int
    var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.gray : Color.lightGray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 8)
    }
}

struct instructView: View {
    
    @State private var selectedPage = 0
    @State private var isSheetPresented = false
    @StateObject private var volumeButtonHandler = VolumeButtonHandler()
    @State private var showAlert = false
    
    var body: some View {
        
        VStack(alignment:.leading){
            
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.basicGreen)
                    .frame(width: 16, height: 16)
                    .padding(.leading,355)
            }
            .sheet(isPresented: $isSheetPresented){
                addSheet()
                    .presentationDragIndicator(.visible)
                
            }
            
            
            VStack(alignment:.leading){
                VStack(alignment:.leading){
//                    Text("MY Clicker!")
//                        .font(.system(size:20))
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(.basicGreen)
//                        .padding(.top, 20)
//                        .padding(.bottom, 5)
                    
                    
                    Text("연결에 성공하였습니다!")
                        .font(.system(size:30))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    //                        .padding(.bottom,52)
                }
                .padding(.leading,20)
                
                
                ZStack{
                    Image("phoneFrame")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 236, height: 417)
                        .padding(.leading,40)
                        .padding(.top, 30)
                        .padding(.bottom, 120)
                    Spacer()
                        .frame(height: 300)
                    
                    TabView (selection: $selectedPage) {
                        VStack{
                            Image("redAlram")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 160)
                                .padding(.bottom,175)
                            
                            Text("01 알림 소리")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            Text("마이클리커를 1 번 누르면\niPhone에서 알림 소리가 재생됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(0)
                        
                        VStack{
                            Image("yellowSplash")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 190, height: 190)
                                .padding(.bottom, 145)
                            
                            Text("02 반짝반짝 플래쉬")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            Text("마이클리커를 2 번 누르면\niPhone의 플래쉬도 반응하게 됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(1)
                        
                        VStack{
                            Button(action: {
                                showAlert = true
                            }) {
                                Image("greenVibration")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 190, height: 190)
                                    .padding(.bottom, 145)
                            }
                            
                            Text("03 진동소리")
                                .font(.system(size:20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.bottom, 10)
                            
                            
                            Text("마이클리커를 3 번 눌러주면\niPhone에서 진동도 함께 울리게 됩니다.")
                                .font(.system(size:14))
                                .foregroundColor(.lightGray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom,50)
                        .tag(2)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("My Clicker에서 아이폰 찾는중입니다."), message: Text("진동을 멈추려면 아래 버튼을 눌러주세요!"), dismissButton: .default(Text("찾음"),action: {
                                volumeButtonHandler.stopVibration()
                            }
                                                                                                                                           )
                            )
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .padding(.top, 112)
                    .frame(width: 350, height: 580)
                    .onAppear {
                        volumeButtonHandler.setupVolumeButtonHandling()
                    }
                    .onDisappear {
                        volumeButtonHandler.cleanup()
                    }
                    
                    
                }
                
            }
        }
        .padding (.top, 75)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        customIndicator(numberOfPages: 3, currentPage: selectedPage)
            .padding(.bottom, 80)
        
            .navigationBarBackButtonHidden(true)
        
    }
}

class VolumeButtonHandler: ObservableObject {
    @Published var message: String = "Press the Volume Up button"
    private var cancellables = Set<AnyCancellable>()
    private var lastVolumeChangeTime: Date?
    @State private var showAlert = false
    
    private var audioSession: AVAudioSession!
    private var initialVolume: Float = 0.5
    private var volumeObservation: NSKeyValueObservation?
    private var lastPressTime: Date?
    private let doublePressThreshold: TimeInterval = 0.5 // 더블 클릭 시간 간격
    private var pressTimes: [Date] = []
    private let triplePressThreshold: TimeInterval = 1.0 // 세 번 클릭 시간 간격
    private var vibrationTimer: Timer?
    private var isVibrating = false
    
    func setupVolumeButtonHandling() {
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(true)
            initialVolume = audioSession.outputVolume
            setupVolumeObservation()
        } catch {
            print("Failed to activate audio session: \(error)")
        }
    }
    
    private func setupVolumeObservation() {
        volumeObservation = audioSession.observe(\.outputVolume, options: [.new]) { [weak self] (audioSession, change) in
            if let newVolume = change.newValue {
                if newVolume > self?.initialVolume ?? 0.5 {
                    self?.handleVolumeUpButton()
                }
                self?.initialVolume = newVolume
            }
        }
    }
    
    private func handleVolumeUpButton() {
        print("Volume Up button pressed")
        // 알람 사운드 재생
        AudioServicesPlaySystemSound(SystemSoundID(1005)) // 1005는 알람 사운드 ID입니다
        let now = Date()
                
                if let lastPressTime = lastPressTime, now.timeIntervalSince(lastPressTime) < doublePressThreshold {
                    toggleFlashlight()
                }
                
                lastPressTime = now
        
        pressTimes.append(now)
                pressTimes = pressTimes.filter { now.timeIntervalSince($0) < triplePressThreshold }
                
                if pressTimes.count == 3 {
                    startVibration()
                    //showAlert = true
                    pressTimes.removeAll()
                }
//            .alert(isPresented: $showAlert) {
//                        Alert(title: Text("Alert"), message: Text("This is an alert!"), dismissButton: .default(Text("OK")))
//                    }
        
        // 메시지 업데이트
        DispatchQueue.main.async {
            self.message = "Volume Up button was pressed!"
        }
    }
    private func toggleFlashlight() {
            guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
                print("Device does not have a torch")
                return
            }
            
            do {
                try device.lockForConfiguration()
                if device.torchMode == .on {
                    device.torchMode = .off
                } else {
                    try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
                }
                device.unlockForConfiguration()
            } catch {
                print("Failed to toggle flashlight: \(error)")
            }
        }
    private func triggerVibration() {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            print("Vibration triggered")
        }
    
    private func startVibration() {
            guard !isVibrating else { return }
            isVibrating = true
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
        
    func stopVibration() {
            vibrationTimer?.invalidate()
            vibrationTimer = nil
            isVibrating = false
        }
    
    func cleanup() {
        volumeObservation?.invalidate()
        volumeObservation = nil
        
        do {
            try audioSession.setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }
    
}





#Preview {
    instructView()
}
