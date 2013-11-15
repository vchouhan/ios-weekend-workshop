//
//  TestViewController.m
//  DelegateExample
//
//  Created by Alfie Hanssen on 11/15/13.
//  Copyright (c) 2013 Alfie Hanssen. All rights reserved.
//

#import "TestViewController.h"
#import "MediaManager.h"

@interface TestViewController ()
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
    
    __weak TestViewController * weakSelf = self;
    [self.mediaManager fetchPopularMediaWithCompletionBlock:^(NSDictionary *dictionary, NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (dictionary) {
                NSLog(@"SUCCESS: %@", dictionary);
                [weakSelf alertWithMessage:@"success :)"];

            } else if (error) {
                NSLog(@"FAILURE: %@", error.localizedDescription);
                [weakSelf alertWithMessage:@"failure :("];
            }
        });

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
