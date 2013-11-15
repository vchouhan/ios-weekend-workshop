//
//  ImageViewController.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "ImageViewController.h"
#import "MediaObject.h"
#import "MediaManager.h"

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
    
    self.edgesForExtendedLayout = UIRectEdgeNone; // Ensure that our UI elements begin just after the navigationBar rather than beneath it
    
    self.captionLabel.text = self.mediaObject.caption;
    [self.captionLabel sizeToFit];
    
    // Init an instance of the MediaManager class,
    // And use it to download and set the image property of our UIImageView
    
    MediaManager *mediaManager = [[MediaManager alloc] init];

    __weak ImageViewController * weakSelf = self;
    [mediaManager downloadImage:self.mediaObject.imageURL withCompletionBlock:^(NSURL *location, NSError *error) {
        NSLog(@"location: %@", location);
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.image = downloadedImage;
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
