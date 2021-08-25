## Drawing and Animation
# Animating Views and Transitions

SwiftUI를 사용하면 UI는 효과가 있는 위치에 관계없이 뷰 또는 뷰의 상태에 대한 변경 사항을 개별적으로 애니메이션화할 수 있다.
SwiftUI는 이러한 결합, 중첩 및 중단 가능한 애니메이션의 모든 복잡성을 처리한다.

이 tutorial에서는 사용자가 Landmarks 앱을 사용하는 동안 걷는 하이킹을 추적하기 위한 그래프가 포함된 뷰를 애니메이션화한다.
animation(_:) modifier를 사용하면 뷰에 애니메이션 효과를 주는 것이 얼마나 쉬운지 알 수 있다.

### Section 1
## Add Hiking Data to the App

애니메이션을 추가하려면 먼저 애니메이션을 적용할 무언가가 필요하다.
이 section에서는 하이킹 데이터를 가져와 모델링한 다음 해당 데이터를 그래프에 정적으로 표시하기 위해 미리 작성된 뷰를 추가한다.

**Step 1** <br>
다운로드한 파일의 Resources 폴더에서 hikeData.json 파일을 프로젝트의 Resources 그룹으로 드래그한다.
Finish를 누르기 전에 “Copy items if needed” 를 선택해야 한다.

**Step 2** <br>
메뉴 항목의 File > New > File을 사용하여 프로젝트의 Model 그룹에 Hike.swift라는 새 Swift 파일을 만든다.
Landmark 구조와 마찬가지로 Hike 구조는 Codable을 준수하며 해당 데이터 파일의 키와 일치하는 속성을 가지고 있다.

```swift
struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]

    static var formatter = LengthFormatter()

    var distanceText: String {
        return Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }

    struct Observation: Codable, Hashable {
        var distanceFromStart: Double

        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}
```

**Step 3** <br>
hikes 배열을 모델 개체에 로드한다.
하이킹 데이터를 처음 로드한 후에는 절대 수정하지 않기 때문에 @Published 속성으로 표시할 필요가 없다.

```swift
var hikes: [Hike] = load("hikeData.json")
```

**Step 4** <br>
다운로드한 파일의 Resources 폴더에서 Hikes 폴더를 프로젝트의 Views 그룹으로 드래그한다.
Finish를 누르기 전에 “Copy items if needed” 및 “Create groups”를 선택해야 한다.

새로운 뷰에 익숙해져야 한다.
그들은 함께 작동하여 모델에 로드된 하이킹 데이터를 표시한다.

**Step 5** <br>
HikeView.swift에서 실시간 미리보기를 켜고 그래프 표시 및 숨기기를 실험해본다.
각 단계의 결과를 실험할 수 있도록 이 tutorial 전체에서 실시간 미리보기를 사용한다.

### Section 2
## Add Animations to Individual Views

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

### Section 3
## Animate the Effects of State Changes

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

### Section 4
## Customize View Transitions

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

### Section 5
## Compose Animations for Complex Effects

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>