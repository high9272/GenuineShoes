//
//  DetailViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/03.
//


import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
import SnapKit
import WebKit
import CodableFirebase

class DetailViewController: UIViewController, WKUIDelegate {
    
    var detail: Detail?
    
    var models: [Model] = []
    
    
    let db = Database.database().reference()
    var ref: DatabaseReference! //FireBase RealTime Database
    
    lazy var myLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    //    lazy var webView: WKWebView = {
    //        let webConfiguration = WKWebViewConfiguration()
    //        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
    //        webView.uiDelegate = self
    //        webView.translatesAutoresizingMaskIntoConstraints = false
    //        return webView
    //    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        let myURL = URL(string: "https://legitgrails.com/blogs/jordan/jordan-1-dark-mocha-real-vs-fake-guide?_pos=1&_sid=eec5e7857&_ss=r")
        //        let myRequest = URLRequest(url: myURL!)
        //        webView.load(myRequest)
        //        view.addSubview(webView)
        //        webView.snp.makeConstraints { make in
        //            make.edges.equalToSuperview()
        //        }
        
        view.addSubview(myLabel)
        myLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        //print(detail?.)
        myLabel.text = detail?.legiturl
        print(detail?.legiturl)
        //fetchData()
    }
    
    func fetchData(){
        
        self.db.child("mydata").getData { (error,snapshot) in
            guard let value = snapshot?.value else {return}
            
            do {
                let model = try FirebaseDecoder().decode(Model.self, from: value)
                
               
                print(model.modelName)
                
            }catch let err {
                print(err)
            }
        }
        
    }
    
    
}




