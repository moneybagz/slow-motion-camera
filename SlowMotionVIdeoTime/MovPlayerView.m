//
//  MovPlayerView.m
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/4/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import "MovPlayerView.h"
@import AVFoundation;



@implementation MovPlayerView

- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}

// override UIView
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

@end
