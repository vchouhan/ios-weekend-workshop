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
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ImageViewController

- (id)initWithMediaObject:(MediaObject *)mediaObject
{
    self = [super init];
    if (self) {
        self.mediaObject = mediaObject;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.title = self.mediaObject.username;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    float barHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    float padding = 10.0f;
    
    // Setup the UIImageView that will hold the instagram image
    
    float side = self.view.bounds.size.width - 2*padding;
    CGRect imageViewFrame = (CGRect){padding, padding, side, side};
    self.imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [self.view addSubview:self.imageView];
    
    // Setup the UILabel that will hold the image caption
    
    float y = self.imageView.frame.origin.y + self.imageView.frame.size.height + padding;
    float width = self.imageView.frame.size.width;
    float height = self.view.bounds.size.height - barHeight - y - padding;
    
    CGRect labelFrame = (CGRect){padding, y, width, height};
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:labelFrame];
    captionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    captionLabel.numberOfLines = 0;
    captionLabel.text = self.mediaObject.caption;
    [captionLabel sizeToFit];
    
    if (y + captionLabel.frame.size.height > self.view.bounds.size.height - barHeight) {
        CGRect tempFrame = captionLabel.frame;
        tempFrame.size.height = height;
        captionLabel.frame = tempFrame;
    }
    
    [self.view addSubview:captionLabel];
    
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
