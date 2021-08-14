## SwiftUI Essentials
# Building Lists and Navigation

기본 landmark detail 뷰가 설정되면 사용자가 전체 landmark 목록을 보고 각 위치에 대한 세부정보를 볼 수 있는 방법을 제공해야 한다.

모든 landmark에 대한 정보를 보여주는 뷰를 만들고 사용자가 landmark에 대한 detail 뷰를 보기 위해 탭할 수 있는 스크롤 목록을 동적으로 생성한다.
UI를 미세 조정하기 위해 Xcode의 캔버스를 사용하여 다양한 장치의 크기에서 여러 미리보기를 렌더링한다.

### Section 1
## Create a Landmark Model
첫 번째 tutorial에서 모든 설정된 뷰에 하드 코딩하여 정보를 넣었다.
이번에는 뷰에 전달할 수 있는 데이터를 저장하는 모델을 만들 것이다.

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