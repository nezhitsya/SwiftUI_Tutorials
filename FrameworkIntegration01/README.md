## Framework Integration
# Interfacing with UIKit

SwiftUI는 모든 Apple 플랫폼의 기존 UI 프레임워크와 원활하게 작동한다.
예를 들어, UIKit 뷰와 뷰 컨트롤러를 SwiftUI 뷰 내에 배치할 수 있으며 그 반대의 경우도 마찬가지이다.

이 tutorial에서는 UIPageViewController 및 UIPageControl의 인스턴스를 감싸기 위해 홈 화면에서 주요 landmark를 변환하는 방법을 보여준다.
UIPageViewController를 사용하여 다양한 SwiftUI 뷰를 표시하고 state 변수와 바인딩을 사용하여 사용자 인터페이스 전체에서 데이터 업데이트를 조정한다.

### Section 1
## Create a View to Represent a UIPageViewController

SwiftUI에서 UIKit 뷰 및 뷰 컨트롤러를 나타내려면 UIViewRepresentable 및 UIViewControllerRepresentable 프로토콜을 준수하는 유형을 생성한다.
사용자 정의 유형은 해당 유형이 나타내는 UIKit 유형을 생성 및 구성하는 반면, SwiftUI는 수명 주기를 관리하고 필요할 때 업데이트한다.

**Step 1** <br>
프로젝트의 Views 폴더에 PageView 그룹을 만들고 PageViewController.swift라는 새 Swift 파일을 추가한다.
PageViewController 유형을 UIViewControllerRepresentable을 준수하는 것으로 선언한다.
페이지 뷰 컨트롤러에는 일련의 페이지 인스턴스가 저장되며, 이러한 인스턴스는 View 유형이어야 한다.
landmark 사이를 스크롤하는데 사용하는 페이지이다.

```swift
import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]

}
```

다음으로 UIViewControllerRepresentable 프로토콜에 대한 두 가지 요구사항을 추가한다.

**Step 2** <br>
원하는 구성으로 UIPageViewController를 생성하는 makeUIViewController(context:) 메서드를 추가한다.
SwiftUI는 뷰를 표시할 준비가 되었을 때 이 메서드를 한 번 호출한 후 뷰 컨트롤러의 수명주기를 관리한다.

```swift
func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)

    return pageViewController
}
```

**Step 3** <br>
setViewControllers(_:direction:animated:)를 호출하여 표시할 뷰 컨트롤러를 제공하는 updateUIViewController( :context:) 메서드를 추가한다.
지금은 모든 업데이트에서 페이지 SwiftUI 뷰를 호스팅하는 UIHostingController를 생성한다.
후에, 페이지 뷰 컨트롤러의 수명동안 컨트롤러를 한 번만 초기화하여 이를 보다 효율적으로 만들 것이다.

```swift
func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
    pageViewController.setViewControllers(
        [UIHostingController(rootView: pages[0])], direction: .forward, animated: true)
}
```

계속하기 전에, 페이지로 사용할 기능 카드를 준비한다.

**Step 4** <br>
다운로드한 프로젝트 파일의 Resources 디렉토리에 있는 이미지를 앱의 Asset 카탈로그로 드래그한다.
landmark의 특징 이미지가 있는 경우, 일반 이미지와 크기가 다르다.

**Step 5** <br>
특징 이미지가 있는 경우, 이를 반환하는 Landmark 구조에 계산된 속성을 추가한다.

```swift
var featureImage: Image? {
    isFeatured ? Image(imageName + "_feature") : nil
}
```

**Step 6** <br>
landmark의 특징 이미지를 표시하는 FeatureCard.swift라는 새 SwiftUI 뷰 파일을 추가한다.

```swift
struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}
```

**Step 7** <br>
이미지의 landmark에 대한 텍스트 정보를 오버레이한다.

```swift
struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlay(landmark: landmark))
    }
}

struct TextOverlay: View {
    var landmark: Landmark

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
```

다음으로 UIViewControllerRepresentable 뷰를 표시하는 사용자 지정 뷰를 생성한다.

**Step 8** <br>
PageView.swift라는 새 SwiftUI 뷰 파일을 생성하고 PageView 유형을 업데이트하여 PageViewController를 자식 뷰로 선언한다.
Xcode가 Page의 유형을 유추할 수 없기 때문에 미리보기가 실패한다.

```swift
struct PageView<Page: View>: View {
    var pages: [Page]

    var body: some View {
        PageViewController(pages: pages)
    }
}
```

**Step 9** <br>
필요한 뷰 배열을 전달하도록 PreviewProvider를 업데이트하면 미리보기가 작동하기 시작한다.

```swift
struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
```

### Section 2
## Create the View Controller’s Data Source

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

### Section 3
## Track the Page in a SwiftUI View’s State

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

### Section 4
## Add a Custom Page Control

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>