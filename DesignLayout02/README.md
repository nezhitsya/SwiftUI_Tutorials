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

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

### Section 3
## Define the Profile Editor

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

### Section 4
## Delay Edit Propagation

**Step 1** <br>

**Step 2** <br>