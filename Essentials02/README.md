## SwiftUI Essentials
# Building Lists and Navigation

기본 landmark detail 뷰가 설정되면 사용자가 전체 landmark 목록을 보고 각 위치에 대한 세부정보를 볼 수 있는 방법을 제공해야 한다.

모든 landmark에 대한 정보를 보여주는 뷰를 만들고 사용자가 landmark에 대한 detail 뷰를 보기 위해 탭할 수 있는 스크롤 목록을 동적으로 생성한다.
UI를 미세 조정하기 위해 Xcode의 캔버스를 사용하여 다양한 장치의 크기에서 여러 미리보기를 렌더링한다.

### Section 1
## Create a Landmark Model
첫 번째 tutorial에서 모든 설정된 뷰에 하드 코딩하여 정보를 넣었다.
이번에는 뷰에 전달할 수 있는 데이터를 저장하는 모델을 만들 것이다.

<p align="center">
    <img width="455" src="https://user-images.githubusercontent.com/60697742/129457110-854f1f6d-220f-455c-836e-0d6ea9eefc68.png">
</p>

**Step 1** <br>
LandmarkData.json을 프로젝트의 탐색 창으로 드래그한다.
나타난 대화상자에서 “Copy items if needed”를 선택하고 Landmarks를 선택한 후 마친다.
이 tutorial에서 나머지 부분과 이후의 모든 작업에서 이 샘플 데이터를 사용한다.

**Step 2** <br>
File > New > File을 선택한 후 Landmark.swift 이름의 새로운 파일을 생성한다.

**Step 3** <br>
landmarkData.json 데이터 파일에 있는 일부 키의 이름과 일치하는 몇 가지 속성으로 Landmark의 구조를 정의한다.
Codable 적합성을 추가하면 이 섹션 뒷부분에서 수행할 데이터 파일 구조로 데이터를 더 쉽게 로드할 수 있다.

```swift
struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
}
```

다음 몇 단계에서는 각 landmark와 연결된 이미지를 모델링한다.

**Step 4** <br>
JPG 파일을 프로젝트의 asset 카탈로그로 드래그한다.
Xcode는 각 이미지에 대해 새로운 이미지 세트를 생성한다.
이전 tutorial에서 추가한 Turtle Rock에 대한 이미지와 새 이미지가 결합된다.

**Step 5** <br>
imageName 속성을 추가하여 데이터에서 이미지 이름을 읽고 asset 카탈로그에서 이미지를 로드하는 계산된 이미지 속성을 추가한다.
Landmark 구조는 이미지 자체만을 다루기 때문에 속성을 private로 설정한다.

```swift
struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String

    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
```

다음으로 landmark의 위치에 대한 정보를 관리한다.

**Step 6** <br>
JSON 데이터 구조의 저장소를 반영하는 중첩된 coordinate 유형을 사용하여 구조에 coordinate 속성을 추가한다.
다음 단계에서 public 속성을 생성하는 데에만 사용할 것이기 때문에 이 속성을 private로 표시한다.

```swift
private var coordinates: Coordinates

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
```

**Step 7** <br>
MapKit 프레임워크와 상호작용하는 데 유용한 locationCoordinate 속성을 계산한다.

```swift
var locationCoordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude
    )
}
```

마지막으로, 파일의 landmark로 초기화된 배열을 생성한다.

**Step 8** <br>
프로젝트에 Swift 파일을 생성하고 ModelData.swift라 이름을 지정한다.

**Step 9** <br>
앱의 메인 번들에서 지정된 이름의 JSON 데이터를 가져오는 load(_:) 메서드를 생성한다.
load 메서드는 반환 형식이 Codable 프로토콜을 준수하는지의 여부에 의존한다.

**Step 10** <br>
LandmarkData.json에서 초기화하는 landmark 배열을 생성한다.

계속 진행하기 전에, 관련 파일을 그룹화하여 프로젝트를 더 쉽게 관리할 수 있다.

**Step 11** <br>
ContentView.swift, CircleImage.swift, MapView.swift는 Views 그룹에, landmarkData.json은  Resources 그룹에, Landmark.swift, ModelData.swift는 Model 그룹에 넣는다.

**Tip** <br>
그룹에 추가할 항목을 선택한 다음 Xcode 메뉴에서 File > New > Group을 선택하여 기존 항목에서 그룹을 생성할 수 있다.

### Section 2
## Create the Row View

<p align="center">
    <img width="403" src="https://user-images.githubusercontent.com/60697742/129457086-6b6bd531-d233-455e-a52a-0dc5c2ce8e42.png">
</p>

이 tutorial에서 만들 첫 번째 뷰는 각 landmark에 대한 세부 정보를 표시하는 행이다.
이 행 뷰는 표시되는 landmark의 속성에 정보를 저장하므로 하나의 뷰에서 모든 랜드마크를 보여줄 수 있다.
이후 여러 행을 landmark 목록으로 결합한다.

**Step 1** <br>
Views 그룹에 LandmarkRow.swift라는 이름의 새로운 SwiftUI 뷰를 생성한다.

**Step 2** <br>
만약 미리 보기가 표시되지 않으면, Editor > Canvas를 눌러 캔버스가 보여지게 한 후 Resume을 누른다.

**Step 3** <br>
LandmarkRow의 저장 속성으로 landmark를 추가한다.
landmark 속성을 추가하면 LandmarkRow 유형은 초기화 중에 landmark 인스턴스가 필요하기 때문에 미리보기가 작동을 멈춘다.

미리보기를 수정하려면 미리보기 provider를 수정해야 한다.

**Step 4** <br>
LandmarkRow_Previews의 미리보기의 정적인 속성에서 LandmarkRow의 initializer에 Landmark 매개변수를 추가하고, Landmarks 배열의 첫 번째 요소를 지정한다.
미리보기에 'Hello, World!'라는 텍스트가 표시된다.

```swift
struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        Text("Hello, World!")
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: landmarks[0])
    }
}
```

이를 수정하면 행에 대한 레이아웃을 구축할 수 있다.

**Step 5** <br>
HStack에 기존 텍스트 뷰를 넣는다.

**Step 6** <br>
landmark 속성의 이름을 사용하도록 텍스트 뷰를 수정한다.

```swift
var body: some View {
    HStack {
        Text(landmark.name)
    }
}
```

**Step 7** <br>
텍스트 뷰 앞에 이미지를 추가하고 뒤에 Spacer를 추가하여 행을 완성한다.

```swift
var body: some View {
    HStack {
        landmark.image
            .resizable()
            .frame(width: 50, height: 50)
        Text(landmark.name)

        Spacer()
    }
}
```

### Section 3
## Customize the Row Preview

Xcode의 캔버스는 PreviewProvider 프로토콜을 준수하는 편집기의 모든 유형을 자동으로 인식하고 표시한다.
미리보기 provider는 크기 및 장치를 설정하는 옵션과 하나 이상의 뷰를 반환한다.

미리보기 provider로부터 반환된 콘텐츠를 설정하여 가장 유용한 미리보기를 정확하게 만들 수 있다.

**Step 1** <br>
LandmarkRow_Preview에서 Landmark 매개변수를 Landmark 배열의 두 번째 요소로 업데이트한다.
미리보기는 첫 번째 대신 두 번째 샘플 landmark를 표시하도록 즉시 변경된다.

**Step 2** <br>
previewLayout(_:) modifier를 사용하여 목록의 행과 비슷한 크기를 설정한다.

```swift
struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: landmarks[1])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
```

Group을 사용하여 미리보기 provier로부터 여러 미리보기를 반환할 수 있다.

**Step 3** <br>
반환된 행을 Group으로 묶고 첫 번째 행을 다시 추가한다.
Group은 뷰 콘텐츠를 그룹화하기 위한 컨테이너이다.
Xcode는 Group의 자식 뷰를 캔버스에서 별도의 미리보기로 생성한다.

```swift
struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks[0])
                .previewLayout(.fixed(width: 300, height: 70))
            LandmarkRow(landmark: landmarks[1])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
```

**Step 4** <br>
코드를 단순화하려면 previewLayout(_:) 호출을 Group의 자식 선언부의 외부로 이동한다.
뷰의 자식은 미리보기 구성과 같은 뷰의 맥락과 관련된 설정을 상속한다.

```swift
struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
```

미리보기 provider에서 작성한 코드는 Xcode가 캔버스에 표시하는 내용만을 변경한다.

### Section 4
## Create the List of Landmarks

SwiftUI의 List 유형을 사용하면, 플랫폼 별 뷰의 목록을 표시할 수 있다.
목록의 요소는 지금까지 생성한 Stack의 자식 뷰와 같이 정적이거나 동적으로 생성될 수 있다.
정적 뷰와 동적으로 생성된 뷰를 혼합할 수도 있다.

**Step 1** <br>
Views 그룹에 LandmarkList.swift라는 새로운 SwiftUI 뷰를 생성한다.

**Step 2** <br>
기존 텍스트 뷰를 List로 변경하고 처음 두 landmark가 있는 LandmarkRow 인스턴스를 목록의 자식으로 제공한다.
미리보기는 iOS에 적합한 목록 스타일로 생성된 두 개의 랜드마크를 보여준다.

```swift
var body: some View {
    List {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
}
```

### Section 5
## Make the List Dynamic

목록의 요소를 개별적으로 지정하는 대신, 컬렉션에서 직접 행을 생성할 수 있다.

데이터 컬렉션과 컬렉션의 각 요소에 대한 뷰를 제공하는 closure를 전달하여 컬렉션 요소를 표시하는 목록을 생성할 수 있다.
목록은 제공된 closure를 사용하여 컬렉션의 각 요소를 자식 뷰로 반환한다.

**Step 1** <br>
두 개의 정적 landmark 행을 제거하고 대신에 모델 데이터의 landmark 배열을 List initializer에 전달한다.
List는 식별 가능한 데이터로 작동한다.
데이터를 식별하는데에 두 가지 방법이 있다.
각 요소를 고유하게 식별하는 속성에 대한 키 경로를 데이터와 함께 전달하거나 데이터 유형이 Identifiable 프로토콜을 따르도록 하는 방법이 있다.

```swift
var body: some View {
    List(landmarks, id: \.id) { landmark in

    }
}
```

**Step 2** <br>
closure에서 LandmarkRow를 반환하여 동적으로 생성된 목록을 완성한다.
Landmark 배열의 각 요소에 대해 하나의 LandmarkRow가 생성된다.

```swift
var body: some View {
    List(landmarks, id: \.id) { landmark in
        LandmarkRow(landmark: landmark)
    }
}
```

다음으로 Landmark 유형에 Identifiable 적합성을 추가하여 List 코드를 단순화한다.

**Step 3** <br>
Landmark.swift로 전환하여 식별 가능한 프로토콜에 대한 적합성을 선언한다.
Landmark 데이터에는 Idenfitiable 프로토콜에 필요한 id 속성이 이미 존재한다.
데이터를 읽을 때 디코딩할 속성만을 추가하면 된다.

```swift
struct Landmark: Hashable, Codable, Identifiable {

}
```

**Step 4** <br>
LandmarkList.swift로 전환하여 id 매개변수를 제거한다.
이제부터 Landmark 요소 컬렉션을 직접 사용할 수 있다.

```swift
var body: some View {
    List(landmarks) { landmark in
        LandmarkRow(landmark: landmark)
    }
}
```

### Section 6
## Set Up Navigation Between List and Detail

<p align="center">
    <img width="431" src="https://user-images.githubusercontent.com/60697742/129665161-45368222-5dad-47c2-83d9-378a8faa7479.png">
</p>

목록이 제대로 생성되었지만 아직 개별 landmark를 탭하여 해당 landmark의 세부 정보 페이지를 볼 수 없다.

NavigationView에 포함된 목록에 탐색 기능을 추가한 후 NavigationLink의 각 행을 중첩하여 대상 뷰로의 전환을 설정한다.

이전 tutorial에서 생성한 콘텐츠를 사용하여 상세 보기를 준비하고 대신에 목록 뷰를 표시하도록 메인 콘텐츠 뷰를 업데이트 한다.

**Step 1** <br>
LandmarkDetail.swift라는 이름의 새로은 SwiftUI 뷰를 생성한다.

**Step 2** <br>
ContentView에서 LandmarkDetail로 body 속성의 내용을 복사한다.

**Step 3** <br>
LandmarkList를 표시하도록 ContentView를 변경한다.

다음 몇 단계에서는 목록 및 세부 정보 뷰 간에 navigation을 추가한다.

**Step 4** <br>
NavigationView에 동적으로 생성된 landmark 목록을 포함한다.

```swift
var body: some View {
    NavigationView {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
    }
}
```

**Step 5** <br>
navigationTitle(_:) modifier 메서드를 호출하여 목록을 표시할 때 navigation bar의 제목을 설정한다.

```swift
var body: some View {
    NavigationView {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
    }
    .navigationTitle("Landmarks")
}
```

**Step 6** <br>
목록의 closure 내에서, LandmarkDetail 뷰를 목적지로 지정하여 NavigationLink에서 반환된 행을 감싼다.

```swift
var body: some View {
    NavigationView {
        List(landmarks) { landmark in
            NavigationLink(destination: LandmarkDetail()) {
                LandmarkRow(landmark: landmark)
            }
        }
        .navigationTitle("Landmarks")
    }
}
```

**Step 7** <br>
라이브 모드로 전환하여 미리보기에서 직접 탐색을 시도할 수 있다.
실시간 미리보기 버튼을 누르고 landmark를 탭하면 상세 페이지로 이동한다.

### Section 7
## Pass Data into Child Views

LandmarkDetail 뷰는 여전히 하드 코딩된 세부 정보를 사용하여 landmark를 표시한다.
LandmarkRow와 마찬가지로 LandmarkDetail 유형과 이를 구성하는 보기는 데이터 소스로 Landmark 속성을 사용해야 한다.

자식 뷰부터 CircleImage, MapView 및 LandmarkDetail을 변환하여 각 행을 하드 코딩하는 대신 전달된 데이터를 표시한다.

**Step 1** <br>
CircleImage.swift에서 CircleImage에 저장된 이미지 속성을 추가한다.
이것은 SwiftUI를 사용하여 뷰를 빌드할 때 일반적인 패던이다.
설정된 뷰는 종종 특정 보기에 대한 일련의 modifier를 감싸고 캡슐화한다.

```swift
var image: Image

var body: some View {
    image
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 7)
}
```

**Step 2** <br>
Turtle Rock의 이미지를 전달하도록 미리보기 provider를 업데이트한다.
미리보기 로직을 수정하였음에도 빌드가 실패하여 미리보기가 업데이트 되지 않는다.
Circle Image를 인스턴스화하는 디테일 뷰에도 입력 매개변수가 필요하다.

**Step 3** <br>
MapView.swift에서 coordinate 속성을 MapView에 추가하고 미리보기 provider를 업데이트하여 고정 좌표를 전달한다.
detail 뷰에는 새 매개변수가 필요한 map 뷰가 있기 때문에 이 변경은 빌드에도 영향을 준다.

```swift
struct MapView: View {
    var coordinate: CLLocationCoordinate2D

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
```

**Step 4** <br>
좌표 값을 기반으로 영역을 업데이트하는 메서드를 추가한다.

```swift
private func setRegion(_ coordinate: CLLocationCoordinate2D) {
    region = MKCoordinateRegion(
        center: coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
}
```

**Step 5** <br>
현재 좌표를 기준으로 영역 계산을 실행하는 onAppear 뷰 modifier를 지도에 추가한다.

```swift
@State private var region = MKCoordinateRegion()

var body: some View {
    Map(coordinateRegion: $region).onAppear {
        setRegion(coordinate)
    }
}
```

**Step 6** <br>
LandmarkDetail.swift에서 LandmarkDetail 유형에 Landmark 속성을 추가한다.

**Step 7** <br>
LandmarkList.swift에서 현재 landmark를 목적지 LandmarkDetail에 전달한다.

```swift
NavigationView {
    List(landmarks) { landmark in
        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
            LandmarkRow(landmark: landmark)
        }
    }
    .navigationTitle("Landmarks")
}
```

**Step 8** <br>
LandmarkDetail 파일에서 필요한 데이터를 설정된 유형에 전달한다.
모든 연결이 설정되면 미리보기가 다시 작동하기 시작한다.

**Step 9** <br>
컨테이너를 VStack에서 ScrollView로 변경하여 사용자가 설명된 콘텐츠를 스크롤하고 더 이상 필요하지 않은 스페이서를 삭제할 수 있다.

**Step 10** <br>
마지막으로 세부 정보 뷰를 표시할 때 navigation bar에 제목을 지정하려면 navigationTitle(_:) modifier를 호출하고 제목을 인라인으로 표시하려면 navigationBarTitleDisplayMode( :) modifier를 호출한다.
navigation의 변경 사항은 뷰가 navigation stack의 일부인 경우에만 적용된다.

```swift
.navigationTitle(landmark.name)
.navigationBarTitleDisplayMode(.inline)
```

**Step 11** <br>
목록에서 탐색할 때 세부 정보 뷰에 올바른 Landmark가 표시되는지 보려면 라이브 미리보기로 전환한다.

### Section 8
## Generate Previews Dynamically

다음으로 LandmarkList_Previews 미리보기 provider에 코드를 추가하여 다양한 기기 크기에서 목록 뷰의 미리보기를 생성한다.
기본적으로 미리보기는 활성 구성표의 장치 크기로 생성된다.
previewDevice(_:) modifier 메서들르 호출하여 미리보기 장치를 변경할 수 있다.

**Step 1** <br>
iPhone SE 크기로 생성하도록 현재 목록 미리보기를 변경하여 시작한다.
Xcode의 구성표 메뉴에 표시되는 모든 장치의 이름을 제공할 수 있다.

```swift
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
    }
}
```

**Step 2** <br>
목록 미리보기 내에서 장치 이름 배열을 데이터로 사용하여 ForEach 인스턴스에 LandmarkList를 포함한다.
ForEach는 list와 동일한 방식으로 컬렉션에서 작동하므로 stack, list, group 등과 같이 자식 뷰를 사용할 수 있는 모든 곳에서 사용할 수 있다.
데이터 요소가 사용하는 문자열과 같은 단순한 값 유형인 경우, \.self를 식별자에 대한 키 경로로 사용할 수 있다.

```swift
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
```

**Step 3** <br>
미리보기에 대한 label로 장치 이름을 추가하려면 previewDisplayName(_:) modifier를 사용한다.

```swift
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
```

**Step 4** <br>
캔버스에서 다양한 장치를 실험하여 뷰의 구현을 비교할 수 있다.