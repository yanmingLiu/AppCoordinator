#  AppCoordinator

iOS协调器模式，负责从视图控制器导航到单独的类。从视图控制器中删除应用导航工作，帮助它们更易于管理和重用，同时还允许我们在需要时调整应用的流程。


```
├── Application
│   ├── AppDelegate.swift
│   ├── Container
│   │   ├── AppDICoordinator.swift
│   │   ├── AppFactory.swift
│   │   ├── AppFlowCoordinator.swift
│   │   ├── Coordinator.swift
│   │   ├── Navigation.swift
│   │   └── ParentCoordinator.swift
│   └── SceneDelegate.swift
├── Common
│   └── Cancellable.swift
├── Data
├── Domain
│   ├── Entities
│   │   └── Model.swift
│   ├── Interfaces
│   └── UseCases
│       ├── LogInUserCase.swift
│       ├── LogOutUserCase.swift
│       └── Protocol
│           └── UseCase.swift
├── Infrastructure
│   ├── Auth.swift
│   └── Network
├── Presentation
│   ├── .DS_Store
│   ├── Behaviors
│   │   └── NavigationBarLargeTitleBehaviors.swift
│   ├── Screnes
│   │   ├── Home
│   │   │   ├── Composition
│   │   │   │   ├── HomeCoordinator.swift
│   │   │   │   └── HomeFactory.swift
│   │   │   ├── View
│   │   │   │   └── HomeViewController.swift
│   │   │   └── ViewModel
│   │   │       └── HomeViewModel.swift
│   │   ├── LogIn
│   │   │   ├── Composition
│   │   │   │   ├── LogInCoordinator.swift
│   │   │   │   └── LogInFactory.swift
│   │   │   ├── View
│   │   │   │   └── LogInViewContoller.swift
│   │   │   └── ViewModel
│   │   │       └── LogInViewModel.swift
│   │   ├── MainTabBar
│   │   │   ├── Composition
│   │   │   │   ├── MainTabBarCoordinator.swift
│   │   │   │   └── MainTabBarFactory.swift
│   │   │   └── View
│   │   │       └── MainTabBarController.swift
│   │   ├── MyPosts
│   │   │   ├── Composition
│   │   │   │   ├── MyPostsCoordinator.swift
│   │   │   │   └── MyPostsFactory.swift
│   │   │   ├── View
│   │   │   │   ├── MyPostsViewController.swift
│   │   │   │   └── PostItemCell.swift
│   │   │   └── ViewModel
│   │   │       ├── MyPostsViewModel.swift
│   │   │       └── PostItemViewModel.swift
│   │   ├── NewPost
│   │   │   ├── Composition
│   │   │   ├── View
│   │   │   │   └── NewPostViewController.swift
│   │   │   └── ViewModel
│   │   │       └── NewPostViewModel.swift
│   │   ├── PostDetail
│   │   │   ├── Conmposition
│   │   │   │   ├── PostDetailCoordinator.swift
│   │   │   │   └── PostDetailFactory.swift
│   │   │   ├── View
│   │   │   │   └── PostDetailViewController.swift
│   │   │   └── ViewModel
│   │   ├── Profile
│   │   │   ├── Composition
│   │   │   │   ├── ProfileCoordinator.swift
│   │   │   │   └── ProfileFactory.swift
│   │   │   ├── View
│   │   │   │   └── ProfileViewController.swift
│   │   │   └── ViewModel
│   │   │       └── ProfileViewModel.swift
│   │   └── Settings
│   │       ├── Settings
│   │       │   ├── Composition
│   │       │   │   ├── SettingsCoordinator.swift
│   │       │   │   └── SettingsFactory.swift
│   │       │   ├── View
│   │       │   │   ├── SettingsCell.swift
│   │       │   │   └── SettingsViewController.swift
│   │       │   └── ViewModel
│   │       │       ├── SettingsItemViewModel.swift
│   │       │       └── SettingsViewModel.swift
│   │       └── UserConfiguration
│   │           ├── Composition
│   │           │   ├── UserConfigurationCoordinator.swift
│   │           │   └── UserConfigurationFactory.swift
│   │           ├── View
│   │           │   └── UserConfigurationController.swift
│   │           └── ViewModel
│   │               └── UserConfigurationViewModel.swift
│   └── Utils
│       ├── Extensions
│       │   ├── UIViewController+AddBehaviors.swift
│       │   └── UIViewController+AddChild.swift
│       └── Observable.swift
└── Resources
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   └── Contents.json
    │   ├── Contents.json
    │   └── HongKong.imageset
    │       ├── Contents.json
    │       └── HongKong.jpeg
    ├── Base.lproj
    │   └── LaunchScreen.storyboard
    └── Info.plist

```
