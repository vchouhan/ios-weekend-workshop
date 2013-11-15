//
//  ImageViewController.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "ImageViewController.h"
#import "MediaObject.h"

@interface ImageViewController ()
@property (nonatomic, strong) MediaObject *mediaObject;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *captionLabel;
@end

@implementation ImageViewController

// Because an ImageViewController cannot exist without a mediaObject,
// Define a custom init method that accepts a MediaObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mediaObject:(MediaObject *)mediaObject
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mediaObject = mediaObject;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.title = self.mediaObject.username;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.captionLabel.text = self.mediaObject.caption;
    [self.captionLabel sizeToFit];
    
    [self downloadImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)downloadImage
{
    // Use an NSURLSessionDownloadTask to asynchronously fetch the image
    // And set the UIImageView's image to the newly downloaded image
    
    __weak ImageViewController * weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:self.mediaObject.imageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.image = downloadedImage;
        });
    }];
    [getImageTask resume];
}

@end
