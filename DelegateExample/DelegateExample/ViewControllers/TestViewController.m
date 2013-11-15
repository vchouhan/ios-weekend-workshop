//
//  TestViewController.m
//  DelegateExample
//
//  Created by Alfie Hanssen on 11/15/13.
//  Copyright (c) 2013 Alfie Hanssen. All rights reserved.
//

#import "TestViewController.h"
#import "MediaManager.h"

@interface TestViewController () <MediaManagerDelegate>
@property (nonatomic, strong) MediaManager *mediaManager;
@end

@implementation TestViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.mediaManager = [[MediaManager alloc] init];
    self.mediaManager.delegate = self;
    
    [self.mediaManager fetchPopularMedia];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MediaManager Delegate

- (void)mediaManager:(MediaManager *)mediaManager didSucceedWithDictionary:(NSDictionary *)dictionary
{
    NSLog(@"SUCCESS: %@", dictionary);

    __weak TestViewController * weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [weakSelf alertWithMessage:@"success :)"];
    });
}

- (void)mediaManager:(MediaManager *)mediaManager didFailWithError:(NSError *)error
{
    NSLog(@"FAILURE: %@", error.localizedDescription);

    __weak TestViewController * weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [weakSelf alertWithMessage:@"failure :("];
    });
}

#pragma mark - Utilities

- (void)alertWithMessage:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"API Response?"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"Okay"
                                           otherButtonTitles:nil];
    [alert show];
}

@end
