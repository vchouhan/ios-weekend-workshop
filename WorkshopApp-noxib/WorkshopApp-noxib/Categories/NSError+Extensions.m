//
//  NSError+Extensions.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/12/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "NSError+Extensions.h"

@implementation NSError (Extensions)

+ (NSError *)errorFromResponse:(NSDictionary *)response
{
    int code = 404;
    NSString *type = @"Unknown";
    NSString *message = @"An error occurred";
    
    NSDictionary *meta = [response valueForKey:@"meta"];
    if (meta && (NSNull *)meta != [NSNull null]) {
        
        NSString *tempCode = [[response valueForKey:@"meta"] valueForKey:@"code"];
        if (tempCode && (NSNull *)tempCode != [NSNull null]) {
            code = [tempCode intValue];
        }
        
        NSString *tempType = [[response valueForKey:@"meta"] valueForKey:@"error_type"];
        if (tempType && (NSNull *)tempType != [NSNull null]) {
            type = tempType;
        }
        
        NSString *tempMessage = [[response valueForKey:@"meta"] valueForKey:@"error_message"];
        if (tempMessage && (NSNull *)tempMessage != [NSNull null]) {
            message = tempMessage;
        }
    }
    
    NSMutableDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:message forKey:NSLocalizedDescriptionKey];
    
    return [NSError errorWithDomain:type code:code userInfo:details];
}

@end
