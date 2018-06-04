# ConsentKit
Note: This library only helps you collect consents for the services in your app, actually disabling those services is developer's job.

![Screenshot](https://image.ibb.co/iuASQy/Screen_Shot_2018_05_28_at_23_07_10.png)

## Usage
### Define the services in your app
Note: Some generic services can be found in ConsentKitServices

```swift
enum Services: String, ConsentKitItem {

        case icloud = "iCloud"
        case analytics = "analytics"

        func title() -> String {
            switch self {
                case .icloud: return "iCloud"
                case .analytics: return "Google analytics"
            }
        }
        func description() -> String {
            switch self {
                case .icloud: return "Wether to accept iCloud or not"
                case .analytics: return "Google analytics"
            }
        }
        func alertMessage() -> String? {
            switch self {
                case .icloud: return nil
                case .analytics: return "I accept this app to store anonymous analytics in Google Analytics!"
            }
        }
}
```

### Instantiate the lib, preferably once in the AppDelegate, but can be anywhere and as many times as you like.

```swift
let gdpr = ConsentKit()
```

### Check if you have missing consents
If yes, add the default ConsentKitViewController to handle all the switches for you.

```swift
if gdpr.needsReviewing([Services.icloud, Services.analytics]) {

    let vc = ConsentKitViewController()
    vc.items = [Services.icloud, Services.analytics, ConsentKitServices.location]
    self.present(vc, animated: true)
}
```

### Custom storage
By default ConsentKit keeps values in UserDefaults, but you can change that with the gdpr.dataSource property. Just assign or pass through constructor a class implementing the ConsentKitDataSource

```swift
let gdpr = ConsentKit(dataSource: InMemoryDataSource())// InMemoryDataSource implements ConsentKitDataSource

protocol ConsentKitDataSource {
    func isAccepted (_ item: ConsentKitItem) -> Bool
    func isReviewed (_ item: ConsentKitItem) -> Bool
    func setAccepted (_ value: Bool, for item: ConsentKitItem)
    func reset (_ item: ConsentKitItem)// Optional
}
```

## Contribution
Help me create a complete list of services that the developers can use.
Thanks.
