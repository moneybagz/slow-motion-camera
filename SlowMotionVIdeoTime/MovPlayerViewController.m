//
//  MovPlayerViewController.m
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/4/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//



@import AVFoundation;
#import "MovPlayerViewController.h"
#import "MovPlayerView.h"


@interface MovPlayerViewController ()

@property(nonatomic,strong)AVPlayer *player;

@property (strong, nonatomic)AVPlayerItem *playerItem;
//@property (strong, nonatomic) MovPlayerView *moviePlayerView;
//@property (readonly) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVURLAsset *asset;


@end

@implementation MovPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (!self.player){
//        self.player = [[AVPlayer alloc]init];
//    }
    
//    if (self.playerLayer){
//        self.playerLayer = [MovPlayerView layerClass];
//    }
    
//    if (!self.moviePlayerView){
//        self.moviePlayerView = [[MovPlayerView alloc]init];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", [self.fileURL absoluteString]);
    
    self.movPlayerView.playerLayer = [[AVPlayerLayer alloc]init];
    
    
    self.asset = [AVURLAsset assetWithURL:self.fileURL];
    
    NSLog(@"seconds = %f", CMTimeGetSeconds(self.asset.duration));

    
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];

    //ORDER OF OPERATIONS MISTAKE MADE HERE
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];

    self.movPlayerView.playerLayer.player = self.player;
    
    
    //[self.playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
}

- (void)syncUI {
    if ((self.player.currentItem != nil) &&
        ([self.player.currentItem status] == AVPlayerItemStatusReadyToPlay)) {
        self.playButton.enabled = YES;
    }
    else {
        self.playButton.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.player pause];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playButtonPressed:(id)sender {
    [self.player play];
    
    NSLog(@"pressed play");
}

- (IBAction)stopButtonPressed:(id)sender {
    
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player pause];
    NSLog(@"pressed stop");

}
@end
