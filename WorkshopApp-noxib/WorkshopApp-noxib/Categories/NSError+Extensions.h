//
//  NSError+Extensions.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/12/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Extensions)

+ (NSError *)errorFromResponse:(NSDictionary *)response;

@end
