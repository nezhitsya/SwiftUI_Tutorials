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
move(to:) 메서드는 마치 가상의 펜이나 연필이 그리기 시작을 기다리는 영역 위로 마우스를 가져가는 것처럼 모양의 경계 내에서 그리기 커서를 이동한다.

```swift
var body: some View {
    Path { path in
        var width: CGFloat = 100.0
        let height = width
        path.move(
            to: CGPoint(
                x: width * 0.95,
                y: height * 0.20
            )
        )
    }
    .fill(Color.black)
}
```

**Step 4** <br>
대략적인 육각형 모양을 만들기 위해 shape 데이터릐 각 점에 대한 선을 그린다.
addLine(to:) 메서드는 단일 점을 가져와 그린다.
addLine(to:)에 대한 연속적인 호출은 이전 지점에서 줄이 시작되고 새 지점으로 계속된다.

```swift
var body: some View {
    Path { path in
        var width: CGFloat = 100.0
        let height = width
        path.move(
            to: CGPoint(
                x: width * 0.95,
                y: height * 0.20
            )
        )

        HexagonParameters.segments.forEach { segment in
            path.addLine(
                to: CGPoint(
                    x: width * segment.line.x,
                    y: height * segment.line.y
                )
            )
        }
    }
    .fill(Color.black)
}
```

육각형이 조금 이상해 보이더라도 걱정하지 않아도 된다.
모양의 모서리에서 각 세그먼트의 곡선 부분을 무시하기 때문이다.
다음으로 그것을 설명한다.

**Step 5** <br>
addQuadCurve(to:control:) 메서드를 사용하여 배지 모서리에 대한 Bézier 곡선을 그린다.

```swift
var body: some View {
    Path { path in
        var width: CGFloat = 100.0
        let height = width
        path.move(
            to: CGPoint(
                x: width * 0.95,
                y: height * (0.20 + HexagonParameters.adjustment)
            )
        )

        HexagonParameters.segments.forEach { segment in
            path.addLine(
                to: CGPoint(
                    x: width * segment.line.x,
                    y: height * segment.line.y
                )
            )

            path.addQuadCurve(
                to: CGPoint(
                    x: width * segment.curve.x,
                    y: height * segment.curve.y
                ),
                control: CGPoint(
                    x: width * segment.control.x,
                    y: height * segment.control.y
                )
            )
        }
    }
    .fill(Color.black)
}
```

**Step 6** <br>
배지가 값(100)을 하드코딩하는 대신 크기를 정의하는 뷰의 크기를 사용할 수 있도록 GeometryReader에서 경로를 감싼다.
형상의 두 치수 중 가장 작은 치수를 사용하면 배지의 포함 뷰가 정사각형이 아닐 때 배지의 가로 세로 비율이 유지된다.

```swift
var body: some View {
    GeometryReader { geometry in
        Path { path in
            var width: CGFloat = min(geometry.size.width, geometry.size.height)
            let height = width
            path.move(
                to: CGPoint(
                    x: width * 0.95,
                    y: height * (0.20 + HexagonParameters.adjustment)
                )
            )

            HexagonParameters.segments.forEach { segment in
                path.addLine(
                    to: CGPoint(
                        x: width * segment.line.x,
                        y: height * segment.line.y
                    )
                )

                path.addQuadCurve(
                    to: CGPoint(
                        x: width * segment.curve.x,
                        y: height * segment.curve.y
                    ),
                    control: CGPoint(
                        x: width * segment.control.x,
                        y: height * segment.control.y
                    )
                )
            }
        }
        .fill(Color.black)
    }
}
```

**Step 7** <br>
xScale을 사용하여 x축에서 모양의 크기를 조정한 다음 xOffset을 추가하여 해당 구조 내에서 모양을 가운데에 맞춘다.

```swift
var body: some View {
    GeometryReader { geometry in
        Path { path in
            var width: CGFloat = min(geometry.size.width, geometry.size.height)
            let height = width
            let xScale: CGFloat = 0.832
            let xOffset = (width * (1.0 - xScale)) / 2.0
            path.move(
                to: CGPoint(
                    x: width * 0.95 + xOffset,
                    y: height * (0.20 + HexagonParameters.adjustment)
                )
            )

            HexagonParameters.segments.forEach { segment in
                path.addLine(
                    to: CGPoint(
                        x: width * segment.line.x + xOffset,
                        y: height * segment.line.y
                    )
                )

                path.addQuadCurve(
                    to: CGPoint(
                        x: width * segment.curve.x + xOffset,
                        y: height * segment.curve.y
                    ),
                    control: CGPoint(
                        x: width * segment.control.x + xOffset,
                        y: height * segment.control.y
                    )
                )
            }
        }
        .fill(Color.black)
    }
}
```

**Step 8** <br>
검은 단색 배경을 설계에 맞게 그라데이션으로 대체한다.

```swift
.fill(LinearGradient(
    gradient: Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
    startPoint: UnitPoint(x: 0.5, y: 0),
    endPoint: UnitPoint(x: 0.5, y: 0.6)
))
```

**Step 9** <br>
gradient fill에 aspectRatio(_:contentMode:) modifier를 적용한다.
1 : 1 가로 세로 비율를 유지함으로써 배지는 상위뷰가 정사각형이 아니더라도 뷰의 중심에서 위치를 유지한다.

```swift
GeometryReader { geometry in
    ...
}
.aspectRatio(1, contentMode: .fit)
```

### Section 3
## Draw the Badge Symbol

<p align="center">
    <img width="304" src="https://user-images.githubusercontent.com/60697742/130547036-b9666ef7-7901-4ebc-806d-245e56bab3fb.png">
</p>


Landmark 배지의 중앙에는 Landmark 앱 아이콘이 나타나는 산을 기반으로 한 맞춤형 휘장이 있다.

산의 상징은 두 가지 모양으로 구성되어 있다.
하나는 봉우리에 있는 눈 덮인 곳을 나타내고 다른 하나는 접근로에 있는 초목을 나타낸다.
작은 간격으로 분리된 두 개의 부분 삼각형 모양을 사용하여 그린다.

먼저 앱 아이콘을 지정하여 배지 모양을 설정한다.

**Step 1** <br>
프로젝트의 Asset 카탈로그에서 빈 AppIcon 항목을 삭제하고 다운로드한 프로젝트의 AppIcon.appiconset 폴더를 Asset 카탈로그로 드래그 한다.
Xcode는 폴더를 앱 아이콘의 모든 크기 변형이 포함된 것으로 인식하고 카탈로그에 해당 항목을 생성한다.

다음으로 일치하는 배지 상징을 만든다.

**Step 2** <br>
배지 디자인에서 회전된 패턴으로 스탬프 처리된 산 모양에 대해 BadgeSymbol이라는 새 사용자 지정 뷰를 생성한다.

**Step 3** <br>
path API를 사용하여 상징의 상단 부분을 그린다.
spacing, topWidth 및 topHeight 상수와 관련된 숫자를 조정하여 전체 모양에 미치는 영향을 확인한다.

```swift
struct BadgeSymbol: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width * 0.5
                let topWidth = width * 0.226
                let topHeight = height * 0.488

                path.addLines([
                    CGPoint(x: middle, y: spacing),
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: spacing)
                ])
            }
        }
    }
}
```

**Step 4** <br>
상징의 아래쪽 부분을 그린다.
move(to:) modifier를 사용하여 동일한 경로에 있는 여러 모양 사이에 간격을 삽입한다.

```swift
path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
path.addLines([
    CGPoint(x: middle - topWidth, y: topHeight + spacing),
    CGPoint(x: spacing, y: height - spacing),
    CGPoint(x: width - spacing, y: height - spacing),
    CGPoint(x: middle + topWidth, y: topHeight + spacing),
    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
])
```

**Step 5** <br>
보라색으로 상징을 채운다.

```swift
static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
```

**Step 6** <br>
회전된 상징의 개념을 캡슐화하는 새로운 RotatedBadgeSymbol 뷰를 만든다.
미리보기에서 각도를 조정하여 회전 효과를 테스트한다.

```swift
struct RotatedBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}
```

### Section 4
## Combine the Badge Foreground and Background

<p align="center">
    <img width="455" src="https://user-images.githubusercontent.com/60697742/130548439-79cda86c-743a-47f7-8d16-8b521330dba1.png">
</p>

배지 디자인은 배지 배경 위에서 산 모양을 여러 번 회전하고 반복해야 한다.

새로운 회전 유형을 정의하고 ForEach 뷰를 활용하여 산 모양의 여러 복사본에 동일한 조정을 적용한다.

**Step 1** <br>
Badge라는 새 SwiftUI 뷰를 생성한다.

**Step 2** <br>
Badge의 body 부분에 BadgeBackground를 배치한다.

```swift
struct Badge: View {
    var body: some View {
        BadgeBackground()
    }
}
```

**Step 3** <br>
배지의 상징을 ZStack에 배치하여 배지 배경 위에 놓는다.

```swift
struct Badge: View {
    var badgeSymbols: some View {
        RotatedBadgeSymbol(angle: Angle(degrees: 0))
            .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            badgeSymbols
        }
    }
}
```

지금 보이는 것처럼 배지 상징이 의도한 디자인과 배경의 상대적 크기에 비해 너무 크다.

**Step 4** <br>
주변 구조를 읽고 상징 크기를 조정하여 배지 상징의 크기를 수정한다.

```swift
var body: some View {
    ZStack {
        BadgeBackground()
            
        GeometryReader { geometry in
            badgeSymbols
                .scaleEffect(1.0 / 4.0, anchor: .top)
                .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
        }
    }
}
```

**Step 5** <br>
ForEach 뷰를 추가하어 배지 상징의 복사본을 회전하고 표시한다.
전체 360° 회전이 8개의 세그먼크로 분할되어 산 상징을 반복하여 태양과 같은 패턴을 만든다.

```swift
static let rotationCount = 8

var badgeSymbols: some View {
    ForEach(0..<Badge.rotationCount) { i in
        RotatedBadgeSymbol(
            angle: .degrees(Double(i) / Double(Badge.rotationCount)) * 360.0
        )
    }
    .opacity(0.5)
}
```

**Step 6** <br>
프로젝트를 체계적으로 유지하기 위해 다음 tutorial로 이동하기 전에 이 tutorial에서 추가한 모든 새 파일을 Badges 그룹으로 추가한다.