//
//  HomeCollectionViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/14.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

class HomeCollectionViewController: UIViewController {
       var shoesModels = [ShoesModel]()
       var ref: DatabaseReference! //FireBase RealTime Database
       var shoesmodel: ShoesModel?
    
    
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "homeCell")
        collectionView.register(
            HomeCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeCollectionHeaderView"
        )
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        ref = Database.database().reference()
        view.addSubview(myCollectionView)
        myCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        
    }
    
    func fetchUser(){
        db.observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:AnyObject] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            //print(snapshot)
            
            do{
                let decoder = JSONDecoder()
                let modelList: [ShoesModel] = try decoder.decode([ShoesModel].self, from: data)
                self.shoesModels = modelList
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                    
                    
                    
                }
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
        }
    }
    
}
extension HomeCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        //디테일뷰 컨트롤러에 detail 정보를 인덱스패스로 넘겨줌
        detailViewController.detail = shoesModels[indexPath.row].detail
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoesModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HomeCollectionHeaderView",
                for: indexPath
            ) as? HomeCollectionHeaderView
        else { return UICollectionReusableView() }

        header.setup()

        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell
        cell?.backgroundColor = UIColor.systemBackground
        cell?.layer.cornerRadius = 10
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.label.cgColor
    
        cell?.cellSetupLayout()
        let model = shoesModels[indexPath.row]
        cell?.brandLabel.text = model.brandName
        cell?.modelLabel.text = model.modelName
        if let imageUrl = model.imageUrl {
            cell?.snkImage.loadImageUsingCacheWithUrlString(imageUrl)

        }
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width: CGFloat = collectionView.frame.width - 132.0

        let width: CGFloat = collectionView.frame.width / 2.1
        return CGSize(width: width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width , height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 3

        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    
}

