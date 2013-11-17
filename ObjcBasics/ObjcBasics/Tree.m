//
//  Tree.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "Tree.h"

@implementation Tree

- (id)initWithSpecies:(NSString *)species age:(int)age
{
    self = [super init];
    if (self) {
        self.species = species;
        self.age = age;
    }
    return self;
}

- (void)printInfo
{
    NSLog(@"This %@ tree is %i years old.", self.species, self.age);
}

@end
