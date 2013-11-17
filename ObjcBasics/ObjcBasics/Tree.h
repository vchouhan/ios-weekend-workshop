//
//  Tree.h
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tree : NSObject

@property (nonatomic, strong) NSString *species;
@property (nonatomic, assign) int age;

- (id)initWithSpecies:(NSString *)species age:(int)age;

- (void)printInfo;

@end
