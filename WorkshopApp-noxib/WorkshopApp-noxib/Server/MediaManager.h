//
//  MediaManager.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MediaManager;

@protocol MediaManagerDelegate <NSObject>
@required
- (void)mediaManager:(MediaManager *)mediaManager didSucceedWithMedia:(NSArray *)media;
- (void)mediaManager:(MediaManager *)mediaManager didFailWithError:(NSError *)error;
@end

@interface MediaManager : NSObject

@property (nonatomic, weak) id<MediaManagerDelegate> delegate;

- (void)fetchPopularMedia;

@end
