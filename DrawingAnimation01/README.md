## Drawing and Animation
# Drawing Paths and Shapes

사용자는 목록에 있는 landmark를 방문할 때마다 배지를 받는다.
물론, 사용자가 배지를 받으려면 배지를 만들어야 한다.
이 tutorial에서는 경로와 모양을 결합한 후 위치를 나타내는 다른 모양으로 중첩하여 배지를 만드는 과정을 안내한다.

여러 종류의 landmark에 대해 여러 개의 배지를 만드려면 중첩된 기호를 실험하거나, 반복 정도를 변경하거나, 다양한 각도와 축척 변경을 시도해봐야한다.

### Section 1
## Create Drawing Data for a Badge View

<p align="center">
    <img width="455" src="https://user-images.githubusercontent.com/60697742/130177669-e372eeb5-6aee-4c6a-904c-d82eff4093e5.png">
</p>

배지를 만들기 위해 먼저 배지 배경의 육각형 모향을 그리는데 사용할 수 있는 데이터를 정의해야 한다.

**Step 1** <br>
탐색창에서 Views 그룹을 선택한 상태에서 File > New > File을 선택하고 iOS Templates sheet에서 Swift 파일을 선택한 후 다음을 누른다.

**Step 2** <br>
새 파일의 이름을 HexagonParameters.swift로 지정한다.
이 구조를 사용하여 육각형의 모양을 정의한다.

**Step 3** <br>
새 파일 안에 HexagonParameters라는 구조를 생성한다.

**Step 4** <br>
육각형의 한 면을 나타내는 세 개의 점을 유지하는 Segment 구조를 정의한다.
CGPoint를 사용할 수 있도록 CoreGraphics를 import 한다.
각 변은 끝나는 지점에서 시작하여 첫 번째 점가지 직선으로 이동한 다음 모서리의 Bézier 곡선을 따라 두 번째 점으로 이동한다.

```swift
import CoreGraphics

struct HexagonParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
}
```

**Step 5** <br>
segment를 저장할 배열을 생성한다.

```swift
struct HexagonParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }

    static let segments = [
    ]
}
```

**Step 6** <br>
육각현의 각 측면에 대해 하나씩 6개의 segment에 대한 데이터를 추가한다.
값은 양의 x가 오른쪽이고 양의 y가 아래인 왼쪽 상단에 있는 단위 제공의 분수로 저장된다.
후에 이 분수를 사용하여 주어진 크기의 육각형의 실제 점을 찾는다.

```swift
static let segments = [
    Segment(
        line:    CGPoint(x: 0.60, y: 0.05),
        curve:   CGPoint(x: 0.40, y: 0.05),
        control: CGPoint(x: 0.50, y: 0.00)
    ),
    Segment(
        line:    CGPoint(x: 0.05, y: 0.20),
        curve:   CGPoint(x: 0.00, y: 0.30),
        control: CGPoint(x: 0.00, y: 0.25)
    ),
    Segment(
        line:    CGPoint(x: 0.00, y: 0.70),
        curve:   CGPoint(x: 0.05, y: 0.80),
        control: CGPoint(x: 0.00, y: 0.75)
    ),
    Segment(
        line:    CGPoint(x: 0.40, y: 0.95),
        curve:   CGPoint(x: 0.60, y: 0.95),
        control: CGPoint(x: 0.50, y: 1.00)
    ),
    Segment(
        line:    CGPoint(x: 0.95, y: 0.80),
        curve:   CGPoint(x: 1.00, y: 0.70),
        control: CGPoint(x: 1.00, y: 0.75)
    ),
    Segment(
        line:    CGPoint(x: 1.00, y: 0.30),
        curve:   CGPoint(x: 0.95, y: 0.20),
        control: CGPoint(x: 1.00, y: 0.25)
    )
]
```

**Step 7** <br>
육각형의 모양을 조정할 수 있는 조정 값을 추가한다.

```swift
static let adjustment: CGFloat = 0.085

static let segments = [
    Segment(
        line:    CGPoint(x: 0.60, y: 0.05),
        curve:   CGPoint(x: 0.40, y: 0.05),
        control: CGPoint(x: 0.50, y: 0.00)
    ),
    Segment(
        line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
        curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
        control: CGPoint(x: 0.00, y: 0.25 + adjustment)
    ),
    Segment(
        line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
        curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
        control: CGPoint(x: 0.00, y: 0.75 - adjustment)
    ),
    Segment(
        line:    CGPoint(x: 0.40, y: 0.95),
        curve:   CGPoint(x: 0.60, y: 0.95),
        control: CGPoint(x: 0.50, y: 1.00)
    ),
    Segment(
        line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
        curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
        control: CGPoint(x: 1.00, y: 0.75 - adjustment)
    ),
    Segment(
        line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
        curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
        control: CGPoint(x: 1.00, y: 0.25 + adjustment)
    )
]
```

### Section 2
## Draw the Badge Background

SwiftUI의 그래픽 API를 사용하여 맞춤형 배지 모양을 그린다.

**Step 1** <br>
File > New > File을 사용하여 다른 새 파일을 생성한다.
이번에는 iOS Templates sheet에서 SwiftUI View를 선택한다.
Next를 눌러 파일 이름을 BadgeBackground.swift로 지정한다.

**Step 2** <br>
BadgeBackground.swift에서 Path 모양을 배지에 추가하고 fill() modifier를 적용하여 형태를 뷰로 변경한다.
Paths를 사용하여 선, 곡선 및 기타 그리기 기본 요소를 결합한 배지의 육각형 배경과 같은 더 복잡한 모양을 형성한다.

```swift
struct BadgeBackground: View {
    var body: some View {
        Path { path in

        }
        .fill(Color.black)
    }
}
```

**Step 3** <br>
크기가 100 x 100 픽셀인 컨테이너를 가정하고 경로에 시작점을 추가한다.

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

**Step 8** <br>

**Step 9** <br>

### Section 3
## Draw the Badge Symbol

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

### Section 4
## Combine the Badge Foreground and Background

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>