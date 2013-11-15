//
//  MediaManager.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaManager.h"

#define POPULAR_MEDIA_ENDPOINT @"https://api.instagram.com/v1/media/popular?client_id="
#define INSTAGRAM_CLIENT_ID @"5609d2fb2bf74d749716bd00a9090e5e"

// The Instagram "popular media" endpoint we're hitting is documented here:
// http://instagram.com/developer/endpoints/media/#get_media_popular

@implementation MediaManager

#pragma mark - Networking

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(NSDictionary *dictionary, NSError *error))completionBlock
{
    NSString * endpoint = [NSString stringWithFormat:@"%@%@", POPULAR_MEDIA_ENDPOINT, INSTAGRAM_CLIENT_ID];
    
    NSURL *URL = [NSURL URLWithString:endpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // Use an NSURLSessionDataTask to asynchronously fetch JSON from Instagram's "popular media" endpoint
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Check for errors related to the request and response
        // Call the requisite delegate methods
        
        if (error) {
            completionBlock(nil, error);
        } else {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
            if (error){
                completionBlock(nil, error);
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200) {
                    completionBlock(dictionary, nil);
                } else {
                    NSMutableDictionary *details = [NSMutableDictionary dictionary];
                    [details setValue:@"error message" forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:@"error_domain" code:666 userInfo:details];
                    completionBlock(nil, error);
                }
            }
        }
        
    }];
    [task resume];
}

@end

