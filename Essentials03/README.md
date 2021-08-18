## SwiftUI Essentials
# Handling User Input

Landmarks 앱에서 사용자는 즐겨찾는 장소에 표식을 지정하고 목록을 필터링하여 즐겨찾는 장소만을 표시할 수 있다.
이 기능을 만들기 위해 사용자가 즐겨찾기에만 집중할 수 있도록 목록에 스위치를 추가한 후, 사용자가 landmark를 즐겨찾기로 표시하기 위해 누르는 별 모양 버튼을 추가한다.

### Section 1
## Mark the User’s Favorite Landmarks

사용자에게 즐겨찾기를 한 눈에 보이도록 목록을 개선하는 것부터 시작한다.
Landmark 구조에 속성을 추가하여 landmark의 초기 상태를 즐겨찾기로 읽은 다음 각 LandmarkRow에 즐겨찾기 landmark를 표시하는 별표를 추가한다.

**Step 1** <br>
Xcode 시작점 프로젝트 또는 이전 tutorial에서 완료한 프로젝트를 열고 프로젝트 네비게이터에서 Landmark.swift를 선택한다.

**Step 2** <br>
Landmark 구조에 isFavorite 속성을 추가한다.
LandmarkData.json 파일에는 각 landmark에 대한 이름을 가진 키가 있다.
Landmark는 Codable을 따르므로 키와 이름이 같은 새 속성을 생성하여 키와 연결된 값을 읽을 수 있다.

**Step 3** <br>
프로젝트 네비게이터에서 LandmarkRow.swift를 선택한다.

**Step 4** <br>
Spacer 다음에 if 문 안에 별 이미지를 추가하여 현재 랜드마크가 즐겨찾기인지 여부를 테스트한다.
SwiftUI 블록에서는 조건부로 뷰를 포함하기 위해 if 문을 사용한다.

**Step 5** <br>
시스템 이미지는 벡터 기반이므로, foregroundColor(_:) modifier를 사용하여 색상을 변경할 수 있다.
랜드마크의 isFavorite 속성이 true일 때마다 별이 표시된다.
이 tutorial 뒷부분에서 해당 속성을 수정하는 방법을 볼 수 있다.

```swift
if landmark.isFavorite {
    Image(systemName: "star.fill")
        .foregroundColor(.yellow)
}
```

### Section 2
## Filter the List View

모든 landmark를 표시하거나 사용자의 즐겨찾기만 표시하도록 목록의 뷰를 설정할 수 있다.
이렇게 하기위해 LandmarkList 유형에 약간의 state를 추가해야 한다.

State는 시간이 지남에 따라 변결될 수 있고 뷰의 동작, 콘텐츠 또는 레이아웃에 영향을 주는 값 또는 값의 집합이다.
@State 속성이 있는 속성을 사용하여 뷰에 state를 추가한다.

**Step 1** <br>
프로젝트 네비게이터에서 LandmarkList.swift를 선택하고 단일 버전의 목록만 표시하도록 미리보기를 되돌린다.

**Step 2** <br>
초기값이 false로 설정된 showFavoriteOnly라는 @State 속성을 추가한다.
state 속성을 사용하여 뷰 및 해당 하위 뷰와 관련된 정보를 보유하기 때문에 항상 state를 private로 만든다.

```swift
@State private var showFavoritesOnly = false
```

**Step 3** <br>
캔버스를 새로 고치기 위해 Resume 버튼을 누른다.
속성 추가 또는 수정과 같이 뷰 구조를 변경할 때 캔버스를 수동을 새로 고쳐야 한다.

**Step 4** <br>
showFavoritesOnly 속성과 각 Landmark.isFavorite 값을 확인하여 landmark 목록의 필터링된 버전을 계산한다.

```swift
var filteredLandmarks: [Landmark] {
    landmarks.filter { landmark in
        (!showFavoritesOnly || landmark.isFavorite)
    }
}

```

**Step 5** <br>
List에서 landmark 목록의 필터링된 버전을 사용한다.

```swift
var body: some View {
    NavigationView {
        List(filteredLandmarks) { landmark in
            NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                LandmarkRow(landmark: landmark)
            }
        }
        .navigationTitle("Landmarks")
    }
}
```

**Step 6** <br>
목록이 어떻게 반응하는지 보려면 showFavoritesOnly의 초기 값을 true로 변경한다.

### Section 3
## Add a Control to Toggle the State

<p align="center">
    <img width="321" src="https://user-images.githubusercontent.com/60697742/129817024-8067ab3d-6541-482b-949d-bfa6a7966ac2.png">
</p>

목록의 필터에 대한 사용자의 제어 권한을 부여하기 위해 showFavoritesOnly 값을 변경할 수 있는 컨트롤을 추가해야 한다.
Toggle control에 바인딩을 전달하여 이 작업을 수행한다.

바인딩은 변경 가능한 상태에 대한 참조 역할을 한다.
사용자가 끄기에서 켜기로, 다시 끄기를 탭하면 컨트롤이 바인딩을 사용하여 그에 따라 보기의 상태를 업데이트한다.

**Step 1** <br>
중첩 ForEach 그룹을 만들어 landmark를 행으로 변환한다.
목록에서 정적 및 동적인 뷰를 결합하거나 둘 이상의 다른 동적 뷰 그룹을 결합하기 위해서 데이터 컬렉션을 List에 전달하는 대신 ForEach 유형을 사용한다.

```swift
var body: some View {
    NavigationView {
        List(filteredLandmarks) { landmark in
            ForEach(filteredLandmarks) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Landmarks")
    }
}
```

**Step 2** <br>
Toggle 뷰를 List 뷰의 첫 번째 자식으로 추가하고 showFavoritesOnly에 바인딩을 전달한다.
$ 접두사를 사용하여 state 변수 또는 해당 속성 중 하나에 대한 바인딩에 접근한다.

```swift
Toggle(isOn: $showFavoritesOnly) {
    Text("Favorites only")
}
```

**Step 3** <br>
계속 진행하기 전에 showFavoritesOnly의 기본 값을 false로 반환한다.

**Step 4** <br>
실시간 미리보기를 사용하고 toggle을 눌러 이 새로운 기능을 사용해본다.

### Section 4
## Use an Observable Object for Storage
어떤 특정 landmark가 즐겨찾기인지 사용자가 제어할 수 있도록 준비하기 위해서 먼저 landmark 데이터를 observable 객체에 저장한다.

observable 객체는 SwiftUI 환경의 저장소에서 뷰에 바인딩할 수 있는 데이터에 대해 설정된 개체이다.
SwiftUI는 뷰에 영향을 줄 수 있는 observable 객체의 변경 사항을 감시하고 변경 후 뷰의 올바른 버전을 표시한다.

**Step 1** <br>
프로젝트 탐색 창에서 ModelData.swift를 선택한다.

**Step 2** <br>
Combine 프레임워크에서 ObservableObject 프로토콜을 준수하는 새 모델 유형을 선언한다.

```swift
import Combine

final class ModelData: ObservableObject {
}
```

**Step 3** <br>
landmark 배열을 모델로 이동한다.

```swift
final class ModelData: ObservableObject {
    var landmarks: [Landmark] = load("landmarkData.json")
}
```

Observable 객체는 구독자가 변경 사항을 선택할 수 있도록 데이터에 대한 변경 사항을 게시해야 한다.

**Step 4** <br>
landmark 배열에 @Published 속성을 추가한다.

```swift
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
}
```

### Section 5
## Adopt the Model Object in Your Views

<p align="center">
    <img width="430" src="https://user-images.githubusercontent.com/60697742/129817028-8a5cbd6e-84d1-4836-b1d2-a95ddeb08fec.png">
</p>

ModelData 객체를 생성했으므로 뷰를 업데이트하여 앱의 데이터 저장소로 채택햐애 한다.

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

### Section 6
## Create a Favorite Button for Each Landmark

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>