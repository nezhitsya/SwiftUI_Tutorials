## SwiftUI Essentials
# Creating and Combining Views

좋아하는 장소를 발견하고 공유하는 Landmarks 어플리케이션을 개발하는 튜토리얼 가이드이다.
Landmarks의 세부 정보를 보여주는 뷰를 구축하는 것으로 시작된다.

뷰를 배치하기 위해 Landmarks는 이미지 및 텍스트 뷰를 결합하고 계층화하기 위해 stacks를 사용한다.
지도를 뷰에 삽입하기 위해서 표준 MapKit를 포함한다.
뷰의 디자인을 다듬을 때, Xcode는 실시간 피드백을 제공하여 변경 사항이 코드로 어떻게 변환되는지 확인할 수 있다.

### Section 1
## Create a New Project and Explore the Canvas

SwiftUI를 사용하는 새로운 Xcode 프로젝트를 생성한다.
캔버스, 미리보기 및 SwiftUI 템플릿 코드를 살펴본다.

Xcode의 캔버스에서 뷰를 미리보고 상호작용하고, 튜토리얼 전반에 걸쳐 설명된 모든 최신 기능을 사용하기 위해서 Mac에서 macOS Big Sur 이상을 실행중인지 확인한다.

**Step 1** <br>
Xcode를 열고 Xcode의 시작 화면의 "Create a new Xcode project"를 누르거나, File > New > Project를 선택한다.

**Step 2** <br>
템플릿 선택 창에서 iOS 플랫폼의 App 템플릿을 선택한 후 다음으로 넘어간다.

**Step 3** <br>
제품 이름으로 "Landmarks"를 입력하고 인터페이스로 "SwiftUI"를 선택, 라이프 사이클에 대해 "SwiftUI App"을 선택 후 다음으로 넘어간다.
Mac에 Landmarks 프로젝트를 저장할 위치를 선택한다.

**Step 4** <br>
프로젝트 네비게이터에서 LandmarksApp.swift를 선택한다.

SwiftUI 앱 라이프 사이클을 사용하는 앱은 앱 프로토콜을 준수하는 구조를 가지고 있다.
구조의 body 속성은 하나 이상의 화면을 반환하여 차례로 표시할 콘텐츠를 제공한다.
@main 속성은 앱의 진입점을 나타낸다.

**Step 5** <br>
프로젝트 네비게이터에서 ContentView.swift를 선택한다.

기본적으로 SwiftUI 뷰 파일은 두 가지 구조를 분명히 한다.
첫 번째 구조는 뷰 프로토콜을 따르고 뷰의 내용과 레이아웃을 설명한다.
두 번째 구조는 뷰의 미리보기를 선언한다.

**Step 6** <br>
캔버스의 Resume를 눌러 미리 보기를 표시한다.
만약, 캔버스가 보이지 않으면 Editor > Canvas를 선택해 보이도록 한다.

**Step 7** <br>
body 속성 내에서 "Hello, World!"를 다른 인사말로 변경한다.
뷰의 body 속성에서 코드를 변경하면 미리 보기는 변경 사항을 반영하여 덥데이트된다.

### Section 2
## Customize the Text View

코드를 변경하거나 인스펙터를 사용하여 사용 가능한 항목을 찾고 코드 작성에 도움을 주어 뷰의 화면을 바꿀 수 있다.
Landmarks 앱을 빌드할 때, 소스 편집기, 캔버스 또는 inspector와 같은 편집기 조합을 사용할 수 있다.
사용하는 도구에 관계없이 코드는 업데이트된 상태로 유지된다.

_inspector를 사용한 텍스트 뷰 변경_ <br>
**Step 1** <br>
미리 보기에서 인사말을 Command - 클릭하여 구조화 된 편집 팝오버를 불러오고 "Show SwiftUI Inspector"를 선택한다.
팝오버는 검사하는 뷰 유형에 따라 변경할 수 있는 다양한 속성을 보여준다.

**Step 2** <br>
inspector를 사용해 텍스트를 앱에 표시할 첫 번째 landmark 이름인 "Turtle Rock"으로 변경한다.

**Step 3** <br>
글꼴을 "Title"로 변경한다.
이는 시스템 글꼴이 텍스트에 적용되어 사용자가 선호하는 글꼴 사이즈와 설정에 올바르게 응답한다.

SwiftUI 뷰를 변경하기 위해서 modifiers라 불리는 메소드를 호출한다.
modifiers는 뷰를 감싸 화면이나 기타 속성을 변경한다.
각 modifier는 새로운 뷰를 반환하므로 일반적으로 수직으로 쌓인 여러 modifier를 연결한다.

**Step 4** <br>
padding() modifier를 foregroundColor(.green) modifier로 직접 편집하여 변경한다.
이것은 텍스트의 색성을 녹색으로 변경한다.

코드는 항상 뷰에 나타난다.
inspector를 사용하여 modifier를 수정 및 제거하면 Xcode는 그에 맞게 코드를 즉시 업데이트한다.

**Step 5** <br>
이번에는 코드 편집기에서 텍스트 선언부를 Command - 클릭하여 inspector를 연 후 팝오버에서 "Show SwiftUI Inspector"를 선택한다.
색상 팝업 메뉴틀 선택하고 텍스트 색상을 다시 검정색으로 변경한다.

**Step 6** <br>
Xcode는 변경 사항을 반역하여 자동으로 코드를 업데이트해 foregroundColor(.green) modifier를 제거한다.

### Section 3
## Combine Views Using Stacks

이전 섹션에서 생성한 제목 뷰 외에도 공원 이름, state와 같은 landmark에 대한 세부 정보를 포함하는 텍스트 뷰를 추가한다.

SwiftUI 뷰를 생성할 때, body 속성에서 내용, 레이아웃, 동작을 설명한다.
그러나, body 속성은 단일 보기만을 반환한다.
뷰를 가로, 세로 또는 뒤에서 앞으로 그룹화하는 스택에 여러 뷰를 결합하고 포함할 수 있다.

이번 섹션에서는 수직 스택을 사용하여 공원에 대한 세부 정보가 포함된 수평 스택 위에 제목을 배치한다.

Xcode의 구조화된 편집 지원을 사용하여 뷰를 컨테이너 뷰에 삽입하거나, inspector를 열거나, 다른 유용한 변경 사항을 지원한다.

**Step 1** <br>
텍스트 뷰의 initializer를 Command - 클릭하여 구조화된 편집 팝오버를 연 후 "Embed in VStack"을 선택한다.

다음으로, 라이브러리에서 텍스트 뷰를 끌어 스택에 텍스트 뷰를 추가한다.

**Step 2** <br>
Xcode 화면 우측 상단의 (+) 버튼을 눌러 라이브러리르 열고 "Turtle Rock" 텍스트 뷰 바로 아래 위치로 텍스트 뷰를 드래그한다.

**Step 3** <br>
텍스트 뷰의 placeholder 텍스트를 "Joshua Tree National Park"로 변경한다.

원하는 레이아웃과 일치하도록 location 텍스트를 수정한다.

**Step 4** <br>
location 텍스트의 글꼴을 subheadline으로 설정한다.

```swift
VStack {
    Text("Turtle Rock")
        .font(.title)
    Text("Joshua Tree National Park")
        .font(.subheadline)
}
```

**Step 5** <br>
VStack initializer를 뷰의 선행 가장자리로 정렬되도록 수정한다.
기본적으로, 스택은 축에 따라 내용을 중앙에 배치하고 상황에 맞는 간격을 제공한다.

```swift
VStack(alignment: .leading) {
    Text("Turtle Rock")
        .font(.title)
    Text("Joshua Tree National Park")
        .font(.subheadline)
}
```

다음으로, location 텍스트 오른편에 다른 텍스트 뷰, 공원의 state 텍스트를 추가한다.

**Step 6** <br>
캔버스에서, "Joshua Tree National Park"를 Command - 클릭하고 "Embed in HStack"을 선택한다.

**Step 7** <br>
location 텍스트 뒤에 새로운 텍스트 뷰를 추가하고 placeholder 텍스트를 공원의 state로 변경한 후 글꼴을 subheadline으로 설정한다.

```swift
VStack(alignment: .leading) {
    Text("Turtle Rock")
        .font(.title)
    HStack {
        Text("Joshua Tree National Park")
            .font(.subheadline)
        Text("California")
            .font(.subheadline)
    }
}
```

**Step 8** <br>
기기의 전체 너비를 사용하도록 레이아웃을 지정하기 위해서 park 텍스트 뷰와 state 텍스트 뷰가 포함된 수평 스택에 Spacer를 추가하여 두 텍스트 뷰를 분리한다.
Spacer는 콘텐츠에 의해서만 크기가 정의되는 대신에 포함하는 뷰가 상위 뷰의 모든 공간을 사용하도록 확장된다.

```swift
VStack(alignment: .leading) {
    Text("Turtle Rock")
        .font(.title)
    HStack {
        Text("Joshua Tree National Park")
            .font(.subheadline)
        Spacer()
        Text("California")
            .font(.subheadline)
    }
}
```

**Step 9** <br>
마지막으로 padding() modifier 메서드를 사용하여 landmark의 이름과 세부 정보에 더 많은 공간을 제공한다.

```swift
VStack(alignment: .leading) {
    Text("Turtle Rock")
        .font(.title)
    HStack {
        Text("Joshua Tree National Park")
            .font(.subheadline)
        Spacer()
        Text("California")
            .font(.subheadline)
    }
}.padding()
```

### Section 4
## Create a Custom Image View

이름과 위치 뷰가 모두 설정되었으면 다음 단계는 landmark에 대한 이미지를 추가하는 것이다.

이 파일에 더 많은 코드를 추가하는 대신, 마스크, 테두리, 그림자를 이미지에 적용할 수 있는 설정 뷰를 생성한다.

프로젝트의 asset 카탈로그에 이미지를 추가하는 것부터 시작한다.

**Step 1** <br>
프로젝트 파일의 Resources 폴더에서 turtlerock@2x.jpg를 찾는다.
asset 카탈로그의 편집기로 드래그한다.
Xcode는 새로운 이미지 세트를 생성한다.

다음으로, 이미지 설정 뷰를 위한 새로운 SwiftUI 뷰를 생성한다.

**Step 2** <br>
File > New > File을 선택하여 템플릿 선택기를 다시 연다.
User Interface 섹션에서 "SwiftUI View"를 선택하고 다음으로 넘어간다.
파일 이름은 CircleImage.swift로 지정한 후 생성한다.

이미지를 삽입하고 원하는 디자인에 일치하도록 화면을 수정할 준비가 되었다.

**Step 3** <br>
Image(_:) initializer를 사용하여 텍스트 뷰를 turtlerock 이미지로 교체하고 표시할 이미지 이름을 전달한다.

```swift
var body: some View {
    Image("turtlerock")
}
```

**Step 4** <br>
clipShape(Circle())을 추가하여 이미지에 원형 모양을 적용한다.
원형 타입은 마스크로 사용하거나 원에 획이나 채우기를 주는 뷰로 사용할 수 있다.

```swift
var body: some View {
    Image("turtlerock")
        .clipShape(Circle())
}
```

**Step 5** <br>
회색 획으로 된 다른 원을 생성하여 이미지에 테두리를 줄 수 있도록 오버레이로 추가한다.

```swift
var body: some View {
    Image("turtlerock")
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
}
```

**Step 6** <br>
다음으로, 7포인트 반경의 그림자를 추가한다.

```swift
var body: some View {
    Image("turtlerock")
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
        .shadow(radius: 7)
}
```

**Step 7** <br>
테두리 생상을 흰색으로 변경한다.
이것으로 이미지 뷰가 완료되었다.

```swift
var body: some View {
    Image("turtlerock")
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 7)
}
```

### Section 5
## Use SwiftUI Views From Other Frameworks

다음으로 주어진 좌표를 중심으로 지도를 생성한다.
MapKit의 지도 뷰를 사용하여 지도를 가져올 수 있다.

시작하기 위해서 지도를 관리할 새로운 설정 뷰를 생성한다.

**Step 1** <br>
File > New > File을 선택후 플랫폼은 iOS, SwiftUI View 템플릿을 선택한 후 다음으로 넘어간다.
MapView.swift로 이름을 지정한 후 생성한다.

**Step 2** <br>
MapKit를 import 한다.
같은 파일에서 SwiftUI와 특정 다른 프레임워크를 import하면, 해당 프레임워크에서 제공하는 SwiftUI 관련 기능에 접근할 수 있다.

**Step 3** <br>
지역 정보를 담은 지도를 private 상태 변수로 생성한다.
@State 속성을 사용하여 둘 이상의 뷰에서 수정할 수 있는 앱의 데이터 소스를 설정한다.
SwiftUI는 기본 저장소를 관리하고 값에 의존하는 뷰를 자동으로 업데이트한다.

```swift
@State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
)
```

**Step 4** <br>
기본 텍스트 뷰를 영역을 바인딩하는 지도 뷰로 변경한다.
상태 변수에 $ 접두사를 붙이면 기본 값에 대한 참조와 같은 바인딩을 전달한다.
사용자가 지도와 상호작용할 때, 지도는 사용자 인터페이스에 현재 표시되는 지도 부분과 일치하도록 지역 값을 업데이트한다.

```swift
var body: some View {
    Map(coordinateRegion: $region)
}
```

미리보기가 정적인 모드인 경우, 기본 SwiftUI 뷰만 완전히 렌더링된다.
지도 뷰의 경우, 렌더링을 보려면 실시간 미리 보기로 전환해야 한다.

**Step 5** <br>
Live Preview를 눌러 미리보기를 라이브 모드로 변경한다.
미리보기의 상단에 Try Again 이나 Resume 버튼을 눌러야 할 수도 있다.
잠시 후, Turtle Rock을 중심으로 지도가 표시된다.
실시간 미리보기에서 지도를 조작하여 축소하고 주변 지역을 볼 수 있다.

### Section 6
## Compose the Detail View

이제 이름, 장소, 원형 이미지, 위치에 대한 지도 등 필요한 모든 구성요소를 구축했다.
지금까지 사용한 도구로 설정된 뷰를 결합하여 landmark detail 뷰의 최종 디자인을 생성한다.

<p align="center">
    <img width="391" src="https://user-images.githubusercontent.com/60697742/129432107-6b4427d2-cd92-4f77-8399-99e5cfc7db0d.png">
</p>

**Step 1** <br>
프로젝트 네비게이터에서 ContentView.swift 파일을 선택한다.

**Step 2** <br>
세 개의 텍스트 뷰를 포함하는 VStack을 다른 VStack에 포함한다.

```swift
VStack {
    VStack(alignment: .leading) {
        Text("Turtle Rock")
            .font(.title)

        HStack {
            Text("Joshua Tree National Park")
                .font(.subheadline)
            Spacer()
            Text("California")
                .font(.subheadline)
        }
    }
    .padding()
}
```

**Step 3** <br>