//
//  DATGiftVC.swift
//  DATING
//
//  Created by 天星 on 17/8/10.
//  Copyright © 2017年 深圳指掌人科技有限公司. All rights reserved.
//

import UIKit
import MJRefresh

let kDATGiftCell = "GiftCell"
class DATGiftVC: DATBaseVC {
    let giftData = DATGiftData()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SSTProgressHUD.show()
        
        collectionView.register(UINib(nibName:"\(DATGiftCell.classForCoder())", bundle: nil), forCellWithReuseIdentifier: kDATGiftCell)
        
        giftData.delegate = self
        

        giftData.getGiftByUser()
        
       
        self.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
             self.giftData.getGiftByUser()
        })
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DATGiftVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.giftData.gifts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDATGiftCell, for: indexPath) as! DATGiftCell
        let gift = self.giftData.gifts[indexPath.row]
        cell.gift = gift
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HomeCollectionViewCellWidth , height: HomeCollectionViewCellWidth / 101 * 117)
    }
    //设置每个item的UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15*kProkScreenWidth, bottom: 0, right: 15*kProkScreenWidth)
    }
    
    //动态设置每行的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*kProkScreenWidth;
    }
    
    //动态设置每列的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1*kProkScreenWidth;
    }
    
}


// MARK: - SSTUIRefreshDelegate

extension DATGiftVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        print("self.giftData====\(self.giftData)")
        self.collectionView.mj_header.endRefreshing()
        self.collectionView.reloadData()
    }
}


