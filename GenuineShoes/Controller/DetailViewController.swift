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
//"https://www.naver.com/"

class DetailViewController: UIViewController, WKUIDelegate {
    var ref: DatabaseReference!
    var detail: Detail?

    var models = [ShoesModel]()

    
    //MARK: 출력 테스트용
//    lazy var myLabel: UILabel = {
//
//        let label = UILabel()
//        label.textColor = .label
//
//        label.text = detail?.legiturl
//
//
//        return label
//    }()
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myUrl = detail?.legiturl
        
        let myURL = URL(string: myUrl ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        

    }

    
}

extension DetailViewController {
    func fetchData(){
        
        db.getData { (error,snapshot) in
            print(snapshot)
            guard let value = snapshot?.value else {return}
            
            do {
                let model = try FirebaseDecoder().decode(ShoesModel.self, from: value)
                
                
          
                
            }catch let err {
                print("\(err.localizedDescription)")
            }
        }
        
    }
}
