//
//  MediaObject.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaObject.h"

@interface MediaObject ()
@property (nonatomic, strong) NSDictionary *dictionary;
@end

@implementation MediaObject

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (NSString *)objectID
{
    NSString *objectID = @"No ID";
    NSString *tempObjectID = [self.dictionary valueForKey:@"id"];
    if (tempObjectID && (NSNull *)objectID != [NSNull null]) {
        objectID = tempObjectID;
    }
    return objectID;
}

- (NSString *)caption
{
    NSString * caption = @"No caption";
    NSDictionary *tempCaption = [self.dictionary valueForKey:@"caption"];
    if (tempCaption && (NSNull *)tempCaption != [NSNull null]) {
        NSString * title = [tempCaption valueForKey:@"text"];
        if (title && (NSNull *)title != [NSNull null]) {
            caption = title;
        }
    }
    return caption;
}

@end
