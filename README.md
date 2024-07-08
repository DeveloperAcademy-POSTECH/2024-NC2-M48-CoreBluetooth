# 2024-NC2-M48-Core Bluetooth
## 🎥 Youtube Link
https://www.youtube.com/watch?v=N5hYvjOKR4s

![notionThumbnail](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M48-CoreBluetooth/assets/166346114/f7b0475c-6e43-4bfe-b99e-1fd0c80ceab3)


## 💡 About Core Bluetooth
LE ・ BR/EDR 방식의 블루투스 기기와 통신하기 위한 프레임워크
장치 검색 / 장치 연결 및 관리 / 데이터 교환
> Core Bluetooth에서 CBCentralManager는 블루투스를 제어하는 ios 디바이스 역할이고 CBPeripheral는 Central이 검색한 블루투스 주변기기들입니다.  

## 🎯 What we focus on?
> Core Bluetooth를 사용하여 인앱에서 블루투스 검색,페어링을 실행하고 싱글버튼 리모컨을 활용하여 아이폰의 다양한 액션을 수행합니다.
>
> 저희가 사용하려고 했던 블루투스 셀카봉 리모콘의 신호는 **sound volume up 기능에 할당**되어 있었습니다.

> 카메라 어플을 실행하고 리모컨의 버튼을 누르면 카메라가 찍히는 원리였지만 (볼륨업에 신호 할당), 어플을 실행했을 때 클릭 횟수에 맞게 그 신호를 **소리/플래쉬/진동**으로 바꿔 휴대폰을 찾을 수 있게 설정하였습니다.

## 💼 Use Case
> **"애플워치 유저"가 아닌 사람**이 한 공간에서 휴대폰을 분실했다!
애플워치 없이도 외부 기기를 사용해 휴대폰을 찾을 수 있게하자

## 🖼️ Prototype
> MyClicker
![gggggg](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M48-CoreBluetooth/assets/166346114/d5502ce7-60e4-40bd-8669-b598b6053c58)
> > **MyClicker**는 애플워치 없이도 나의 아이폰 찾기 기능을 할 수 있도록 외부 기기와 Bluetooth기능으로 연결하여 사용할 수 있는 앱니다.
> 

1. 사용자는 어플을 실행하여 블루투스를 실행합니다.
2. 어플내에서 Clicker 기기를 아이폰에 연결합니다.
3. 클릭 횟수에 맞는 휴대폰 알림 기능정보를 확인할 수 있습니다.

<aside>
👀 Action 01 - 리모컨 1번 클릭 - 나의 휴대폰 찾기 알림이 울린다

👀 Action 02 - 리모컨 2번 클릭 - 휴대폰 플래쉬도 반짝거린다 (어두운 방에서도 휴대폰을 찾을 수 있음)

👀 Action 03 - 리모컨 3번 클릭 - 진동도 함께 울린다
</aside>

1. 각 기능이 실행되면 휴대폰에서 alert창이 뜨게 되며, 휴대폰 발견시 확인 버튼을 눌러 알림을 끌 수 있습니다.
2. 이외에도 사용자가 **커스텀하여 액션과 연결된 기능을 설정**할 수 있게합니다.

## 🛠️ About Code

```ruby
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
```
> Core Bluetooth의 기능을 사용하기위한 함수들을 정의한 클래스의 변수와 초기 설정
```ruby
 func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown") at \(RSSI)")
        if let name = peripheral.name, !name.hasPrefix(excludedNamePrefix), !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            discoveredPeripherals.append(peripheral)
        }
    }
```
> Central의 블루투스 기능을 사용하여 peripheral을 검색하여 로그를 출력하는 함수
```ruby
List {
                        Section(header: Text("MY DEVICES").padding(.top, -10).padding(.leading, -13).bold()) {
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
```
> Central에서 검색한 Peripherals들을 List로 목록화 해서 뷰에 출력
```ruby
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
```
> 연결한 리모컨의 버튼이 기본적으로 볼륨업에 할당되고 고정되어있어 볼륨업 버튼의 동작을 추적하여 클릭 횟수에 따른 구분을 하기위한 volumbuttonhandler클래스의 변수들과 초기 설정
