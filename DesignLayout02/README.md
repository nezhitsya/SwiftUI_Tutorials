## App Design and Layout
# Working with UI Controls

Landmarks 앱에서 사용자는 프로필을 만들어 개성을 표현할 수 있다.
사용자에게 프로필을 변경할 수 있는 기능을 제공하기 위해 편집 모드를 추가하고 기본 설정 화면을 디자인한다.

데이터 입력을 위한 다양한 사용자 인터페이스 컨트롤로 작업하고 사용자가 변경 사항을 저장할 때마다 Landmarks 모델 유형을 업데이트한다.

### Section 1
## Display a User Profile

<p align="center">
    <img width="377" src="https://user-images.githubusercontent.com/60697742/131444522-36329411-fe36-4a66-b053-08b0c825390e.png">
</p>

Landmarks 앱은 일부 구성 세부 정보와 기본 설정을 로컬에 저장한다.
사용자가 세부 정보를 편집하기 전에 편집 컨트롤이 없는 요약 뷰에 표시된다.

**Step 1** <br>
프로젝트의 Model 그룹에 추가하는 Profile.swift라는 새 Swift 파일에 사용자 프로필을 정의하는 것부터 시작한다.

```swift
struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "g_kumar")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { self.rawValue }
    }
}
```

**Step 2** <br>
다음으로, Views 그룹 아래에 Profiles라는 새 그룹을 만든 후 저장된 프로필의 사용자 이름을 표시하는 텍스트 뷰가 있는 그룹에 ProfileHost라는 뷰를 추가한다.
ProfileHost 뷰는 프로필 정보의 정적 요약 뷰와 편집 모드를 모두 다룬다.

```swift
struct ProfileHost: View {
    @State private var draftProfile = Profile.default

    var body: some View {
        Text("Profile for: \(draftProfile.username)")
    }
}
```

**Step 3** <br>
Profile 인스턴스를 사용하고 몇 가지 기본 사용자 정보를 표시하는 ProfileSummary라는 Profiles 그룹에 다른 뷰를 생성한다.
상위 뷰인 ProfileHost가 이 뷰의 상태를 관리하기 때문에 ProfileSummary는 Profile에 대한 바인딩 대신 Profile 값을 사용한다.

```swift
struct ProfileSummary: View {
    var profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
```

**Step 4** <br>
새 요약 뷰를 표시하기 위해 ProfileHost를 업데이트한다.

```swift
struct ProfileHost: View {
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary(profile: draftProfile)
        }
        .padding()
    }
}
```

**Step 5** <br>
하이킹에 대한 설명 텍스트와 함께 Drawing Paths and Shapes의 Badge를 구성하는 Hikes 폴더에 HikeBadge라는 새로운 뷰를 생성한다.
배지는 그래픽일 뿐이므로 HikeBadge의 텍스트와 accessibilityLabel(_:) modifier는 다른 사용자에게 배지의 의미를 더 명확하게 한다.

```swift
struct HikeBadge: View {
    var name: String

    var body: some View {
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
```

배지의 그리기 로직은 배지가 렌더링되는 프레임의 크기에 따라 달라지는 결과를 생성한다.
원하는 모양을 보장하려면 300 x 300 포인트의 프레임으로 렌더링한다.
최종 그래픽에 대해 원하는 크기를 얻으려면 렌더링 된 결과의 크기를 조정하고 비교적 작은 프레임에 배치한다.

**Step 6** <br>
다양한 색조와 배지 획득 이유가 있는 여러 배지를 추가하려면 ProfileSummary를 업데이트한다.

```swift
var body: some View {
    ScrollView {
        VStack(alignment: .leading, spacing: 10) {
            Text(profile.username)
                .bold()
                .font(.title)

            Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
            Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
            Text("Goal Date: ") + Text(profile.goalDate, style: .date)

            Divider()

            VStack(alignment: .leading) {
                Text("Completed Badges")
                    .font(.headline)

                ScrollView(.horizontal) {
                    HStack {
                        HikeBadge(name: "First Hike")
                        HikeBadge(name: "Earth Day")
                            .hueRotation(Angle(degrees: 90))
                        HikeBadge(name: "Tenth Hike")
                            .grayscale(0.5)
                            .hueRotation(Angle(degrees: 45))
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}
```

**Step 7** <br>
Animating Views and Transitions의 HikeView를 표함하여 프로필 요약을 마무리한다.
하이킹 데이터를 사용하려면 모델 데이터 환경 개체도 추가해야 한다.

```swift
struct ProfileSummary: View {
    @EnvironmentObject var modelData: ModelData
    var profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)

                Divider()

                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)

                    ScrollView(.horizontal) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 90))
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }

                Divider()

                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)

                    HikeView(hike: modelData.hikes[0])
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
    }
}
```

**Step 8** <br>
CategoryHome.swift에서 toolbar modifier를 사용하여 네비게이션 바에 사용자 프로필 버튼을 추가하고 사용자가 누르면 ProfileHost 뷰를 표시한다.
네비게이션 바에 버튼을 추가하면 삽입물이 반환된다.
다음 단계에서 수정한다.

```swift
struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false

    var body: some View {
        NavigationView {
            List {
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Featured")
            .toolbar {
                Button(action: { showingProfile.toggle() }) {
                    Image(systemName: "person.crop.circle")
                        .accessibilityLabel("User Profile")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}
```

**Step 9** <br>
listStyle modifier를 추가하고 InsetListStyle을 적용하여 삽입물을 제거한다.

```swift
var body: some View {
    NavigationView {
        List {
            modelData.features[0].image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())

            ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                CategoryRow(categoryName: key, items: modelData.categories[key]!)
            }
            .listRowInsets(EdgeInsets())
        }
        .listStyle(InsetListStyle())
        .navigationTitle("Featured")
        .toolbar {
            Button(action: { showingProfile.toggle() }) {
                Image(systemName: "person.crop.circle")
                    .accessibilityLabel("User Profile")
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
                .environmentObject(modelData)
        }
    }
}
```

**Step 10** <br>
실시간 미리보기로 전환하고 프로필 버튼을 눌러 프로필 요약을 살펴본다.

### Section 2
## Add an Edit Mode

사용자는 프로필 세부 정보를 보거나 편집해야 한다.
기존 ProfileHost에 EditButton을 추가한 다음 개별 값을 편집하기 위한 컨트롤이 있는 뷰를 만들어 편집 모드를 추가한다.

**Step 1** <br>
ProfileHost를 선택하고 모델 데이터를 환경 개체로 미리보기에 추가한다.
이 뷰는 @EnvironmentObject 특성을 가진 속성을 사용하지 않지만 이 뷰의 자식인 ProfileSummary는 사용한다.
따라서 modifier가 없으면 미리보기가 실패한다.

```swift
struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}
```

**Step 2** <br>
환경의 \.editMode에서 벗어나는 Environment 뷰 속성을 추가한다.
SwiftUI는 @Environment 속성을 사용하여 접근할 수 있는 값에 대한 저장소를 환경에 제공한다.
editMode 값에 접근하여 편집 범위를 읽거나 작성한다.

```swift
struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary(profile: draftProfile)
        }
        .padding()
    }
}
```

**Step 3** <br>
환경의 editMode 값을 켜고 끄는 Edit 버튼을 생성한다.
EditButton은 이전 단계에서 접근한 것과 동일한 editMode 환경 값을 제어한다.

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 20) {
        HStack {
            Spacer()
            EditButton()
        }

        ProfileSummary(profile: draftProfile)
    }
    .padding()
}
```

**Step 4** <br>
사용자가 프로필 뷰를 닫은 후에도 지속되는 사용자 프로필의 인스턴스를 포함하도록 ModelData 클래스를 업데이트한다.

```swift
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default

    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}
```

**Step 5** <br>
환경에서 사용자의 프로필 데이터를 읽어 데이터 제어권을 프로필 호스트로 넘긴다.
사용자가 이름을 입력하는 것과 같이 편집 내용을 확인하기 전에 전역 앱 상태를 업데이트하지 않도록 편집 뷰 자체 복사본에서 작동한다.

```swift
struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton()
            }

            ProfileSummary(profile: modelData.profile)
        }
        .padding()
    }
}
```

**Step 6** <br>
정적 프로필 또는 편집 모드 용 뷰를 표시하는 조건부 뷰를 추가한다.
실시간 미리보기를 실행하고 편집 버튼을 누르면 편집 모드로 진입하는 효과를 확인할 수 있다.
현재 편집 모드 뷰는 정적 텍스트 필드이다.

```swift
struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton()
            }

            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                Text("Profile Editor")
            }
        }
        .padding()
    }
}
```

### Section 3
## Define the Profile Editor

<p align="center">
    <img width="348" src="https://user-images.githubusercontent.com/60697742/131448160-90e8e57f-b809-4dff-a9f3-300fae9662c0.png">
</p>

사용자 프로필 편집기는 주로 프로필의 개별 세부 정보를 변경하는 다양한 컨트롤로 구성된다.
배지와 같은 프로필의 일부 항목은 사용자가 편집할 수 없으므로 편집기에 표시되지 않는다.

프로필 요약의 일관성을 위해 편집기에서 프로필 세부 정보를 동일한 순서로 추가한다.

**Step 1** <br>
ProfileEditor라는 새 뷰를 만들고 사용자의 프로필의 초안 사본에 대한 바인딩을 포함한다.
뷰의 첫 번째 컨트롤은 문자열 바인딩(이 경우, 사용자가 선택한 표시 이름)을 제어하고 업데이트하는 TextField이다.
텍스트 필드를 생성할 때 문자열에 대한 레비을과 바인딩을 제공한다.

```swift
struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
```

**Step 2** <br>
프로필 편집기를 포함하고 프로필 바인딩을 전달하도록 ProfileHost의 조건부 컨텐츠를 업데이트한다.
이제 Edit을 누르면 프로필 편집 뷰가 표시된다.

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 20) {
        HStack {
            Spacer()
            EditButton()
        }

        if editMode?.wrappedValue == .inactive {
            ProfileSummary(profile: modelData.profile)
        } else {
            ProfileEditor(profile: $draftProfile)
        }
    }
    .padding()
}
```

**Step 3** <br>
landmark 관련 이벤트에 대한 알림 수신에 대한 사용자의 기본 설정에 해당하는 토글을 추가한다.
토글은 켜거나 끌 수 있는 컨트롤이므로 예 또는 아니오 기본 설정과 같은 Boolean 값에 적합하다.

```swift
var body: some View {
    List {
        HStack {
            Text("Username").bold()
            Divider()
            TextField("Username", text: $profile.username)
        }
            
        Toggle(isOn: $profile.prefersNotifications) {
            Text("Enable Notifications").bold()
        }
    }
}
```

**Step 4** <br>
Picker 컨트롤과 레이블을 VStack에 배치하여 landmark 사진에 선호하는 계절을 선택할 수 있도록 한다.

```swift
VStack(alignment: .leading, spacing: 20) {
    Text("Seasonal Photo").bold()
                
    Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
        ForEach(Profile.Season.allCases) { season in
            Text(season.rawValue).tag(season)
        }
    }
    .pickerStyle(SegmentedPickerStyle())
}
```

**Step 5** <br>
마지막으로, 시즌 선택기 아래 DatePicker를 추가하여 landmark 방문 목표 날짜를 수정할 수 있도록 한다.

```swift
struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications").bold()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Seasonal Photo").bold()
                
                Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                    ForEach(Profile.Season.allCases) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date").bold()
            }
        }
    }
}
```

### Section 4
## Delay Edit Propagation

사용자가 편집 모드를 종료할 때까지 편집 내용이 적용되지 않도록 하려면 편집하는 동안 프로필의 초안 사본을 사용한 다음 사용자가 편집을 확인한 경우에만 초안 사본을 실제 사본에 할당한다.

**Step 1** <br>
ProfileHost에 취소 버튼을 추가한다.
EditButton이 제공하는 Done 버튼과 달리 Cancel 버튼은 종료 시 실제 프로필 데이터에 편집 내용을 적용하지 않는다.

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 20) {
        HStack {
            if editMode?.wrappedValue == .active {
                Button("Cancel") {
                    draftProfile = modelData.profile
                    editMode?.animation().wrappedValue = .inactive
                }
            }
            Spacer()
            EditButton()
        }

        if editMode?.wrappedValue == .inactive {
            ProfileSummary(profile: modelData.profile)
        } else {
            ProfileEditor(profile: $draftProfile)
        }
    }
    .padding()
}
```

**Step 2** <br>
onAppear(perform:) 및 onDisappear(perfomr:) modifier를 적용하여 편집기를 올바른 프로필 데이터로 채우고 사용자가 Done 버튼을 누를 때 영구 프로필을 업데이트한다.
그렇지 않으면 다음에 편집 모드가 활성화될 때 이전 값이 나타난다.

```swift
var body: some View {
    VStack(alignment: .leading, spacing: 20) {
        HStack {
            if editMode?.wrappedValue == .active {
                Button("Cancel") {
                    draftProfile = modelData.profile
                    editMode?.animation().wrappedValue = .inactive
                }
            }
            Spacer()
            EditButton()
        }

        if editMode?.wrappedValue == .inactive {
            ProfileSummary(profile: modelData.profile)
        } else {
            ProfileEditor(profile: $draftProfile)
                .onAppear {
                    draftProfile = modelData.profile
                }
                .onDisappear {
                    modelData.profile = draftProfile
                }
        }
    }
    .padding()
}
```