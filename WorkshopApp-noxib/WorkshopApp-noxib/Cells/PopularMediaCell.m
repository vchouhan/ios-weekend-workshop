//
//  PopularMediaCell.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "PopularMediaCell.h"

@implementation PopularMediaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMediaObject:(NSDictionary *)mediaObject
{
    _mediaObject = mediaObject;
    
    NSString *objectID = @"No ID";
    NSString *caption = @"No caption";
    
    NSString *tempObjectID = [mediaObject valueForKey:@"id"];
    if (tempObjectID && (NSNull *)objectID != [NSNull null]) {
        objectID = tempObjectID;
    }
    
    NSDictionary *tempCaption = [mediaObject valueForKey:@"caption"];
    if (tempCaption && (NSNull *)tempCaption != [NSNull null]) {
        NSString * title = [tempCaption valueForKey:@"text"];
        if (title && (NSNull *)title != [NSNull null]) {
            caption = title;
        }
    }
        
    self.textLabel.text = objectID;
    self.detailTextLabel.text = caption;
}

@end
