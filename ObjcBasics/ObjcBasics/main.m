//
//  main.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
 
        
        // Example #1
        
        NSString *name = @"Alfie";
        int age = 34;
        float height = 6 + 4.0f/12;
        
        NSLog(@"My name is %@. I am %i years old. I am %.2f feet tall.", name, age, height);
        
        
        // Example #2
        
        BOOL hasPrettyLongName = NO;
        
        if ([name length] > 10) {
            hasPrettyLongName = YES;
        } else {
            hasPrettyLongName = NO;
        }
        
        NSLog(@"Is my name pretty long? %i (%i characters)", hasPrettyLongName, [name length]);

        
        // Example #3
        
        NSArray *numbers = @[@10, @20, @25, @100];
        
        float sum = 0.0f;
        
        for (int i = 0; i < [numbers count]; i++) {
            NSNumber *number = numbers[i];
            sum = sum + [number intValue];
        }
        
        float average = sum / [numbers count]; // Should be 38.75
        
        NSLog(@"average = %.2f", average);
        
        
        // Example #4
        
        NSDictionary *myInfo = @{@"name":@"Alfie",
                               @"age":@34,
                               @"height":@6.33};

        NSArray *allKeys = [myInfo allKeys];
        
        for (int i = 0; i < [allKeys count]; i++) {
            
            NSString *key = [allKeys objectAtIndex:i];
            id value = [myInfo valueForKey:key];
            
            NSLog(@"%@ : %@", key, value);
        }
        
//        UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
