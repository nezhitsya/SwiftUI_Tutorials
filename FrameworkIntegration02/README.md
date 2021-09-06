## Framework Integration
# Creating a watchOS App

이 tutorial은 SwiftUI에 대해 이미 배운 것을 많이 적용할 수 있는 기회를 제공하고 약간의 노력으로 Landmarks 앱을 watchOS로 이행할 수 있다.

iOS 앱 용으로 만든 공유 데이터와 뷰를 복샇가ㅣ 전에 먼저 watchOS 대상을 프로젝트에 추가한다.
모든 assets이 제자리에 있으면 SwiftUI 뷰를 설정하여 watchOS에 세부 정보 및 목록 뷰를 표시한다.

### Section 1
## Add a watchOS Target

<p align="center">
    <img width="388" src="https://user-images.githubusercontent.com/60697742/132153851-9c425057-c12e-475b-a77a-0666bf00d91c.png">
</p>

watchOS 앱을 만들기 위해서 먼저 watchOS 대상을 프로젝트에 추가한다.
Xcode는 watchOS 앱에 대한 그룹 및 파일을 앱 빌드와 실행에 필요한 체계와 함께 프로젝트에 추가한다.

**Step 1** <br>
File > New > Target을 선택한다.
템플릿 시트가 나타나면 watchOS 탭을 선택하고 iOS 앱용 Watch App 템플릿을 선택한 후 Next를 누른다.
이 템플릿은 iOS 앱을 동행하도록 설정하여 프로젝트에 새로운 watchOS 앱을 추가한다.

**Step 2** <br>
시트에서 제품 이름으로 WatchLandmarks를 입력한다.
Interface를 SwiftUI로, LifeCycle을 SwiftUI App으로, Language를 Swift로 설정한다.
Include Notification Scene 확인란을 선택한 다음 Finish를 누른다.

**Step 3** <br>
Xcode에서 WatchLandmarks(Complication) 구성표를 활성화하라는 메시지가 표시되면 Cancel을 누른다.
대신 다음에 선택하는 WatchLandmarks 구성표로 시작하고 싶을 것이다.

**Step 4** <br>
WatchLandmarks 구성표를 선택한다.
이를 통해 watchOS 앱을 빌드하고 실행할 수 있다.

**Step 5** <br>
WatchLadmarks Extension 프로젝트를 선택하고 프로젝트의 일반 탭으로 이동한다.
iOS 앱 설치 없이 실행 지원 확인란을 선택한다.
가능하면 독립적인 watchOS 앱을 만든다.
독립적인 watchOS 앱에는 iOS 동반 앱이 필요하지 않다.

### Section 2
## Share Files Between Targets

<p align="center">
    <img width="388" src="https://user-images.githubusercontent.com/60697742/132154757-73c767f5-2305-4f5d-8f2f-5d58ecbf98ef.png">
</p>

watchOS 대상이 설정되면 iOS 대상에서 일부 자원을 공유해야 한다.
Landmark 앱의 데이터 모델, 일부 리소스 파일 및 두 플랫폼 수정 없이 표시할 수 있는 모든 뷰를 재사용한다.

먼저 watchOS 앱의 진입점을 삭제한다.
LandmarksApp.swift에 정의된 진입점을 대신 재활용할 것이기 때문에 필요하지 않다.

**Step 1** <br>
프로젝트 네비게이터에서 WatchLandmarks Extension 폴더의 첫 번째 항목을 삭제한다.
메시지가 표시되면 휴지통으로 이동을 선택한다.
이 파일에는 Watch 관련 앱 정의가 있다.
이름은 Xcode 프로젝트 이름에 따라 다르지만 항상 WatchLandmarks Extension 그룹의 첫 번째 항목이다.
다음 몇 단계에서 대신 iOS 앱 정의를 재사용한다.

다음으로 watchOS 대상이 기존 iOS 대상과 공유할 수 있는 앱의 진입점을 포함하여 모든 파일을 선택한다.

**Step 2** <br>
프로젝트 네비게이터에서 다음 파일을 Command-클릭하여 선택한다. :
    LandmarksApp.swift, LandmarkList.swift, LandmarkRow.swift, CircleImage.swift, MapView.swift
첫 번째는 공유 앱 정의이다.
나머지는 앱이 변경 없이 watchOS에 표시할 수 있는 뷰이다.

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

### Section 3
## Create the Detail View

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

**Step 8** <br>

**Step 9** <br>

**Step 10** <br>

### Section 4
## Add the Landmarks List

**Step 1** <br>

**Step 2** <br>

### Section 5
## Create a Custom Notification Interface

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

**Step 8** <br>

**Step 9** <br>