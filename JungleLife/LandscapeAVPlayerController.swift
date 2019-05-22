//
//  LandscapeAVPlayerController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/2/23.
//  Copyright © 2019 Scott.com. All rights reserved.
//


import AVKit

class LandscapeAVPlayerController: AVPlayerViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

}
