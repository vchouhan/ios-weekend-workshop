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
        
        // Extract the data we require,
        // Checking for presence and validity of the data along the way,
        // Falling back on default values if something's amiss
        
        self.username = [self parseUsername:dictionary];
        self.caption = [self parseCaption:dictionary];
        self.imageURL = [self parseImageURL:dictionary];
    
    }
    return self;
}

- (NSString *)parseUsername:(NSDictionary *)dictionary
{
    NSString * username = @"-";
    NSDictionary *userDict = [dictionary valueForKey:@"user"];
    if (userDict && (NSNull *)userDict != [NSNull null]) {
        NSString * tempUsername = [userDict valueForKey:@"username"];
        if (tempUsername && (NSNull *)tempUsername != [NSNull null]) {
            username = tempUsername;
        }
    }
    return username;
}

- (NSString *)parseCaption:(NSDictionary *)dictionary
{
    NSString * caption = @"-";
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
