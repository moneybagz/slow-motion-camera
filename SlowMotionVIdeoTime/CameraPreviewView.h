//
//  CameraPreviewView.h
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 9/29/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface CameraPreviewView : UIView

@property (nonatomic) AVCaptureSession *session;

@end
