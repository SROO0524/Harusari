//
//  MainVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/14.
//  Copyright © 2020 김믿음. All rights reserved.
//
// 안녕

import UIKit
import Firebase

// MARK: Main화면

class MainVC: UIViewController {
//    lazy var navAccountVC = UINavigationController(rootViewController: accountVC)
    
    let accountVC = AccountViewController()
    
    lazy var navController = UINavigationController(rootViewController: self.loginVC)
    let loginVC = SignInVC()
    // MARK: Properties
    var shareImage: UIImage?
    
    // Select Money
    var selectMoney = UserDefaults.standard.string(forKey: UserReference.balance) ?? ""
    
    //
    var buttonToggle = false
    
    // Timer Setup
    var centerXChangeTimer = Timer()
    var labeltextChangeTimer = Timer()
    
    // animation setup element
    var aniDuration: Double = 1
    var labelTimerInterval = 0.01
    
    // Money List
    var moneyList = ["10000", "20000", "30000", "40000", "50000"]
    
    var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.text = ""
        return label
    }()
    
    var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("logout", for: .normal)
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()
    
    var time: Int = 0 {
        didSet {
            labeltextChangeTimer.invalidate()
            callLabelTimer()
            guard self.aniDuration < 6 else {
                self.selectMoney = self.moneyLabel.text!
                UIView.animateKeyframes(
                    withDuration: self.aniDuration,
                    delay: 0,
                    animations: {
                        UIView.addKeyframe(
                            withRelativeStartTime: 0,
                            relativeDuration: 0.03
                        ){
                            UIView.animate(withDuration: 1, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                                self.moneyLabel.center.x = self.view.center.x
                            }, completion: nil)
                        }
                })
                centerXChangeTimer.invalidate()
                labeltextChangeTimer.invalidate()
                UserDefaults.standard.set(self.selectMoney, forKey: UserReference.balance)
                print("추첨된 금액은\(self.selectMoney)원 입니다.")
                guard let userName = UserDefaults.standard.string(forKey: UserReference.name) else {return}
                let alert = UIAlertController(title: "알림", message:
                    """
                    오늘 \(userName)님의
                    도전금액은 \(selectMoney)원 입니다.
                    친구들에게 공유해주세요!!
                    """, preferredStyle: .alert)
                let ok = UIAlertAction(title: "공유하기", style: .default) { (presentActivity) in
                    self.showActivity()
                    UIView.animate(withDuration: 0.5) {
                        self.moneyLabel.alpha = 0
                    }
                }
                let cancel = UIAlertAction(title: "공유 안하기", style: .cancel) { (presentAccountView) in
                    self.navigationController?.pushViewController(self.accountVC, animated: true)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    UIView.animate(withDuration: 2) {
                        self.moneyLabel.center.y -= 200
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        self.present(alert, animated: true)
                    }
                }
                alert.addAction(ok)
                alert.addAction(cancel)
                return
            }
            UIView.animateKeyframes(
                withDuration: self.aniDuration,
                delay: 0,
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.03
                    ){
                        self.moneyLabel.center.x -= 600
                    }
                    self.moneyLabel.center.x = self.view.center.x + 300
            })
            self.aniDuration += 1
            self.labelTimerInterval += 0.1
        }
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        checkIfUserLoggedIn()
    }
    
    
    // MARK: @objc
    @objc func didTapButton() {
        if buttonToggle == false {
            print("start animation")
            callCenterXTimer()
        }else {
            centerXChangeTimer.invalidate()
            labeltextChangeTimer.invalidate()
        }
        buttonToggle.toggle()
    }
    
    @objc func updateTime() {
        self.time += 1
        print(self.time)
    }
    
    @objc func updateLabelText() {
        self.moneyLabel.text = self.moneyList.randomElement()
    }
    
    @objc func didTapLogout() {
        try? Auth.auth().signOut()
        UserDefaults.standard.set("", forKey: UserReference.name)
        UserDefaults.standard.set("", forKey: UserReference.balance)
        UserDefaults.standard.set("", forKey: UserReference.email)
        print("logout")
        navController.title = "Login"
        navController.navigationBar.prefersLargeTitles = true
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: Helpers
    func callLabelTimer() {
        labeltextChangeTimer = Timer.scheduledTimer(timeInterval: labelTimerInterval, target: self, selector: #selector(updateLabelText), userInfo: nil, repeats: true)
    }
    
    func callCenterXTimer() {
        centerXChangeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func showActivity() {
        guard let userName = UserDefaults.standard.string(forKey: UserReference.name) else {return}
        let shareText: String = """
        From. HaruSari
        \(userName)님의 하루살이가 시작되었습니다.
        \(self.selectMoney)원ㅋㅋㅋㅋ
        과소비 근절 캠페인
        하루 살이
        AppStore 다운로드
        htps://apps.apple.com/us/app/keynote/id409183694?mt=12
        """
        switch self.selectMoney {
        case "10000":
            shareImage = UIImage(named: "10000원")
        case "20000":
            shareImage = UIImage(named: "20000원")
        case "30000":
            shareImage = UIImage(named: "30000원")
        case "40000":
            shareImage = UIImage(named: "40000원")
        case "50000":
            shareImage = UIImage(named: "50000원")
        default:
            print("default")
        }
        
        var shareObject = [Any]()
        
        shareObject.append(shareImage!)
        shareObject.append(shareText)
        
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    // MARK: ConfigureViewComponents
    private func configureViewComponents() {
        view.backgroundColor = .white
        title = "금액 추첨"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(moneyLabel)
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        moneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 300).isActive = true
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
    }
    
    // MARK: 로그인이 되어 있으면 Main 화면 / 로그인 안되어 있음 로그인 화면 나타남
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            print("current login state is LOGOUT")
            DispatchQueue.main.async {
                self.navController.navigationBar.topItem?.title = "로그인"
                self.navController.navigationBar.prefersLargeTitles = true
                self.navController.modalPresentationStyle = .fullScreen
                self.present(self.navController, animated: true)
            }
            return
        } else {
            print("current login state is LOGIN")
        }
    }
}
