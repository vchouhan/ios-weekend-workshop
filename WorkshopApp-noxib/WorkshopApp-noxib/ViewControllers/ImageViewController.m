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
    self.view.backgroundColor = [UIColor whiteColor];
    
    float padding = 10.0f;
    
    float side = self.view.bounds.size.width - 2*padding;
    CGRect imageViewFrame = (CGRect){padding, padding, side, side};
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    imageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:imageView];
    
    CGRect labelFrame = (CGRect){padding, imageView.frame.origin.y + imageView.frame.size.height + padding, imageView.frame.size.width, 200};
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:labelFrame];
    captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    captionLabel.numberOfLines = 0;
    captionLabel.text = self.mediaObject.caption;
    [captionLabel sizeToFit];
    captionLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:captionLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
