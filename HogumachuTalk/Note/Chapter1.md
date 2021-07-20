# Chapter 1

### `FriendTableViewCell.swift`
* Profile의 Image 그리고 name 의 크기 및 위치 조정.

### `MyProfileTableViewCell.swift`
* Profile의 Image 그리고 name 의 크기 및 위치 조정, `FriendTableViewCell` 보다 큰 사이즈를 갖게 하자.

### `Model.swift`
* Model 에서는 데이터만 갖게 하자. 현재는 Model 에 있는 데이터를 View 의 item 으로 가공하여 VC 에게 보내고 있는데, ViewModel을 따로 생성하여 View 로 가공하는 일을 시키자. 또 `Model.swift` 가 아닌 `~~~Model.swift` 이런 식으로 변경하자. (폴더도 만들어 따로 관리하면 좋을 듯.

### `MyProfileViewController.swift`
* 나와의 채팅, 프로필 편집 등 기능을 추가하자. 프로필 편집 기능은 Profile Image 를 변경하거나, 상태 메시지 변경으로 하자. Profile 은 사진을 불러와서 설정하고 상태 메시지는 클릭했을 때 TextFiled 가 나오는 화면을 추가하여 값을 받고 변경 가능하게 하자.

### `InstagramViewController.swift`
* WebKitView 하단에 있는 버튼을 좀 더 가시성 있게 바꾸자. 사이즈가 너무 작음.

### `ViewController.swift`
* 제일 처음 나오는 VC 인데 이름을 변경해야 할 듯. `~~~ViewController.swift` 로 변경하자.

### ETC
* 나중에 봐도 쉽게 파악하기 위해 계층 구조나 파일명, 함수명 등 직관적인 이름을 선택하자.

* Anchor 로 Constraint 주는 것에 익숙해지면 Snapkit 같은 오픈소스를 활용하여 리팩토링하자.

<img src = "https://user-images.githubusercontent.com/74225754/126287808-15eeaed6-927c-446f-82ce-9fde1a775ce2.png" width="30%" height="30%"> <img src = "https://user-images.githubusercontent.com/74225754/126287818-6c4f3a60-21c7-4c71-9718-a043eebea769.png" width="30%" height="30%"> <img src = "https://user-images.githubusercontent.com/74225754/126287840-a318b418-bcfa-4553-8a8b-eb321664a971.png" width="30%" height="30%">

#### < `ViewController.swift` , `MyProfileViewController.swift`, `InstagramViewController.swift` >
