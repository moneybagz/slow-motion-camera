//
//  VideoLibCollectionViewController.h
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/3/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoLibCollectionViewController : UICollectionViewController <UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *filePaths;
@property (strong, nonatomic) IBOutlet UICollectionViewCell *movieImageView;


@end
