## App Design and Layout
# Composing Complex Interfaces

landmark의 카테고리 뷰는 수평으로 스크롤되는 landmark의 수직 스크롤 목록을 보여준다.
이 뷰를 빌드하고 기존 뷰에 연결하면 구성된 뷰가 다양한 장치의 크기 및 방향에 적응할 수 있는 방법을 탐색할 수 있다.

### Section 1
## Add a Category View

<p align="center">
    <img width="394" src="https://user-images.githubusercontent.com/60697742/131077506-0290fe95-3936-4ca7-952d-1d4c66c936bb.png">
</p>

카테고리 별 landmark를 정렬하는 뷰를 만들고 뷰 상단에서 주요 landmark를 강조 표시하여 landmark를 탐색하는 다른 방법을 제공할 수 있다.

**Step 1** <br>
프로젝트이 Views 그룹에 Categories 그룹을 만들고 새 그룹에 CategoryHome이라는 사용자 설정 뷰를 생성한다.

**Step 2** <br>
다양한 카테고리를 가져올 NavigationView를 추가한다.
네비게이션 뷰를 NavigationLink 인스턴스 및 관련 modifier와 함께 사용하여 앱에서 계층적 탐색 구조를 구축한다.

```swift
struct CategoryHome: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
    }
}
```

**Step 3** <br>
네비게이션 바의 제목을 Featured로 설정한다.
뷰는 상단에 하나 이상의 주요 landmark를 보여준다.

```swift
var body: some View {
    NavigationView {
        Text("Hello, World!")
            .navigationTitle("Featured")
    }
}
```

### Section 2
## Create a Category List

카테고리 뷰는 모든 카테고리를 세로 열에 배열하여 쉽게 검색할 수 있도록 별도의 행으로 표시한다.
수직 및 수평 스택을 결합하고 목록에 스크롤을 추가하여 이를 수행한다.

먼저 LandmarkData.json 파일에서 카테고리 데이터를 읽는다.

**Step 1** <br>
Landmark.swift에서 Landmark 구조에 Category 열거와 category 속성을 추가한다.
LandmarkData.json 파일에는 이미 세 가지 문자열 값 중 하나를 사용하여 각 landmark에 대한 카테고리 값이 포함되어 있다.
데이터 파일의 이름을 일치시키면 구조의 Codable 적합성에 의존하여 데이터를 로드할 수 있다.

```swift
var category: Category
enum Category: String, CaseIterable, Codable {
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"
}
```

**Step 2** <br>
ModelData.swift에서 카테고리 이름을 키로 사용하여 계산된 카테고리 사전을 추가하고 각 키에 연결된 landmark 배열을 추가한다.

```swift
var categories: [String: [Landmark]] {
    Dictionary(
        grouping: landmarks,
        by: { $0.category.rawValue }
    )
}
```

**Step 3** <br>
CategoryHome.swift에서 modelData 환경 객체를 생성한다.
지금은 카테고리에 접근해야하며 나중에는 다른 landmark 데이터에도 접근해야 한다.

```swift
struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView {
            Text("Landmarks Content")
                .navigationTitle("Featured")
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
```

**Step 4** <br>
List를 사용하여 landmark의 카테고리를 표시한다.
Landmark.Category 케이스 이름은 목록의 각 항목을 식별하며, 이는 열거형이기 때문에 다른 카테고리 간에 고유해야 한다.

```swift
var body: some View {
    NavigationView {
        List {
            ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                Text(key)
            }
        }
        .navigationTitle("Featured")
    }
}
```

### Section 3
## Create a Category Row

<p align="center">
    <img width="394" src="https://user-images.githubusercontent.com/60697742/131079106-1304f7f6-35a4-4927-98c8-d49804c066bc.png">
</p>

landmark는 가로로 스크롤되는 행에 각 카테고리를 표시한다.
행을 나타내는 새 뷰 유형을 추가한 다음 새 뷰에서 해당 카테고리에 대한 모든 Landmark를 표시한다.

Creating and Combining Views에서 생성한 landmark 뷰의 일부를 재사용하여 landmark의 친숙한 미리보기를 생성한다.

**Step 1** <br>
행의 내용을 보관하기 위한 새 사용자 정의 뷰 CategoryRow를 정의한다.

**Step 2** <br>
카테고리 이름 및 해당 카테고리의 항목 목록에 대한 속성을 추가한다.

```swift
struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]

    var body: some View {
        Text("Hello, World!")
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks

    static var previews: some View {
        CategoryRow(
            categoryName: landmarks[0].category.rawValue,
            items: Array(landmarks.prefix(3))
        )
    }
}
```

**Step 3** <br>
카테고리 이름을 표시한다.

```swift
var body: some View {
    Text(categoryName)
        .font(.headline)
}
```

**Step 4** <br>
카테고리 항목을 HStack에 넣고 카테고리 이름을 가진 항목을 VStack에 그룹화한다.

```swift
var body: some View {
    VStack(alignment: .leading) {
        Text(categoryName)
            .font(.headline)

        HStack(alignment: .top, spacing: 0) {
            ForEach(items) { landmark in
                Text(landmark.name)
            }
        }
    }
}
```

**Step 5** <br>
높이 frame(width:height:)를 지정하고 padding을 추가하고 스크롤 뷰로 HStack을 감싸 콘텐츠에 공간을 제공한다.
더 큰 데이터 샘플링으로 뷰 미리보기를 업데이트하면 스크롤 동작이 올바른지 더 쉽게 확인할 수 있다.

```swift
var body: some View {
    VStack(alignment: .leading) {
        Text(categoryName)
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(items) { landmark in
                    Text(landmark.name)
                }
            }
        }
        .frame(height: 185)
    }
}
```

**Step 6** <br>
하나의 landmark를 표시하는 CategoryItem이라는 새 설정 뷰를 생성한다.

```swift
struct CategoryItem: View {
    var landmark: Landmark

    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: ModelData().landmarks[0])
    }
}
```

**Step 7** <br>
CategoryRow.swift에서 landmark의 이름을 담고 있는 Text를 새로운 CategoryItem 뷰로 교체한다.

```swift
var body: some View {
    VStack(alignment: .leading) {
        Text(categoryName)
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(items) { landmark in
                    CategoryItem(landmark: landmark)
                }
            }
        }
        .frame(height: 185)
    }
}
```

### Section 4
## Complete the Category View

카테고리 홈 페이지에 행과 추천 이미지를 추가한다.

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

### Section 5
## Add Navigation Between Sections

**Step 1** <br>

**Step 2** <br>

**Step 3** <br>

**Step 4** <br>

**Step 5** <br>

**Step 6** <br>

**Step 7** <br>