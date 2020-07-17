//
//  LottieView.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/16.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Lottie

class LottieVC : UIViewController {

    private var animationView: AnimationView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "15643-ani-icon-illustration80px-cuentaprotegida")
        animationView!.frame = view.bounds

        animationView!.contentMode = .scaleAspectFit

        animationView!.loopMode = .playOnce

        animationView!.animationSpeed = 0.5

        view.addSubview(animationView!)

        animationView!.play()

        animationView!.pause()


    }

}
