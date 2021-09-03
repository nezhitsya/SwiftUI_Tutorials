## Framework Integration
# Interfacing with UIKit

SwiftUI는 모든 Apple 플랫폼의 기존 UI 프레임워크와 원활하게 작동한다.
예를 들어, UIKit 뷰와 뷰 컨트롤러를 SwiftUI 뷰 내에 배치할 수 있으며 그 반대의 경우도 마찬가지이다.

이 tutorial에서는 UIPageViewController 및 UIPageControl의 인스턴스를 감싸기 위해 홈 화면에서 주요 landmark를 변환하는 방법을 보여준다.
UIPageViewController를 사용하여 다양한 SwiftUI 뷰를 표시하고 state 변수와 바인딩을 사용하여 사용자 인터페이스 전체에서 데이터 업데이트를 조정한다.

### Section 1
## Create a View to Represent a UIPageViewController

<p align="center">
    <img width="326" src="https://user-images.githubusercontent.com/60697742/131952789-7ed721e3-25b5-4f8b-9629-f663a26ef1a5.png">
</p>

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

<p align="center">
    <img width="326" src="https://user-images.githubusercontent.com/60697742/131952725-bc40e51a-a28c-452e-b643-ddb51a8e595b.png">
</p>

몇 가지 짧은 단계에 많은 작업을 수행했다.
PageViewController는 UIPageViewController를 사용하여 SwiftUI 뷰의 콘텐츠를 표시한다.
이제 스와이프 상호작용을 활성화하여 페이지에서 페이지로 이동할 차례이다.

UIKit 뷰 컨트롤러를 나타내는 SwiftUI 뷰는 SwiftUI가 표현 가능한 뷰의 맥락의 일부로 관리하고 제공하는 coordinator 유형을 정의할 수 있다.

**Step 1** <br>
PageViewController 내부에 중첩된 Coordinator 클래스를 선언한다.
SwiftUI는 UIViewControllerRepresentable 유형의 coordinator를 관리하고 위에서 생성한 메서드를 호출할 때 맥락의 일부로 이를 제공한다.

```swift
class Coordinator: NSObject {
    var parent: PageViewController

    init(_ pageViewController: PageViewController) {
        parent = pageViewController
    }
}
```

**Step 2** <br>
PageViewController에 다른 메서드를 추가하여 coordinator를 만든다.
SwiftUI는 makeUIViewController(context:) 전에 이 makeCoordinator() 메서드를 호출하므로 뷰 컨트롤러를 구성할 때 coordinator 객체에 접근할 수 있다.
이 coordinator를 사용하여 delegates, datasources 및 target-action을 사용하여 사용자 이벤트 응답과 같은 일반적인 Cocoa 패턴을 구현할 수 있다.

```swift
func makeCoordinator() -> Coordinator {
    Coordinator(self)
}
```

**Step 3** <br>
뷰의 페이지 배열을 사용하여 coordinator에서 컨트롤러 배열을 초기화한다.
coordinator는 이러한 컨트롤러를 저장하기에 좋은 장소이다.
시스템은 컨트롤러를 한 번만 초기화하고 뷰 컨트롤러를 업데이트 하기 전에 컨트롤러를 초기화하기 때문이다.

```swift
func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
    pageViewController.setViewControllers(
        [context.coordinator.controllers[0]], direction: .forward, animated: true)
}

class Coordinator: NSObject {
    var parent: PageViewController
    var controllers = [UIViewController]()

    init(_ pageViewController: PageViewController) {
        parent = pageViewController
        controllers = parent.pages.map { UIHostingController(rootView: $0) }
    }
}
```

**Step 4** <br>
Coordinator 유형에 UIPageViewControllerDataSource 적합성을 추가하고 두 가지 필수 메서드를 구현한다.
이 두 가지 방법은 뷰 컨트롤러 간의 관계를 설정하므로 앞뒤로 스와이프할 수 있다.

```swift
class Coordinator: NSObject, UIPageViewControllerDataSource {
    var parent: PageViewController
    var controllers = [UIViewController]()

    init(_ pageViewController: PageViewController) {
        parent = pageViewController
        controllers = parent.pages.map { UIHostingController(rootView: $0) }
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        if index == 0 {
            return controllers.last
        }
        return controllers[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let index = controllers.firstIndex(of: viewController) else {
            return nil
        }
        if index + 1 == controllers.count {
            return controllers.first
        }
        return controllers[index + 1]
    }
}
```

**Step 5** <br>
UIPageViewController의 DataSource로 coordinator를 추가한다.

```swift
func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator

    return pageViewController
}
```

**Step 6** <br>
PageView로 돌아가서 실시간 미리보기를 켜고 스와이프 상호 작용을 테스트한다.

### Section 3
## Track the Page in a SwiftUI View’s State

<p align="center">
    <img width="326" src="https://user-images.githubusercontent.com/60697742/131952674-59a9bd37-e528-4d4d-bec9-ea7258b0e0a5.png">
</p>

사용자 정의 UIPageControl 추가를 준비하기 위해서 PageView 내에 현재 페이지를 추적하는 방법이 필요하다.

이렇게 하려면 PageView에서 @State 속성을 선언하고 이 속성에 대한 바인딩을 PageViewController 뷰로 전달한다.
PageViewController는 보이는 페이지와 일치하도록 바인딩을 업데이트한다.

**Step 1** <br>
먼저 CurrentPage 바인딩을 PageViewController의 속성으로 추가한다.
@Binding 속성을 선언하는 것 외에도 setViewControllers(_:direction:animated:)에 대한 호출을 업데이트하여 currentPage 바인딩 값을 전달한다.

```swift
@Binding var currentPage: Int

func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
    pageViewController.setViewControllers(
        [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
}
```

**Step 2** <br>
PageView에서 @State 변수를 선언하고 자식 PageViewController를 생성할 때 속성에 바인딩을 전달한다.
$ 구문을 사용하여 state로 저장된 값에 대한 바인딩을 만드는 것을 기억해야 한다.

```swift
struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0

    var body: some View {
        PageViewController(pages: pages, currentPage: $currentPage)
    }
}
```

**Step 3** <br>
초기 값을 변경하여 값이 바인딩을 통해 PageViewController로 흐르는지 테스트한다.
페이지 뷰 컨트롤러가 두 번째 뷰로 이동하도록 하는 버튼을 PageView에 추가한다.

**Step 4** <br>
@State 속성 값을 주시할 수 있도록 currentPage 속성을 사용하여 텍스트 뷰를 추가한다.
페이지에서 페이지로 스와이프해도 값이 변경되지 않는다.

```swift
@State private var currentPage = 0

var body: some View {
    VStack {
        PageViewController(pages: pages, currentPage: $currentPage)
        Text("Current Page: \(currentPage)")
    }
}
```

**Step 5** <br>
PageViewController.swift에서 coordinator를 UIPageViewControllerDelegate에 따르고 pageViewController(_:didFinishAnimating:previousViewControllers:transitionCompleted completed: Bool) 메서드를 추가한다.
SwiftUI는 페이지 전환 애니메이션이 완료될 때마다 이 메서드를 호출하기 때문에 현재 뷰 컨트롤러의 인덱스를 찾고 바인딩을 업데이트할 수 있다.

```swift
func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool) {
    if completed,
       let visibleViewController = pageViewController.viewControllers?.first,
        let index = controllers.firstIndex(of: visibleViewController) {
        parent.currentPage = index
    }
}
```

**Step 6** <br>
dataSource와 함께 UIPageViewController에 대한 delegate로 coordinator를 할당한다.
바인딩이 양방향으로 연결된 상태에서 텍스트 뷰는 스와이프할 때마다 올바른 페이지 번호를 표시하도록 업데이트된다.

```swift
func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator

    return pageViewController
}
```

### Section 4
## Add a Custom Page Control

<p align="center">
    <img width="326" src="https://user-images.githubusercontent.com/60697742/131953915-720958f2-d715-41c8-9c9e-e81ed5070c22.png">
</p>

SwiftUI UIViewRepresentable 뷰로 감싸진 사용자 정의 UIPageControl을 뷰에 추가할 준비가 되었다.

**Step 1** <br>
PageControl.swift라는 새 SwiftUI 뷰 파일을 만든다.
UIViewRepresentable 프로토콜을 준수하도록 PageControl 유형을 업데이트한다.
UIViewRepresentable 및 UIViewControllerRepresentable 유형은 기본 UIKit 유형에 해당하는 메서드와 함께 동일한 수명 주기를 갖는다.

```swift
import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
```

**Step 2** <br>
텍스트 상자를 페이지 컨트롤로 변경하고 레이아웃을 위패 VStack에서 ZStack으로 전환한다.
페이지 수와 현재 페이지에 대한 바인딩을 전달하기 때문에 페이지 컨트롤리 이미 올바른 값을 표시하고 있다.

```swift
var body: some View {
    ZStack(alignment: .bottomTrailing) {
        PageViewController(pages: pages, currentPage: $currentPage)
        PageControl(numberOfPages: pages.count, currentPage: $currentPage)
            .frame(width: CGFloat(pages.count * 18))
            .padding(.trailing)
    }
}
```

다음으로, 페이지 컨트롤을 대화형으로 만들어 사용자가 한 쪽 또는 다른 쪽을 눌러 페이지 사이를 이동할 수 있도록 한다.

**Step 3** <br>
PageControl에 중첩된 Coordinator 유형을 만들고 makeCoordinator() 메서드를 추가하여 새 coordinator를 만들고 반환한다.
UIPageControl과 같은 UIControl 서브클래스는 위임 대신 target-action 패턴을 사용하기 때문에 이 coordinator는 @objc 메서드를 구현하여 현재 페이지 바인딩을 업데이트한다.

```swift
func makeCoordinator() -> Coordinator {
    Coordinator(self)
}

class Coordinator: NSObject {
    var control: PageControl

    init(_ control: PageControl) {
        self.control = control
    }

    @objc
    func updateCurrentPage(sender: UIPageControl) {
        control.currentPage = sender.currentPage
    }
}
```

**Step 4** <br>
수행할 작업으로 updateCurrentPage(sender:) 메서드를 지정하여 coordinator를 valueChanged 이벤트의 대상으로 추가한다.

```swift
func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.addTarget(
        context.coordinator,
        action: #selector(Coordinator.updateCurrentPage(sender:)),
        for: .valueChanged)

    return control
}

```

**Step 5** <br>
마지막으로 CategoryHome에서 placeholder 기능 이미지를 새 페이지 뷰로 바꾼다.

```swift
PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
    .aspectRatio(3 / 2, contentMode: .fit)
    .listRowInsets(EdgeInsets())
```

**Step 6** <br>
이제 다양한 모든 상호작용을 시도한다.
PageView는 UIKit 및 SwiftUI 뷰 및 컨트롤러가 함께 작동할 수 있는 방법을 보여준다.