## Drawing and Animation
# Animating Views and Transitions

SwiftUI를 사용하면 UI는 효과가 있는 위치에 관계없이 뷰 또는 뷰의 상태에 대한 변경 사항을 개별적으로 애니메이션화할 수 있다.
SwiftUI는 이러한 결합, 중첩 및 중단 가능한 애니메이션의 모든 복잡성을 처리한다.

이 tutorial에서는 사용자가 Landmarks 앱을 사용하는 동안 걷는 하이킹을 추적하기 위한 그래프가 포함된 뷰를 애니메이션화한다.
animation(_:) modifier를 사용하면 뷰에 애니메이션 효과를 주는 것이 얼마나 쉬운지 알 수 있다.

### Section 1
## Add Hiking Data to the App

<p align="center">
    <img width="350" src="https://user-images.githubusercontent.com/60697742/130907681-115b3e8c-cc74-4cd1-a8d3-4116c44eb72e.png">
</p>

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

뷰에서 animation(_:) modifier를 사용하면 SwiftUI는 뷰의 애니메이션 가능한 속성에 대한 모든 변경 사항을 애니메이션으로 표시한다.
뷰의 색상, 불투명도, 회전, 크기 및 기타 속성은 모두 애니메이션화 가능하다.

**Step 1** <br>
HikeView.swift에서 animation(.easeInOut)을 추가하여 버튼 회전에 대한 애니메이션을 킨다.

```swift
Button(action: {
    self.showDetail.toggle()
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .padding()
        .animation(.easeInOut)
}
```

**Step 2** <br>
그래프가 표시될 때 버튼을 더 크게 만들어 애니메이션화 가능한 또 다른 변경 사항을 추가한다.
animation(_:) modifier는 감싸는 뷰 내에서 애니메이션화 가능한 모든 변경 사항에 적용된다.

```swift
Button(action: {
    self.showDetail.toggle()
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
        .animation(.easeInOut)
}
```

**Step 3** <br>
애니메이션 유형을 easyInOut에서 spring()으로 변경한다.
SwiftUI에는 사전 정의 또는 사용자 지정이 쉬운 기본 애니메이션과 스프링 및 유동 애니메이션이 포함된다.
애니메이션의 속도를 조정하거나, 애니메이션이 시작되기 전에 지연을 설정하거나, 애니메이션이 반복되도록 지정할 수 있다.

```swift
Button(action: {
    self.showDetail.toggle()
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
        .animation(.spring())
}
```

**Step 4** <br>
scaleEffect modifier 바로 위에 다른 애니메이션 modifier를 추가하여 회전에 대한 애니메이션을 끈다.
회전을 위해 SwiftUI를 이용한다.
가능한 것이 무엇이 있는지를 확인하기 위해 여러 가지 애니메이션 효과를 조합해본다.

```swift
Button(action: {
    self.showDetail.toggle()
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .animation(nil)
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
        .animation(.spring())
}
```

**Step 5** <br>
다음 section으로 이동하기 전에 두 animation(_:) modifier를 모두 제거한다.

```swift
Button(action: {
    self.showDetail.toggle()
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
}
```

### Section 3
## Animate the Effects of State Changes

개별 뷰에 애니메이션을 적용하는 방법을 배웠으므로 이제 상태 값을 변경하는 위치에 애니메이션을 추가할 차례이다.

여기에서는 사용가바 버튼을 누르고 showDetail 상태 속성을 전환할 때 발생하는 모든 변경 사항에 애니메이션을 적용한다.

**Step 1** <br>
withAnimation 함수에 대한 호출로 showDetail.toggle() 호출을 감싼다.
showDetail 속성의 영향을 받는 두 뷰(공개 버튼 및 HikeDetail 뷰)에는 애니메이션 전환이 있다.

```swift
Button(action: {
    withAnimation {
        self.showDetail.toggle()
    }
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
}
```

애니메이션을 느리게 하여 SwiftUI 애니메이션이 어떻게 중단되는지 확인한다.

**Step 2** <br>
withAnimation 함수에 4초 길이의 기본 애니메이션을 전달한다.
animation(_:) modifier에 전달한 것과 같은 종류의 애니메이션을 withAnimation 함수에 전달할 수 있다.

```swift
Button(action: {
    withAnimation(.easeInOut(duration: 4)) {
        self.showDetail.toggle()
    }
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
}
```

**Step 3** <br>
애니메이션 중간에 그래프 뷰를 열고 닫는 실험을 한다.

**Step 4** <br>
다음 section을 계속하기 전에 호출의 입력 매개변수를 제거하여 기본 애니메이션을 사용하도록 withAnimaiton 함수를 복원한다.

```swift
Button(action: {
    withAnimation {
        self.showDetail.toggle()
    }
}) {
    Image(systemName: "chevron.right.circle")
        .imageScale(.large)
        .rotationEffect(.degrees(showDetail ? 90 : 0))
        .scaleEffect(showDetail ? 1.5 : 1)
        .padding()
}
```

### Section 4
## Customize View Transitions

기본적으로 뷰는 페이드 인 및 페이드 아웃을 통해 화면 안팎으로 전환된다.
transition(_:) modifier를 사용하여 이 전환을 설정할 수 있다.

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