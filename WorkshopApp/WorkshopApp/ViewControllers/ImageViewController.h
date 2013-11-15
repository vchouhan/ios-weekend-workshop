//
//  ImageViewController.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MediaObject;

@interface ImageViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil mediaObject:(MediaObject *)mediaObject;

@end
