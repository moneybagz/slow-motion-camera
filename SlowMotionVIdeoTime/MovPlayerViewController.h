//
//  MovPlayerViewController.h
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/4/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MovPlayerView.h"
@class MovPlayerView;


@interface MovPlayerViewController : UIViewController

@property(nonatomic, strong) NSURL *fileURL;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (strong, nonatomic) IBOutlet MovPlayerView *movPlayerView;

- (IBAction)playButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;

@end
