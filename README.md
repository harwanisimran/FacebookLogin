# Integrate Facebook iOS Application
1. Create a new project in which you want to integrate facebook.
 
2. Install pods as mentioned follows
* pod 'FacebookCore'            
* pod 'FacebookLogin'
* pod 'FBSDKLoginKit'
 
3. Now go to link mentioned below  

       https://developers.facebook.com/docs/facebook-login/ios
 
4. Login to your facebook account and click on create a new app.
 
5. Now fill your app display name and contact mail and click on create app id.
 
6. Fill your bundle id in the text field given on the web page and click on save button.
 
7. Now switch on the sign on button given under Enable Single Sign On.
 
8. Now open info.plist and copy code given for configuration on the link after saving your Bundle ID as mentioned below.
 
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb20***************</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>1***************</string>
<key>FacebookDisplayName</key>
<string>DemoAppLogin</string>
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>

9. Add the following to your AppDelegate class. This initializes the SDK when your app launches, and lets the SDK handle results from the native Facebook app when you perform a Login or Share action.

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
       return true
       }

       func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool        {
         return SDKApplicationDelegate.shared.application(app, open: url, options: options)
       }


## Login Button

To add a Facebook login button to your app add the following code snippet to a view controller.

     let fbLoginButton = FBSDKLoginButton()
     fbLoginButton.readPermissions = ["public_profile","email"]
     fbLoginButton.center = self.view.center
     self.view.addSubview(fbLoginButton)

For performing log in and log out action implement loginButton and loginButtonDidLogOut methods of FBSDKLoginButtonDelegate protocol. 
For this add following line in viewDidLoad method,
    
     fbLoginButton.delegate = self

Now write the code that will fetch user profile.

    func fetchProfile() {
    
        let request = GraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,last_name, email, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        
        request.start({ (response, requestResult) in
            switch requestResult{
            case .success(let response):
                print(response.dictionaryValue!)
                print(response.dictionaryValue!["first_name"]!)
            case .failed(let error):
                print(error.localizedDescription)
            }
        })
    }

Now you have done all the required things for fetching the user credential in App
