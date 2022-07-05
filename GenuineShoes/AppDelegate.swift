//
//  AppDelegate.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/27.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

    //
    //    func application(_ app: UIApplication,
    //                     open url: URL,
    //                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
    //        return GIDSignIn.sharedInstance().handle( url )
    //    }
    //
    
    
    
    //    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    //        if let error = error {
    //            print("ERROR Google Sign In \(error.localizedDescription)")
    //            return
    //        }
    //
    //        guard let authentication = user.authentication else { return }
    //        let credential = GoogleAuthProvider.credential(
    //            withIDToken: authentication.idToken,
    //            accessToken: authentication.accessToken
    //        )
    //
    //        Auth.auth().signIn(with: credential) { authResult, error in
    //
    //
    //        }
    //
    //
    //    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UITabBar.appearance().tintColor = .label
        UINavigationBar.appearance().tintColor = .label
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        //GIDSignIn.sharedInstance().delegate = self

        
        
        return true
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handle = GIDSignIn.sharedInstance().handle(url)
        return handle
    }
    
    
    //MARK: 복사
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}


//
//extension AppDelegate {
//
//    ///Main 화면으로 보내기
//    func showMainViewController() {
//
//        let mainstoryboard = UIStoryboard(name: "", bundle: nil)
//        let mainTabController = mainstoryboard.instantiateViewController(withIdentifier: "TabController") as! TabController
//        mainTabController.selectedViewController = mainTabController.viewControllers?[1]
//
//
//    }
//}
//
