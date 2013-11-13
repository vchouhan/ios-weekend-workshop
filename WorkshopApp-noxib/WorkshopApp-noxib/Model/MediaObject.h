//
//  MediaObject.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaObject : NSObject

@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *imageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
