## Framework Integration
# Creating a watchOS App

이 tutorial은 SwiftUI에 대해 이미 배운 것을 많이 적용할 수 있는 기회를 제공하고 약간의 노력으로 Landmarks 앱을 watchOS로 이행할 수 있다.

iOS 앱 용으로 만든 공유 데이터와 뷰를 복샇가ㅣ 전에 먼저 watchOS 대상을 프로젝트에 추가한다.
모든 assets이 제자리에 있으면 SwiftUI 뷰를 설정하여 watchOS에 세부 정보 및 목록 뷰를 표시한다.

### Section 1
## Add a watchOS Target

<p align="center">
    <img width="388" src="https://user-images.githubusercontent.com/60697742/132153851-9c425057-c12e-475b-a77a-0666bf00d91c.png">
</p>

watchOS 앱을 만들기 위해서 먼저 watchOS 대상을 프로젝트에 추가한다.
Xcode는 watchOS 앱에 대한 그룹 및 파일을 앱 빌드와 실행에 필요한 체계와 함께 프로젝트에 추가한다.

**Step 1** <br>
File > New > Target을 선택한다.
템플릿 시트가 나타나면 watchOS 탭을 선택하고 Watch App for iOS App 템플릿을 선택한 후 Next를 누른다.
이 템플릿은 iOS 앱을 동행하도록 설정하여 프로젝트에 새로운 watchOS 앱을 추가한다.

**Step 2** <br>
시트에서 제품 이름으로 WatchLandmarks를 입력한다.
Interface를 SwiftUI로, LifeCycle을 SwiftUI App으로, Language를 Swift로 설정한다.
Include Notification Scene 확인란을 선택한 다음 Finish를 누른다.

**Step 3** <br>
Xcode에서 WatchLandmarks(Complication) 구성표를 활성화하라는 메시지가 표시되면 Cancel을 누른다.
대신 다음에 선택하는 WatchLandmarks 구성표로 시작하고 싶을 것이다.

**Step 4** <br>
WatchLandmarks 구성표를 선택한다.
이를 통해 watchOS 앱을 빌드하고 실행할 수 있다.

**Step 5** <br>
WatchLadmarks Extension 프로젝트를 선택하고 프로젝트의 일반 탭으로 이동한다.
Supports Running Without iOS App Installation 확인란을 선택한다.
가능하면 독립적인 watchOS 앱을 만든다.
독립적인 watchOS 앱에는 iOS 동반 앱이 필요하지 않다.

### Section 2
## Share Files Between Targets

<p align="center">
    <img width="388" src="https://user-images.githubusercontent.com/60697742/132154757-73c767f5-2305-4f5d-8f2f-5d58ecbf98ef.png">
</p>

watchOS 대상이 설정되면 iOS 대상에서 일부 자원을 공유해야 한다.
Landmark 앱의 데이터 모델, 일부 리소스 파일 및 두 플랫폼 수정 없이 표시할 수 있는 모든 뷰를 재사용한다.

먼저 watchOS 앱의 진입점을 삭제한다.
LandmarksApp.swift에 정의된 진입점을 대신 재활용할 것이기 때문에 필요하지 않다.

**Step 1** <br>
프로젝트 네비게이터에서 WatchLandmarks Extension 폴더의 첫 번째 항목을 삭제한다.
메시지가 표시되면 휴지통으로 이동을 선택한다.
이 파일에는 Watch 관련 앱 정의가 있다.
이름은 Xcode 프로젝트 이름에 따라 다르지만 항상 WatchLandmarks Extension 그룹의 첫 번째 항목이다.
다음 몇 단계에서 대신 iOS 앱 정의를 재사용한다.

다음으로 watchOS 대상이 기존 iOS 대상과 공유할 수 있는 앱의 진입점을 포함하여 모든 파일을 선택한다.

**Step 2** <br>
프로젝트 네비게이터에서 다음 파일을 Command-클릭하여 선택한다. :
    LandmarksApp.swift, LandmarkList.swift, LandmarkRow.swift, CircleImage.swift, MapView.swift.
첫 번째는 공유 앱 정의이다.
나머지는 앱이 변경 없이 watchOS에 표시할 수 있는 뷰이다.

**Step 3** <br>
계속 Command-클릭하여 ModelData.swift, Landmark.swift, Hike.swift, Profile.swift 모델 파일을 추가한다.
이러한 항목은 앱의 데이터 모델을 정의한다.
모델의 모든 측면을 사용하지는 않겠지만 앱을 성공적으로 컴파일하려면 모든 파일이 필요하다.

**Step 4** <br>
모델에서 로드한 리소스 파일 (landmarkData.json, hikeData.json, and Assets.xcassets)을 추가하려면 Command-클릭하여 완료한다.

**Step 5** <br>
파일 속성에서 Target Membership 섹션의 WatchLandmarks Extension 확인란을 선택한다.
이렇게 하면 이전 단계에서 선택한 기호를 watchOS 앱에서 사용할 수 있다.

마지막으로 이미 가지고 있는 iOS 앱 아이콘과 일치하는 watchOS 앱 아이콘을 추가한다.

**Step 6** <br>
WatchLandmarks 폴더에서 Assets.xcasset 파일을 선태하고 빈 AppIcon 항목을 삭제한다.
다음 단계에서 이것을 교체한다.

**Step 7** <br>
다운로드한 프로젝트의 Resources 폴더에서 AppIcon.appiconset 폴더를 WatchLandamrk의 Asset 카탈로그로 드래그한다.
나중에 알림을 생성하면 시스템에서 알림의 출처를 식별하는데 도움이 되도록 앱 아이콘을 표시한다.

### Section 3
## Create the Detail View

<p align="center">
    <img width="185" src="https://user-images.githubusercontent.com/60697742/132155768-b2f3f40f-cd37-4aa0-8a62-bbb4b1a340f0.png">
</p>

이제 iOS 대상 리소스가 시계 앱 작업을 위해 준비되었으므로 landmark 세부 정보를 표시하기 위한 시계 전용 뷰를 만들어야 한다.
상세 뷰를 테스트하기 위해 가장 큰 시계 크기와 가장 작은 시계 크기에 대한 사용자 정의 미리보기를 만들고 모든 것이 시계 화면에 맞도록 원형 보기를 약간 변형한다.

**Step 1** <br>
LandmarkDetail.swift라는 WatchLandmarks Extension 폴더에 새로운 사용자 지정 뷰를 추가한다.
이 파일은 대상 멤버십에 의해 iOS 프로젝트에서 동일한 이름을 가진 파일과 구별된다.
이는 Watch Extension 대상에만 적용된다.

**Step 2** <br>
modelData, landmark 및 landmarkIndex 속성을 새 LandmarkDetail 구조에 추가한다.
Handling User Input에서 추가한 속성과 동일하다.

```swift
struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        Text("Hello, World!")
    }
}
```

**Step 3** <br>
미리보기에서 모델 데이터의 인스턴스를 만들고 이를 사용하여 LandmarkDetail 구조의 initializer에 landmark 개체를 전달한다.
또한 뷰의 환경 개체를 설정해야 한다.

```swift
struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        return LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
```

**Step 4** <br>
body() 메서드에서 CircleImage 뷰를 반환한다.
여기에서 iOS 프로젝트의 CircleImage 뷰를 재사용한다.
크기 조정이 가능한 이미지를 만들었기 때문에 scaledToFill() 호출은 화면을 채우도록 원의 크기를 조정한다.

```swift
var body: some View {
    CircleImage(image: landmark.image.resizable())
        .scaledToFill()
}
```

**Step 5** <br>
가장 큰 시계 모드(44mm)와 가장 작은 시계 모드(40mm)에 대한 미리보기를 만든다.
가장 큰 시계 모드와 가작 작은 시계 모드에 대해 테스트하여 앱의 디스플레이에 맞게 얼마나 잘 확장되는지 확인할 수 있다.
항상 그렇듯이 지원되는 모든 장치 크기에서 사용자 인터페이스를 테스트해야 한다.

```swift
struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        return Group {
            LandmarkDetail(landmark: modelData.landmarks[0])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 5 - 44mm")

            LandmarkDetail(landmark: modelData.landmarks[1])
                .environmentObject(modelData)
                .previewDevice("Apple Watch Series 5 - 40mm")
        }
    }
}
```

원 이미지는 화면을 채우도록 크기가 조정된다.
불행히도, 이로 인해 출력에 문제가 발생한다.
출력 문제를 해결하려면 VStack에 이미지를 포함하고 원형 이미지가 모든 시계에 맞도록 레이아웃을 추가로 변경한다.

**Step 6** <br>
VStack에 원 이미지를 포함한다.
이미지 아래에 랜드마크 이름과 해당 정보를 표시한다.
보다시피 정보가 시계 화면에 잘 맞지 않지만 스크롤 뷰 내에 VStack을 배치하여 수정할 수 있다.

```swift
var body: some View {
    VStack {
        CircleImage(image: landmark.image.resizable())
            .scaledToFill()
            
        Text(landmark.name)
            .font(.headline)
            .lineLimit(0)

        Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
            Text("Favorite")
        }

        Divider()

        Text(landmark.park)
            .font(.caption)
            .bold()
            .lineLimit(0)

        Text(landmark.state)
            .font(.caption)
    }
}
```

**Step 7** <br>
스크롤 뷰에서 VStack을 감싼다.
이렇게 하면 뷰 스크롤이 켜지지만 다른 문제가 발생한다.
이제 원 이미지가 전체 크기로 확장되고 이미지 크기에 맞게 다른 UI 요소의 크기가 조정된다.
원과 랜드마크 이름만 화면에 나타나도록 원 이미지의 크기를 조정해야 한다.

```swift
var body: some View {
    ScrollView {
        VStack {
            CircleImage(image: landmark.image.resizable())
                .scaledToFill()

            Text(landmark.name)
                .font(.headline)
                .lineLimit(0)

            Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                Text("Favorite")
            }

            Divider()

            Text(landmark.park)
                .font(.caption)
                .bold()
                .lineLimit(0)

            Text(landmark.state)
                .font(.caption)
        }
    }
}
```

**Step 8** <br>
scaleToFill()을 scaleToFit()으로 변경하고 padding을 추가한다.
이렇게 하면 화면의 너비와 일치하도록 원 이미지의 크기가 조정되고 랜드마크 이름이 원 이미지 아래에 표시된다.

```swift
var body: some View {
    ScrollView {
        VStack {
            CircleImage(image: landmark.image.resizable())
                .scaledToFit()

            Text(landmark.name)
                .font(.headline)
                .lineLimit(0)

            Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                Text("Favorite")
            }

            Divider()

            Text(landmark.park)
                .font(.caption)
                .bold()
                .lineLimit(0)

            Text(landmark.state)
                .font(.caption)
        }
        .padding(16)
    }
}
```

**Step 9** <br>
구분선 뒤에 MapView를 추가한다.
지도가 화면 밖에 나타나지만 실시간 미리보기를 활성화하면 아래로 스크롤하여 지도를 볼 수 있다.

```swift
var body: some View {
    ScrollView {
        VStack {
            CircleImage(image: landmark.image.resizable())
                .scaledToFit()

            Text(landmark.name)
                .font(.headline)
                .lineLimit(0)

            Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                Text("Favorite")
            }

            Divider()

            Text(landmark.park)
                .font(.caption)
                .bold()
                .lineLimit(0)

            Text(landmark.state)
                .font(.caption)

            Divider()

            MapView(coordinate: landmark.locationCoordinate)
                .scaledToFit()
        }
        .padding(16)
    }
}
```

**Step 10** <br>
뒤로가기 버튼에 제목을 추가한다.
이렇게하면 뒤로가기 버튼의 텍스트가 "Landmarks"로 설정된다.

```swift
var body: some View {
    ScrollView {
        VStack {
            CircleImage(image: landmark.image.resizable())
                .scaledToFit()

            Text(landmark.name)
                .font(.headline)
                .lineLimit(0)

            Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                Text("Favorite")
            }

            Divider()

            Text(landmark.park)
                .font(.caption)
                .bold()
                .lineLimit(0)

            Text(landmark.state)
                .font(.caption)

            Divider()

            MapView(coordinate: landmark.locationCoordinate)
                .scaledToFit()
        }
        .padding(16)
    }
    .navigationTitle("Landmarks")
}
```

### Section 4
## Add the Landmarks List

<p align="center">
    <img width="338" src="https://user-images.githubusercontent.com/60697742/132157853-01e317e7-50dc-4b5a-840b-50477360535b.png">
</p>

iOS 용으로 생성한 LandmarkList는 시계 앱에서도 작동하며, watchOS 용으로 컴파일할 때 방금 생성한 상세 뷰로 시계별로 자동으로 이동한다.
다음으로 목록을 시계의 ContentView에 연결하여 시계 앱의 최상위 뷰 역할을 한다.

**Step 1** <br>
WatchLandmarks Extension 폴더에서 ContentView.swift를 선택한다.
LandmarkDetail.swift와 마찬가지로 watchOS 타겟에 대한 콘텐츠 뷰는 iOS 타켓에 대한 것과 동일한 이름을 갖는다.
이름과 인터페이스를 동일하게 유지하면 대상 간에 파일을 쉽게 공유할 수 있다.

watchOS 앱의 루트 뷰는 기본 "Hellp, World!" 메시지를 표시한다.

**Step 2** <br>
목록 뷰를 표시하도록 ContentView를 수정한다.
미리보기에 환경 개체로 모델 데이터를 제공해야 한다.
LandmarksApp은 이미 iOS에서와 마찬가지로 런타임에 앱 수준에서 이를 제공하지만 이를 필요로 하는 모든 미리보기에도 제공해야 한다.

```swift
struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
```

**Step 3** <br>
실시간 미리보기를 시작하여 앱이 어떻게 작동하는지 확인한다.

### Section 5
## Create a Custom Notification Interface

<p align="center">
    <img width="338" src="https://user-images.githubusercontent.com/60697742/132158350-4a9081cf-ef8a-4da2-8f1b-4fd4297293e6.png">
</p>

watchOS 용 Landmarks 버전이 거의 완성되었다.
이 마지막 섹션에서는 즐겨찾는 위치 중 하나에 가깝다는 알림을 받을 때마다 랜드마크 정보를 표시하는 알림 인터페이스를 만든다.

이 sectino에서는 알림을 받은 후 알림을 표시하는 방법에 대해서만 설명한다.
알림을 설정하거나 보내는 방법은 설명하지 않는다.

**Step 1** <br>
NotificationView.swift를 열고 landmark, 제목 및 메시지에 대한 정보를 표시하는 뷰를 만든다.
모든 알림 값이 nil일 수 있으므로 미리보기에는 두 가지 버전의 알림 뷰가 표시된다.
첫 번째는 데이터가 제공되지 않은 경우 기본 값을 표시하고 두 번째는 제공한 제목, 메시지 및 위치를 표시한다.

```swift
struct NotificationView: View {
    var title: String?
    var message: String?
    var landmark: Landmark?

    var body: some View {
        VStack {
            if landmark != nil {
                CircleImage(image: landmark!.image.resizable())
                    .scaledToFit()
            }

            Text(title ?? "Unknown Landmark")
                .font(.headline)

            Divider()

            Text(message ?? "You are within 5 miles of one of your favorite landmarks.")
                .font(.caption)
        }
        .lineLimit(0)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationView()
            NotificationView(title: "Turtle Rock",
                             message: "You are within 5 miles of Turtle Rock.",
                             landmark: ModelData().landmarks[0])
        }
    }
}
```

**Step 2** <br>
NotificationController를 열고 landmark, 제목 및 메시지 속성을 추가한다.
이러한 속성은 수신 알림에 대한 값을 저장한다.

```swift
var landmark: Landmark?
var title: String?
var message: String?
```

**Step 3** <br>
이러한 속성을 사용하려면 body() 메서드를 업데이트한다.
이 메서드는 이전에 만든 알림 뷰를 인스턴스화한다.

```swift
override var body: NotificationView {
    NotificationView(
        title: title,
        message: message,
        landmark: landmark
    )
}
```

**Step 4** <br>
LandmarkIndexKey를 정의한다.
이 키를 사용하여 알림에서 landmark 인덱스를 추출한다.

```swift
let landmarkIndexKey = "landmarkIndex"
```

**Step 5** <br>
알림에서 데이터를 구문 분석하도록 didReceive(_:) 메서드를 업데이트한다.
이 메서드는 컨트롤러의 속성을 업데이트한다.
이 메서드를 호출하면 시스템이 컨트롤러의 body 속성을 무효화하여 네비게이션 뷰를 업데이트한다.
그러면 시스템이 Apple Watch에 알림을 표시한다.

```swift
override func didReceive(_ notification: UNNotification) {
    let modelData = ModelData()

    let notificationData =
        notification.request.content.userInfo as? [String: Any]

    let aps = notificationData?["aps"] as? [String: Any]
    let alert = aps?["alert"] as? [String: Any]

    title = alert?["title"] as? String
    message = alert?["body"] as? String

    if let index = notificationData?[landmarkIndexKey] as? Int {
        landmark = modelData.landmarks[index]
    }
}
```

Apple Watch는 알림을 수신하면 알림 카테고리와 연결된 앱의 장면을 찾는다.

**Step 6** <br>
LandmarksApp.swift로 이동하여 LandmarkNear 카테고리를 사용하여 WKNotificationScene을 추가한다.
장면은 watchOS에서만 의미가 있으므로 조건부 컴파일을 추가한다.

```swift
#if os(watchOS)
WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
#endif
```

LandmarkNear 카테고리를 사용하고 알림 컨트롤러에서 예상하는 데이터를 전달하도록 테스트 페이로드를 구성한다.

**Step 7** <br>
PushNotificationPayload.apns 파일을 선택하고 제목, 본문, 카테고리 및 LandmarkIndex 속성을 업데이트한다.
카테고리를 LandmarkNear로 설정해야 한다.
subtitle, WatchKit Simulator Actions 및 customKey와 같이 tutorial에서 사용되지 않는 키도 삭제한다.
페이로드 파일은 서버에서 보낸 데이터를 원격 알림에서 시뮬레이션한다.

```swift
{
    "aps": {
        "alert": {
            "title": "Silver Salmon Creek",
            "body": "You are within 5 miles of Silver Salmon Creek."
        },
        "category": "LandmarkNear",
        "thread-id": "5280"
    },

    "landmarkIndex": 1,

    "WatchKit Simulator Actions": [
        {
            "title": "First Button",
            "identifier": "firstButtonAction"
        }
    ],

    "customKey": "Use this file to define a testing payload for your notifications. The aps dictionary specifies the category, alert text and title. The WatchKit Simulator Actions array can provide info for one or more action buttons in addition to the standard Dismiss button. Any other top level keys are custom payload. If you have multiple such JSON files in your project, you'll be able to select them when choosing to debug the notification interface of your Watch App."
}
```

**Step 8** <br>
Landmarks-Watch (Notification) 체계를 선택하고 앱을 빌드하고 실행한다.
알림 체계를 처음 실행하면 시스템에서 알림을 보낼 수 있는 권한을 요청한다.
Allow를 선택한다.

**Step 9** <br>
권한을 부여한 후 시뮬레이터는 Landmarks 앱을 발신자로 식별하는 데 도움이 되는 앱 아이콘, 알림 뷰 및 알림 작업에 대한 버튼을 포함하는 스크롤 가능한 알림을 표시한다.