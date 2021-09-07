## Framework Integration
# Creating a macOS App

watchOS용 Landmarks 앱 버전을 만든 후에는 더 큰 목표를 세울 때다.
Landmarks를 Mac으로 가져오는 것이다.
지금까지 배운 모든 것을 바탕으로 iOS, watchOS 및 macOS용 SwiftUI 앱 빌드 경험을 완성할 것이다.

프로젝트에 macOS 대상을 추가한 다음 이전에 생성한 뷰와 데이터를 재사용하는 것으로 시작한다.
기반이 마련되면 macOS에 맞는 몇 가지 새로운 뷰를 추가하고 플랫폼에서 더 잘 작동하도록 다른 뷰를 수정한다.

### Section 1
## Add a macOS Target to the Project

<p align="center">
    <img width="514" src="https://user-images.githubusercontent.com/60697742/132270338-e4f3b285-0973-42b2-a940-211268414df2.png">
</p>

프로젝트에 macOS 대상을 추가하여 시작한다.
Xcode는 앱을 빌드하고 실행하는데 필요한 체계와 함께 macOS 앱을 위한 새로운 그룹 및 시작 파일 세트를 추가한다.
그런 다음 일부 기존 파일을 새 대상에 추가한다.

앱을 미리보고 실행할 수 있으려면 Mac에서 macOS BigSur 이상을 실행 중인지 확인한다.

**Step 1** <br>
File > New > Target을 선택한다.
템플릿 시트가 나타나면 macOS 탭을 선택하고 App template을 선택한 후 Next를 누른다.
이 템플릿은 프로젝트에 새 macOS 앱 대상을 추가한다.

**Step 2** <br>
시트에서 제품 이름으로 MacLandmarks를 입력한다.
Interface를 SwiftUI로, life cycle은 SwiftUI App으로, language를 Swift로 설정한 후 Finish를 누른다.

**Step 3** <br>
구성표를 MacLandmarks > My Mac으로 설정한다.
구성표를 내 Mac으로 설정하면 macOS 앱을 미리보고 빌드하고 실행할 수 있다.
tutorial을 진행하면서 다른 구성표를 사용하여 다른 대상이 공유 파일의 변경 사항에 어떻게 반응하는지 주시하게 된다.

**Step 4** <br>
MacLandmarks 그룹에서 ContentView.swift를 선택하고 캔버스를 연 후 Resume을 눌러 미리보기를 확인한다.
SwiftUI는 iOS 앱과 마찬가지로 기본 메인 뷰와 미리보기 provider를 모두 제공하므로 앱의 기본 창을 미리볼 수 있다.

**Step 5** <br>
프로젝트 네비게이터에서 MacLandmarks 그룹의 MacLandmarksApp.swift 파일을 삭제한다.
메시지가 표시되면 Move to Trash를 선택한다.
watchOS 앱과 마찬가지로 이미 있는 기본 앱 구조를 다시 사용하기 때문에 기본 앱 구조가 필요하지 않다.

다음으로 iOS 앱의 뷰, 모델 및 리소스 파일을 macOS 대상과 공유한다.

**Step 6** <br>
프로젝트 네비게이터에서 다음 파일을 Command-클릭하여 선택한다. : 
    LandmarksApp.swift,LandmarkList.swift, LandmarkRow.swift, CircleImage.swift, MapView.swift, and FavoriteButton.swift.
첫 번째는 공유 앱의 정의이다.
나머지는 macOS에서 작동하는 뷰이다.

**Step 7** <br>
계속 Command 키를 누른 상태에서 클릭하여 Model 및 Resources 폴더와 Asset.xcassets의 모든 항목을 선택한다.
이러한 항목은 앱의 데이터 모델과 리소스를 정의한다.

**Step 8** <br>
File inspector에서 선택한 파일의 대상 구성원에 MacLandmarks를 추가한다.

다른 대상과 일치하도록 macOS 앱 아이콘 세트를 추가한다.

**Step 9** <br>
MacLandmarks 그룹에서 Assets.xcasset 파일을 선택하고 빈 AppIcon 항목을 삭제한다.
다음 단계에서 이것을 교체한다.

**Step 10** <br>
다운로드한 프로젝트의 Resources 폴더에서 AppIcon.appiconset 폴더를 MacLandmark의 Asset 카탈로그로 드래그한다.

**Step 11** <br>
MacLandmarks 그룹의 ContentView에서 프레임 크기에 대한 제약 조건으로 LandmarkList를 최상위 뷰로 추가한다.
LandmarkList가 LandmarkDetail을 사용하기 때문에 더 이상 미리보기가 빌드되지 않지만, 아직 macOS 앱에 대한 상세 뷰를 정의하지 않았다.
다음 section에서 처리할 것이다.

```swift
struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
```

### Section 2
## Create a macOS Detail View

<p align="center">
    <img width="348" src="https://user-images.githubusercontent.com/60697742/132271175-7a491ada-8ac5-429a-a142-90dd6ebd5ff1.png">
</p>

상세 뷰는 선택한 landmark에 대한 정보가 표시된다.
iOS 앱에 대해 이와 같은 뷰를 만들었지만 플랫폼마다 데이터 표시에 대해 다른 접근 방식이 필요하다.

때로는 약간의 조정이나 조건부 컴파일로 플랫폼 간에 뷰를 재사용할 수 있지만 세부 뷰는 macOS에 대해 충분히 다르기 때문에 전용 뷰를 만드는 것이 더 좋다.
iOS 세부 정보 뷰를 시작점으로 복사한 후 macOS의 더 큰 화면에 맞게 수정한다.

**Step 1** <br>
LandmarkDetail이라는 macOS를 대상으로 하는 MacLandmarks 그룹에서 새로운 사용자 정의 뷰를 생성한다.
이제 LandmarkDetail.swift는 세 개의 파일이 있다.
각각의 뷰 계층 구조에서 동일한 목적을 수행하지만 특정 플랫폼에 맞게 조정된 경험을 제공한다.

**Step 2** <br>
iOS 세부 정보 뷰 콘텐츠를 macOS 세부 정보 뷰로 복사한다.
macOS에서는 navigationBarTitleDisplayMode(_:) 메서드를 사용할 수 없기 때문에 미리보기가 실패한다.

**Step 3** <br>
더 많은 내용을 볼 수 있도록 navigationBarTitleDisplayMode(_:) modifier를 삭제하고 미리보기에 프레임 modifier를 추가한다.
실시간 미리보기를 시작하지 않는 한 MapView는 비어있다.

다음 몇 단계에서 변경할 사항은 Mac의 더 큰 화면에 대한 레이아웃을 개선한다.

```swift
struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
            .frame(width: 850, height: 700)
    }
}
```

**Step 4** <br>
공원과 상태를 유지하는 HStack을 선행 정렬의 VStack으로 변경하고 Spacer를 제거한다.

**Step 5** <br>
MapView 아래의 모든 것을 VStack에 묶은 후 CircleImage와 나머지 header를 HStack에 배치한다.

```swift
VStack(alignment: .leading, spacing: 20) {
    HStack(spacing: 24) {
        CircleImage(image: landmark.image)
            .offset(y: -130)
            .padding(.bottom, -130)

        VStack(alignment: .leading) {
            HStack {
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.primary)
                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
            }

            VStack(alignment: .leading) {
                Text(landmark.park)
                Text(landmark.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }

    Divider()

    Text("About \(landmark.name)")
        .font(.title2)
    Text(landmark.description)
}
.padding()
```

**Step 6** <br>
원에서 offset을 제거하고 대신 전체 VStack에 더 작은 offset을 적용한다.

```swift
VStack(alignment: .leading, spacing: 20) {
    HStack(spacing: 24) {
        CircleImage(image: landmark.image)

        VStack(alignment: .leading) {
            HStack {
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.primary)
                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
            }

            VStack(alignment: .leading) {
                Text(landmark.park)
                Text(landmark.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }

    Divider()

    Text("About \(landmark.name)")
        .font(.title2)
    Text(landmark.description)
}
.padding()
.offset(y: -50)
```

**Step 7** <br>
이미지에 resizable() modifier를 추가하고 CircleImage를 조금 더 작게 제한한다.

```swift
CircleImage(image: landmark.image.resizable())
    .frame(width: 160, height: 160)
```

**Step 8** <br>
ScrollView를 최대 너비로 제한한다.
이렇게 하면 사용자가 창을 매우 넓게 만들 때 가독성이 향상된다.

```swift
VStack(alignment: .leading, spacing: 20) {
    HStack(spacing: 24) {
        CircleImage(image: landmark.image.resizable())
            .frame(width: 160, height: 160)

        VStack(alignment: .leading) {
            HStack {
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.primary)
                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
            }

            VStack(alignment: .leading) {
                Text(landmark.park)
                Text(landmark.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }

    Divider()

    Text("About \(landmark.name)")
        .font(.title2)
    Text(landmark.description)
}
.padding()
.frame(maxWidth: 700)
.offset(y: -50)
```

**Step 9** <br>
PlainButtonStyle을 사용하도록 FavoriteButton을 변경한다.
여기서 일반 스타일을 사용하면 버튼이 iOS에 상응하는 것처럼 보인다.

```swift
VStack(alignment: .leading, spacing: 20) {
    HStack(spacing: 24) {
        CircleImage(image: landmark.image.resizable())
            .frame(width: 160, height: 160)

        VStack(alignment: .leading) {
            HStack {
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.primary)
                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                    .buttonStyle(PlainButtonStyle())
            }

            VStack(alignment: .leading) {
                Text(landmark.park)
                Text(landmark.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }

    Divider()

    Text("About \(landmark.name)")
        .font(.title2)
    Text(landmark.description)
}
.padding()
.frame(maxWidth: 700)
.offset(y: -50)
```

더 큰 화면은 추가 기능을 위한 더 많은 공간을 제공한다.

**Step 10** <br>
ZStack에 "Open in Maps" 버튼을 추가하여 오른쪽 상단에 지도가 표시되도록 한다.
지도에 보내는 MKMapItem을 만들 수 있도록 MapKit를 포함해야 한다.

```swift
ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
    MapView(coordinate: landmark.locationCoordinate)
        .ignoresSafeArea(edges: .top)
        .frame(height: 300)

    Button("Open in Maps") {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: landmark.locationCoordinate))
        destination.name = landmark.name
        destination.openInMaps()
    }
    .padding()
}
```

### Section 3
## Update the Row View

<p align="center">
    <img width="285" src="https://user-images.githubusercontent.com/60697742/132272428-602e29f6-7ea5-43ce-86a1-79c59bbed8af.png">
</p>

공유 LandmarkRow 뷰는 macOS에서 작동하지만 새로운 시각적 환경을 고려하여 개선사항을 찾기 위해 다시 방문할 가치가 있다.
이 뷰는 세 가지 플랫폼 모두에서 사용되기 때문에 변경한 내용이 모든 플랫폼에 적용되도록 주의해야 한다.

행을 수정하기 전에 목록 미리보기를 설정한다.
행이 전후 사정에서 어떻게 보이는지에 따라 변경사항이 적용되기 때문이다.

**Step 1** <br>
LandmarkList.swift를 열고 최소 너비를 추가한다.
이렇게 하면 미리보기가 향상되지만 사용자가 macOS 창의 크기를 조정할 때 목록이 너무 작아지지 않도록 한다.

```swift
var body: some View {
    NavigationView {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }

            ForEach(filteredLandmarks) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Landmarks")
        .frame(minWidth: 300)
    }
}
```

**Step 2** <br>
변경을 수행할 때 행이 전후 사정에서 어떻게 보이는지 볼 수 있도록 목록 뷰 미리보기를 고정한다.

**Step 3** <br>
LandmarkRow.swift를 열고 이미지에 모서리 반경을 추가하여 더 세련된 모양을 만든다.

```swift
var body: some View {
    HStack {
        landmark.image
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(5)
        Text(landmark.name)

        Spacer()

        if landmark.isFavorite {
            Image(systemName: "star.fill")
                .imageScale(.medium)
                .foregroundColor(.yellow)
        }
    }
}
```

**Step 4** <br>
landmark 이름을 VStack에 감사고 공원을 보조 정보로 추가한다.

```swift
var body: some View {
    HStack {
        landmark.image
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(5)
        VStack(alignment: .leading) {
            Text(landmark.name)
                .bold()
            Text(landmark.park)
                .font(.caption)
                .foregroundColor(.secondary)
        }

        Spacer()

        if landmark.isFavorite {
            Image(systemName: "star.fill")
                .imageScale(.medium)
                .foregroundColor(.yellow)
        }
    }
}
```

**Step 5** <br>
행의 내용 주위에 수직 padding을 추가하여 각 행에 약간의 호흡 공간을 제공한다.

```swift
var body: some View {
    HStack {
        landmark.image
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(5)
        VStack(alignment: .leading) {
            Text(landmark.name)
                .bold()
            Text(landmark.park)
                .font(.caption)
                .foregroundColor(.secondary)
        }

        Spacer()

        if landmark.isFavorite {
            Image(systemName: "star.fill")
                .imageScale(.medium)
                .foregroundColor(.yellow)
        }
    }
    .padding(.vertical, 4)
}
```

업데이트는 macOS의 모양을 개선하지만 목록을 사용하는 다른 플랫폼도 고려해야 한다.
먼저 watchOS를 고려한다.

**Step 6** <br>
WatchLandmarks 대상을 선택하여 목록의 watchOS 미리보기를 확인한다.
최소 행 너비는 여기에 적합하지 않다.
다음 section의 목록에는 이러한 변경사항이 있으므로, 가장 좋은 해결책은 너비 제약 조건을 생략하는 watch 전용 목록을 생성하는 것이다.

**Step 7** <br>
WatchLandmarks Extension만 대상으로 하는 LandmarkList.swift라는 WatchLandmarks Extension 폴더에 새 SwiftUI 뷰를 추가하고 이전 파일의 WatchLandmarks Extension 대상 멤버십을 제거한다.

**Step 8** <br>
이전 LandmarkList의 내용을 새 LandmarkList에 복사하되 프레임 modifier는 사용하지 않는다.
이제 콘텐츠의 너비가 적절하지만 각 행에 너무 많은 정보가 있다.

**Step 9** <br>
LandmarkRow로 돌아가서 watchOS 빌드에 보조 텍스트가 나타나지 않도록 #if 조건을 추가한다.
행의 경우 차이가 작기 때문에 조건부 컴파일을 사용하는 것이 적절하다.

```swift
#if !os(watchOS)
Text(landmark.park)
    .font(.caption)
    .foregroundColor(.secondary)
#endif
```

마지막으로 iOS에서 변경 사항이 작동하는 방식을 고려한다.

**Step 10** <br>
landmark 빌드 타겟을 선택하여 iOS에서 목록이 어떻게 보이는지 확인한다.
변경사항은 iOS에서 잘 작동하므로 해당 플랫폼을 업데이트할 필요가 없다.

### Section 4
## Update the List View

<p align="center">
    <img width="354" src="https://user-images.githubusercontent.com/60697742/132274168-e7057b5b-e15b-4909-8684-084c7b4cff1b.png">
</p>

LandmarkRow와 마찬가지로 LandmarkList는 이미 macOS에서 작동하지만 개선사항을 사용할 수 있다.
예를 들어, 즐겨찾기만 표시하는 토글을 도구 모음의 메뉴로 이동하면 추가 필터링 컨트롤로 결합할 수 있다.

변경사항은 macOS와 iOS 모두에서 작동하지만 watchOS에서는 적용하기 어려울 것이다.
다행히도 이전 section에서 이미 목록을 watchOS용 별도 파일로 분할했다.

**Step 1** <br>
MacLandmarks 체계로 돌아가서 iOS 및 macOS를 대상으로 하는 LandmarkList 파일에서 새 도구 모음 modifier 내부에 메뉴가 포함된 ToolbarItem을 추가한다.
앱을 실행할 때까지 도구 모음 업데이트를 볼 수 없다.

```swift
var body: some View {
    NavigationView {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }

            ForEach(filteredLandmarks) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Landmarks")
        .frame(minWidth: 300)
        .toolbar {
            ToolbarItem {
                Menu {

                } label: {
                    Label("Filter", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}
```

**Step 2** <br>
즐겨찾기 이동 메뉴로 전환한다.
이렇게 하면 플랫픔별 방식으로 토글이 도구 모음으로 이동하므로 landmark 목록이 얼마나 길어지거나 사용자가 스크롤하는 길이에 관계없이 접근할 수 있다는 추가 이점이 있다.

```swift
var body: some View {
    NavigationView {
        List {
            ForEach(filteredLandmarks) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Landmarks")
        .frame(minWidth: 300)
        .toolbar {
            ToolbarItem {
                Menu {
                    Toggle(isOn: $showFavoritesOnly) {
                        Label("Favorites only", systemImage: "star.fill")
                    }
                } label: {
                    Label("Filter", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}
```

더 많은 공간을 사용할 수 있게 되면 카테고리별로 landmark 목록을 필터링하기 위한 새로운 컨트롤을 추가할 수 있다.

**Step 3** <br>
FilterCategory 열거를 추가하여 필터 상태를 설명한다.
case 문자열을 Landmark 구조의 Category 열거와 일치시켜 비교할 수 있도록 하고 모든 case를 포함하여 필터링을 끈다.

```swift
enum FilterCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"

    var id: FilterCategory { self }
}
```

**Step 4** <br>
모든 경우를 기본값으로 하는 필터 상태 변수를 추가한다.
목록 뷰에 필터 상태를 저장하면 사용자가 각각 고유한 필터 설정이 있는 어려 목록 뷰 창을 열어 다양한 방식으로 데이터를 볼 수 있다.

```swift
@State private var filter = FilterCategory.all
```

**Step 5** <br>
지정된 landmark의 카테고리와 결합된 새 필터 설정을 고려하도록 FilteredLandmarks를 업데이트한다.

```swift
var filteredLandmarks: [Landmark] {
    modelData.landmarks.filter { landmark in
        (!showFavoritesOnly || landmark.isFavorite)
            && (filter == .all || filter.rawValue == landmark.category.rawValue)
    }
}
```

**Step 6** <br>
메뉴에 Picker를 추가하여 필터 범주를 설정한다.
필터에는 몇 가지 항목만 있으므로 InlinePickerStyle을 사용하여 항목을 모두 함께 표시한다.

```swift
var body: some View {
    NavigationView {
        List {
            ForEach(filteredLandmarks) { landmark in
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        }
        .navigationTitle("Landmarks")
        .frame(minWidth: 300)
        .toolbar {
            ToolbarItem {
                Menu {
                    Picker("Category", selection: $filter) {
                        ForEach(FilterCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(InlinePickerStyle())

                    Toggle(isOn: $showFavoritesOnly) {
                        Label("Favorites only", systemImage: "star.fill")
                    }
                } label: {
                    Label("Filter", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}
```

**Step 7** <br>
필터 상태와 일치하도록 네비게이션 제목을 업데이트한다.
이 변경사항은 iOS 앱에서 유용하다.

```swift
var title: String {
    let title = filter == .all ? "Landmarks" : filter.rawValue
    return showFavoritesOnly ? "Favorite \(title)" : title
}
```

**Step 8** <br>
넓은 레이아웃의 두 번째 뷰에 대한 placeholder로 NavigationView에 두 번째 자식 뷰를 추가한다.
두 번째 자식 뷰를 추가하면 자동으로 목록이 사이드 바 목록 스타일을 사용하도록 변환된다.

**Step 9** <br>
macOS 대상을 실행하고 메뉴가 어떻게 작동하는지 확인한다.

**Step 10** <br>
Landmarks 빌드 타겟을 선택하고 실시간 미리보기를 사용하여 새로운 필터링이 iOS에서도 잘 작동하는지 확인한다.
iOS는 이제 사이드 바 목록 스타일도 사용한다.

### Section 5
## Add a Built-in Menu Command

<p align="center">
    <img width="348" src="https://user-images.githubusercontent.com/60697742/132275644-8810f4bc-83b7-43b7-ba21-782784c2092c.png">
</p>

SwiftUI 수명 주기를 사용하여 앱을 만들 때 시스템은 가장 앞에 있는 창을 닫거나 앱을 종료하는 것과 같이 일반적으로 필요한 항목이 있는 메뉴를 자동으로 만든다.
SwiftUI를 사용하면 동작이 내장된 다른 일반적인 명령과 완전히 사용자 정의된 명령을 추가할 수 있다.

이 section에서는 사용자가 사이드바를 토글하여 닫은 후 다시 가져올 수 있도록 하는 시스템 제공 명령을 추가한다.

**Step 1** <br>
MacLandmarks 대상으로 돌아가서 macOS 앱을 실행하고 목락과 상세 뷰 사이의 구분 기호를 왼쪽 끝까지 끌어간다.
마우스 버튼에서 손을 떼면 목록을 다시 가져올 방법 없이 목록이 사라진다.
이 문제를 해결하기 위해 명령을 추가한다.

**Step 2** <br>
LandmarkCommands.swift라는 새 Swift 파일을 추가하고 macOS와 iOS를 모두 포함하도록 대상을 설정한다.
공유 LandmarkList는 결국 이 파일에서 정의한 일부 유형에 의존하기 때문에 iOS도 대상으로 한다.

**Step 3** <br>
SwiftUI를 import하고 계산된 본문 속성과 함께 Commands 프로토콜을 준수하는 LandmarkCommands 구조를 추가한다.
뷰 구조와 마찬가지로 Commands 구조에는 뷰 대신 명령을 사용하는 경우를 제외하고 빌더 의미 체계를 사용하는 계산된 본문 속성이 필요하다.

```swift
import SwiftUI

struct LandmarkCommands: Commands {
    var body: some Commands {
    }
}
```

**Step 4** <br>
본문에 SidebarCommands 명령을 추가한다.
이 기본 제공 명령 세트에는 사이드바를 전환하는 명령이 포함되어 있다.

```swift
struct LandmarkCommands: Commands {
    var body: some Commands {
        SidebarCommands()
    }
}
```

앱에서 명령을 사용하려면 장면에 명령을 적용해야 한다.
이 작업은 다음에 수행할 것이다.

**Step 5** <br>
LandmarksApp,swift 파일을 열고 commands(content:) 장면 modifier를 사용하여 LandmarkCommands를 적용한다.
장면 modifier는 뷰 대신 장면에 적용한다는 점을 제외하면 뷰 modifier와 같이 작동한다.

```swift
var body: some Scene {
    WindowGroup {
        ContentView()
            .environmentObject(modelData)
    }
    .commands {
        LandmarkCommands()
    }

    #if os(watchOS)
    WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
    #endif
}
```

**Step 6** <br>
macOS 앱을 다시 실행하고 View > Toggle Sidebar menu 명령을 사용하여 목록 뷰를 복원할 수 있는지 확인한다.

뷸행히도, 명령에 watchOS 가용성이 없기 때문에 watchOS 앱 빌드에 실패한다.
다음에 이것을 고칠 것이다.

**Step 7** <br>
기본 창 그룹을 추출하고 명령에 조건부 컴파일을 적용한다.
watchOS 앱이 다시 빌드된다.

```swift
var body: some Scene {
    let mainWindow = WindowGroup {
        ContentView()
            .environmentObject(modelData)
    }

    #if os(macOS)
    mainWindow
        .commands {
            LandmarkCommands()
        }
    #else
    mainWindow
    #endif

    #if os(watchOS)
    WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
    #endif
}
```

### Section 6
## Add a Custom Menu Command

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

**Step 8** <br>

**Step 9** <br>

### Section 7
## Add Preferences with a Settings Scene

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>

**Step 8** <br>

**Step 9** <br>