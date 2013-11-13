//
//  MediaObject.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaObject.h"

@implementation MediaObject

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.objectID = [self parseObjectID:dictionary];
        self.caption = [self parseCaption:dictionary];
        self.imageURL = [self parseImageURL:dictionary];
    
    }
    return self;
}

- (NSString *)parseObjectID:(NSDictionary *)dictionary
{
    NSString *objectID = @"No ID";
    NSString *tempObjectID = [dictionary valueForKey:@"id"];
    if (tempObjectID && (NSNull *)objectID != [NSNull null]) {
        objectID = tempObjectID;
    }
    return objectID;
}

- (NSString *)parseCaption:(NSDictionary *)dictionary
{
    NSString * caption = @"No caption";
    NSDictionary *tempCaption = [dictionary valueForKey:@"caption"];
    if (tempCaption && (NSNull *)tempCaption != [NSNull null]) {
        NSString * title = [tempCaption valueForKey:@"text"];
        if (title && (NSNull *)title != [NSNull null]) {
            caption = title;
        }
    }
    return caption;
}

- (NSURL *)parseImageURL:(NSDictionary *)dictionary
{
    NSString *urlString = @"";
    NSDictionary *images = [dictionary valueForKey:@"images"];
    if (images && (NSNull *)images != [NSNull null]) {
        NSDictionary * imageDictionary = [images valueForKey:@"standard_resolution"];
        if (imageDictionary && (NSNull *)imageDictionary != [NSNull null]) {
            NSString *tempURLString = [imageDictionary valueForKey:@"url"];
            if (tempURLString && (NSNull *)tempURLString != [NSNull null]) {
                urlString = tempURLString;
            }
        }
    }
    return [NSURL URLWithString:urlString];
}

@end
