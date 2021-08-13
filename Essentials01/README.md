## SwiftUI Essentials
# Creating and Combining Views

좋아하는 장소를 발견하고 공유하는 Landmarks 어플리케이션을 개발하는 튜토리얼 가이드이다.
Landmarks의 세부 정보를 보여주는 뷰를 구축하는 것으로 시작된다.

뷰를 배치하기 위해 Landmarks는 이미지 및 텍스트 뷰를 결합하고 계층화하기 위해 stacks를 사용한다.
지도를 뷰에 삽입하기 위해서, 표준 MapKit를 포함한다.
뷰의 디자인을 다듬을 때, Xcode는 실시간 피드백을 제공하여 변경 사항이 코드로 어떻게 변환되는지 확인할 수 있다.

### Section 1
## Create a New Project and Explore the Canvas

SwiftUI를 사용하는 새로운 Xcode 프로젝트를 생성한다.
캔버스, 미리보기 및 SwiftUI 템플릿 코드를 살펴본다.

Xcode의 캔버스에서 뷰를 미리보고 상호작용하고, 튜토리얼 전반에 걸쳐 설명된 모든 최신 기능을 사용하기 위해서 Mac에서 macOS Big Sur 이상을 실행중인지 확인한다.

**Step 1** <br>
Xcode를 열고 Xcode의 시작 화면의 "Create a new Xcode project"를 누르거나, File > New > Project를 선택한다.

**Step 2** <br>
템플릿 선택 창에서, iOS 플랫폼의 App 템플릿을 선택한 후 다음으로 넘어간다.

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
body 속성 내에서, "Hello, World!"를 다른 인사말로 변경한다.
뷰의 body 속성에서 코드를 변경하면, 미리 보기는 변경 사항을 반영하여 덥데이트된다.

### Section 2
## Customize the Text View

코드를 변경하거나 인스펙터를 사용하여 사용 가능한 항목을 찾고 코드 작성에 도움을 주어 뷰의 화면을 바꿀 수 있다.
Landmarks 앱을 빌드할 때, 소스 편집기, 캔버스 또는 inspector와 같은 편집기 조합을 사용할 수 있다.
사용하는 도구에 관계없이 코드는 업데이트된 상태로 유지된다.

_inspector를 사용한 텍스트 뷰 변경_ <br>
**Step 1** <br>
미리 보기에서, 인사말을 Command - 클릭하여 구조화 된 편집 팝오버를 불러오고 "Show SwiftUI Inspector"를 선택한다.
팝오버는 검사하는 뷰 유형에 따라 변경할 수 있는 다양한 속성을 보여준다.

**Step 2** <br>
inspector를 사용해 텍스트를 앱에 표시할 첫 번째 landmark 이름인 "Turtle Rock"으로 변경한다.

**Step 3** <br>
글꼴을 "Title"로 변경한다.
이는 시스템 글꼴이 텍스트에 적용되어 사용자가 선호하는 글꼴 사이즈와 설정에 올바르게 응답한다.

SwiftUI 뷰를 변경하기 위해서 modifiers라 불리는 메소드를 호출한다.
modifiers는 뷰를 감싸 화면이나 기타 속성을 변경한다.
각 modifier는 새로운 뷰를 반환하므로, 일반적으로 수직으로 쌓인 여러 modifier를 연결한다.

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
