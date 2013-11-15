//
//  MediaManager.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaManager.h"
#import "NSError+Extensions.h"
#import "MediaObject.h"

#define POPULAR_MEDIA_ENDPOINT @"https://api.instagram.com/v1/media/popular?client_id="
#define INSTAGRAM_CLIENT_ID @"5609d2fb2bf74d749716bd00a9090e5e"

// http://instagram.com/developer/endpoints/media/#get_media_popular

@implementation MediaManager

- (void)dealloc
{
    self.delegate = nil;
}

- (void)fetchPopularMedia
{
    NSString * endpoint = [NSString stringWithFormat:@"%@%@", POPULAR_MEDIA_ENDPOINT, INSTAGRAM_CLIENT_ID];
    
    NSURL *URL = [NSURL URLWithString:endpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // Use an NSURLSessionDataTask to asynchronously fetch JSON from Instagram's "popular media" endpoint
    
    __weak MediaManager * weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Check for errors related to the request and response
        // Call the requisite delegate methods
        
        if (error) {
            [weakSelf.delegate mediaManager:weakSelf didFailWithError:error];
        } else {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
            if (error){
                [weakSelf.delegate mediaManager:weakSelf didFailWithError:error];
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200) {
                    NSArray *media = [weakSelf mediaFromResponse:dictionary];
                    [weakSelf.delegate mediaManager:weakSelf didSucceedWithMedia:media];
                } else {
                    error = [NSError errorFromResponse:dictionary];
                    [weakSelf.delegate mediaManager:weakSelf didFailWithError:error];
                }
            }
        }
        
    }];
    [task resume];
}

- (NSArray *)mediaFromResponse:(NSDictionary *)response
{
    NSMutableArray * mediaObjects = [NSMutableArray array];
    
    // Convert dictionaries into instances of the MediaObject class
    
    NSArray *data = [response valueForKey:@"data"];
    if (data && (NSNull *)data != [NSNull null]) {
        for (NSDictionary *mediaDictionary in data) {
            MediaObject *mediaObject = [[MediaObject alloc] initWithDictionary:mediaDictionary];
            [mediaObjects addObject:mediaObject];
        }
    }
    
    // Sort mediaObjects alphabetically by username
    
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
    NSArray * descriptors = @[descriptor];
    NSArray * sortedArray = [mediaObjects sortedArrayUsingDescriptors:descriptors];

    return sortedArray;
}

@end
