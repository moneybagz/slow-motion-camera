//
//  VideoLibCollectionViewController.m
//  SlowMotionVIdeoTime
//
//  Created by Clyfford Millet on 10/3/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import "VideoLibCollectionViewController.h"
@import AVFoundation;
#import "VidLibCell.h"
#import "MovPlayerViewController.h"




@implementation VideoLibCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filePaths = [[NSMutableArray alloc]init];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    UINib *cellNib = [UINib nibWithNibName:@"VidLibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *documentsDirectoryMovies = [documentsDirectory stringByAppendingPathComponent:@"/movies"];
    
    NSLog(@"%@", documentsDirectoryMovies);
    
    //DELETE ALL FILES IN MOVIES DIRECTORY
//    NSFileManager *manager = [NSFileManager defaultManager];
//    NSError *error = nil;
//    NSArray *files = [manager contentsOfDirectoryAtPath:documentsDirectoryMovies
//                                                  error:&error];
//    if(error) {
//        //deal with error and bail.
//    }
//    
//    for(NSString *file in files) {
//        [manager removeItemAtPath:[documentsDirectoryMovies stringByAppendingPathComponent:file]
//                            error:&error];
//        if(error) {
//            //an error occurred...
//        }
//    }
    
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectoryMovies  error:nil];
    
    NSLog(@"files array %@", filePathsArray);
    
    for (NSString *element in filePathsArray){
        NSLog(@"%@", element);
    }
    
    [self.filePaths removeAllObjects];
    
    [self.filePaths addObjectsFromArray:filePathsArray];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filePaths.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    VidLibCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
   // CELL IMAGEVIEW IS CREATED WITH NO PARAMETERS SO IT BECOMES BLANK
   // THE CELL IS ALREADY ALLOCATED IN VIEW DID LOAD WITH UINIB
   // UIImageView *movImageView = [[UIImageView alloc]init];
    
   // cell.movieImageView = movImageView;

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/movies/%@", documentsDirectory, [self.filePaths objectAtIndex:indexPath.row]];
    cell.movieImageView.image = [self previewFromFileAtPath:filepath ratio:.8];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovPlayerViewController *mpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"mpvc"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [NSString stringWithFormat:@"%@/movies/%@", documentsDirectory, [self.filePaths objectAtIndex:indexPath.row]];
    
    //ADDS file://
    mpvc.fileURL =[NSURL fileURLWithPath:filepath];  // [[NSURL alloc]initWithString:filepath];
    
    [self.navigationController pushViewController:mpvc animated:YES];
}

- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio
{
    AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime duration = asset.duration;
    CGFloat durationInSeconds = duration.value / duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(durationInSeconds * ratio, (int)duration.value);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnail;
}

-(UIImage*)previewFromPath:(NSString*)path ratio:(CGFloat)ratio
{
    AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    Float64 durationSeconds = CMTimeGetSeconds([asset duration]);
    CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds/2.0, 600);
    NSError *error;
    CMTime actualTime;
    
    CGImageRef halfWayImage = [imageGenerator copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];
    
    if (halfWayImage != NULL) {
        
        NSString *actualTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
        NSString *requestedTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, midpoint));
        NSLog(@"Got halfWayImage: Asked for %@, got %@", requestedTimeString, actualTimeString);
        
        // Do something interesting with the image.
        //CGImageRelease(halfWayImage);
    }
    
    UIImage *thumbnail = [UIImage imageWithCGImage:halfWayImage];

    return thumbnail;
}

@end
