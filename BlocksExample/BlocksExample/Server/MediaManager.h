//
//  MediaManager.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaManager : NSObject

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(NSDictionary *dictionary, NSError *error))completionBlock;

@end
