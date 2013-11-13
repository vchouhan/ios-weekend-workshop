//
//  PopularMediaCell.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "PopularMediaCell.h"
#import "MediaObject.h"

@implementation PopularMediaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMediaObject:(MediaObject *)mediaObject
{
    _mediaObject = mediaObject;
    
    self.textLabel.text = mediaObject.objectID;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
