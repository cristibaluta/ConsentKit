# ConsentKit
Swift library to help you add GDPR functionality to your app

## Usage
### Define the services that needs the user consent

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
          func alertDescription() -> String {
              switch self {
                  case .icloud: return "I hereby accept this app to store my data in the Apple's iCloud!"
                  case .analytics: return "I hereby accept this app to store analytics in Google analytics!"
              }
          }
          static var allValues: [ConsentKitItem] = [Services.icloud, Services.analytics]
	}
	
### In the flow of your app where you need consent instantiate the lib

	let gdpr = ConsentKit()
	
### Check if you have missing consents
If yes, add the default ConsentKitViewController to handle all the switches for you.  If not customisable for your needs drop pe an issue.

    if gdpr.needsReviewing(Services.allValues) {
        
        let gdprView = ConsentKitViewController()
        gdprView.items = Services.allValues
        gdprView.defaultValues = [gdpr.isAccepted(Services.icloud), gdpr.isAccepted(Services.analytics)]
        self.present(gdprView, animated: true)
    }
