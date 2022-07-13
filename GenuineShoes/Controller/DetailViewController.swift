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

    
    
    lazy var myLabel: UILabel = {
    
        let label = UILabel()
        label.textColor = .label

        label.text = detail?.legiturl
    
        
        return label
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        
        myLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
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
