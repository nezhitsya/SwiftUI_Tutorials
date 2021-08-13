## SwiftUI Essentials
# Creating and Combining Views

좋아하는 장소를 발견하고 공유하는 Landmarks 어플리케이션을 개발하는 튜토리얼 가이드이다.
Landmarks의 세부 정보를 보여주는 뷰를 구축하는 것으로 시작된다.

뷰를 배치하기 위해 Landmarks는 이미지 및 텍스트 뷰를 결합하고 계층화하기 위해 stacks를 사용한다.
지도를 뷰에 삽입하기 위해서, 표준 MapKit를 포함한다.
뷰의 디자인을 다듬을 때, Xcode는 실시간 피드백을 제공하여 변경 사항이 코드로 어떻게 변환되는지 확인할 수 있다.

### Section 1
## Create a New Project and Explore the Canvase

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