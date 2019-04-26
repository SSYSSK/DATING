//
//  DATHomeVC.swift
//  DATING
//
//

import UIKit
import CoreLocation
import MJRefresh
let kHomeCollectionViewCell = "HomeCollectionViewCell"
class DATHomeVC: DATBaseVC , CLLocationManagerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    var homeData = DATHomeData()
    var clickUser = DATUser()
    
    var emptyView = loadNib("\(SSTDataEmptyView.classForCoder())") as! SSTDataEmptyView

    override func viewDidLoad() {
        
        super.viewDidLoad()
        gMainNC = self.navigationController
        
        SSTProgressHUD.show()
        let giftData = DATGiftData()
        giftData.getGiftList()
        giftData.delegate = self
        
        let cheatData = DATCheatData()
        cheatData.getFriendList()
        
        let user = DATUser()
        user.delegate = self
        user.token_code = validString(getUserDefautsData(kToken_code))
        user.login_name = validString(getUserDefautsData(kLogin_name))
        user.login_plain_pwd = validString(getUserDefautsData(kLogin_plain_pwd))
        user.phone = validString(getUserDefautsData(kPhone))
        user.getMyUserDetail(userTmp: user) // 这里做回调，登录网易云
        
        print(validString(getUserDefautsData(kLogin_name)))
        print(validString(getUserDefautsData(kOpenfire_plain_pwd)))

        NIMSDK.shared().loginManager.login(validString(getUserDefautsData(kLogin_name)), token: validString(getUserDefautsData(kOpenfire_plain_pwd))) { (error) in
            if error == nil {
                print("登录陈工")
                let chat = NIMSessionListViewController()
                var number = 0
                print("chat===\(chat)")
                if let sessioms = chat.recentSessions {
                    for  secssion in sessioms {
                        let s = secssion as? NIMRecentSession
                        number = number + validInt(s?.unreadCount)
                    }
                    self.tabBarController?.childViewControllers[1].tabBarItem.badgeValue = validString(number)
                }
            }else {
                let loginNC = loadVC(controllerName: "SSTLoginNC", storyboardName: "Login") as! SSTBaseNC
                print("loginNC.childViewControllers===\(loginNC.childViewControllers)")
                let window = UIApplication.shared.delegate?.window
                if window != nil {
                    window!!.rootViewController?.present(loginNC, animated: true, completion: nil)
                }

            }
        }
        homeData.delegate = self
        homeData.fetchData()
        collectionView.register(UINib(nibName:"\(HomeCollectionViewCell.classForCoder())", bundle: nil), forCellWithReuseIdentifier: kHomeCollectionViewCell)
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setLocationManager()
        
        self.collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.homeData.fetchData()
        })
     
        self.collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            
            self.homeData.uploadRefresh(rec_seq: self.homeData.users.count)
        })
        
        emptyView.isHidden = true
        emptyView.frame = self.view.frame
        emptyView.setData(imgName: "icon_load", msg: "数据为空", buttonTitle: "刷新", buttonVisible: false)
        emptyView.buttonClick = {
            self.homeData.fetchData()
        }

        self.collectionView.addSubview(emptyView)

    }

    func resetViewAfterLoginedByAnotherAccount(){
        homeData.fetchData()
    }
    
    @IBAction func choseInfoAction(_ sender: Any) {
        performSegueWithIdentifier(.SegueToChoseInfoVC, sender: nil)
    }
    
    // ****************************** 定位服务 ****************************
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //定位精确度（最高）一般有电源接入，比较耗电
        //kCLLocationAccuracyNearestTenMeters;//精确到10米
        locationManager.distanceFilter = 50 //设备移动后获得定位的最小距离（适合用来采集运动的定位）
        locationManager.requestWhenInUseAuthorization()//弹出用户授权对话框，使用程序期间授权（ios8后)
        //requestAlwaysAuthorization;//始终授权
        locationManager.startUpdatingLocation()
        print("开始定位》》》")
    }
    
    /**
     *  CLlocationDelegate
     */
    //委托传回定位，获取最后一个
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 22.5444922796049   latitude  深圳市
        // 114.078526323481   longitude 深圳市
        currentLocation = locations.last    //注意：获取集合中最后一个位置
        print("定位经纬度为：\(currentLocation.coordinate.latitude)")
        //一直发生定位错误输出结果为0：原因是我输出的是currentLocation.altitude(表示高度的)而不是currentLoction.coordinate.latitude（这个才是纬度）
        print(currentLocation.coordinate.longitude)
       
        geoCoder.reverseGeocodeLocation(currentLocation) { (pls: [CLPlacemark]?, error: Error?)  in
            if error == nil {
                print("反地理编码成功")
                guard let plsResult = pls else {return}
                let firstPL = plsResult.first
                print("firstPL?.locality=\(firstPL?.locality)")
                print("firstPL?.ocean=\(firstPL?.administrativeArea)")
//                biz.city = firstPL?.locality
//                biz.province = firstPL?.administrativeArea
                
                print("biz.user?.city=\(biz.city)")
                print("biz.user?.province=\(biz.province)")
                self.locationManager.stopUpdatingLocation() //成功后停止定位
            }else {
                print("错误")
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位出错拉！！\(error)")
    }
}

extension DATHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeData.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
        let user = self.homeData.users[indexPath.row]
        cell.user = user
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickUser = self.homeData.users[indexPath.row]
        performSegueWithIdentifier(.SegueToUserDetailVC, sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: HomeCollectionViewCellWidth , height: HomeCollectionViewCellWidth / 112 * 143)
    }
    //设置每个item的UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5*kProkScreenWidth, bottom: 0, right: 5*kProkScreenWidth)
    }
    
    //动态设置每行的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*kProkScreenWidth;
    }
    
    //动态设置每列的间距大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2*kProkScreenWidth;
    }
    
}

// MARK: -- segue delegate
extension DATHomeVC: SegueHandlerType {
    
    enum SegueIdentifier: String {
        
        case SegueToUserDetailVC         = "toUserDetailVC"
        case SegueToChoseInfoVC         = "toChoseInfoVC"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue) {
        case .SegueToUserDetailVC:
            let destVC = segue.destination as! DATUserDetailVC
            destVC.user = clickUser
        case .SegueToChoseInfoVC:
            let destVC = segue.destination as! DATChoseInfoVC
            destVC.chooseInfoBlock = { (ageFrom, ageTo , heightFrom, heightTo, inputFrom, inputTo,province, city ) in
                SSTProgressHUD.show()
                biz.city = city
                biz.province = province
                self.homeData.searchData(rec_seq: 0, ageFrom: validInt(ageFrom), ageTo: validInt(ageTo), heightFrom: validInt(heightFrom), heightTo:  validInt(heightTo), inputFrom: validInt(inputFrom), inputTo: validInt(inputTo), province: province, city: city)
            }
        }
    }
}

// MARK: - SSTUIRefreshDelegate

extension DATHomeVC: SSTUIRefreshDelegate {
    func refreshUI(_ data: Any?) {
        SSTProgressHUD.dismiss()
        
        if let tmpData = data as? DATHomeData {
            self.homeData = tmpData
            self.emptyView.isHidden = self.homeData.users.count > 0
        }
        
        self.collectionView.mj_header.endRefreshing()
        self.collectionView.mj_footer.endRefreshing()
        self.collectionView.reloadData()
        if (data as? DATGiftData) != nil {
            if let tmpData = data as? DATGiftData {
                biz.giftData = tmpData
            }
        }
    }
}


