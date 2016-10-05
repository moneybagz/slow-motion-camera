//
//  CameraPreviewView.m
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 9/29/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import "CameraPreviewView.h"
@import AVFoundation;

@implementation CameraPreviewView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    return previewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    previewLayer.session = session;
}

@end
