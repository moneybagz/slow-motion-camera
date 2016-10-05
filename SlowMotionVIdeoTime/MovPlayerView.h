//
//  MovPlayerView.h
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/4/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

@import UIKit;
@import AVFoundation;
@class AVPlayer;

@interface MovPlayerView : UIView

@property AVPlayer *player;
//@property (readonly) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end
