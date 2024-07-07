# 2024-NC2-M48-Core Bluetooth
## 🎥 Youtube Link
[(https://www.youtube.com/watch?v=N5hYvjOKR4s)]

![notionThumbnail](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M48-CoreBluetooth/assets/166346114/f7b0475c-6e43-4bfe-b99e-1fd0c80ceab3)


## 💡 About Core Bluetooth
LE ・ BR/EDR 방식의 블루투스 기기와 통신하기 위한 프레임워크
장치 검색 / 장치 연결 및 관리 / 데이터 교환
> Core Bluetooth에서 CBCentralManager는 블루투스를 제어하는 ios 디바이스 역할이고 CBPeripheral는 Central이 검색한 블루투스 주변기기들입니다.  

## 🎯 What we focus on?
> Core Bluetooth를 사용하여 인앱에서 블루투스 검색,페어링을 실행하고 싱글버튼 리모컨을 활용하여 아이폰의 다양한 액션을 수행합니다.
>
> 저희가 사용하려고 했던 블루투스 셀카봉 리모콘의 신호는 **sound volume up 기능에 할당**되어 있었습니다.

카메라 어플을 실행하고 리모컨의 버튼을 누르면 카메라가 찍히는 원리였지만 (볼륨업에 신호 할당), 어플을 실행했을 때 클릭 횟수에 맞게 그 신호를 **소리/플래쉬/진동**으로 바꿔 휴대폰을 찾을 수 있게 설정하였습니다.

## 💼 Use Case
> **"애플워치 유저"가 아닌 사람**이 한 공간에서 휴대폰을 분실했다!
애플워치 없이도 외부 기기를 사용해 휴대폰을 찾을 수 있게하자

## 🖼️ Prototype
![notionIcon](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M48-CoreBluetooth/assets/166346114/2dcf656f-6c29-45ce-b272-3b092273e467)
> MyClicker

## 🛠️ About Code
(핵심 코드에 대한 설명 추가)
