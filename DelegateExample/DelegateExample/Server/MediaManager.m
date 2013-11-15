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

- (void)dealloc
{
    self.delegate = nil;
}

#pragma mark - Networking

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
                    [weakSelf.delegate mediaManager:weakSelf didSucceedWithDictionary:dictionary];
                } else {
                    NSMutableDictionary *details = [NSMutableDictionary dictionary];
                    [details setValue:@"error message" forKey:NSLocalizedDescriptionKey];
                    error = [NSError errorWithDomain:@"error_domain" code:666 userInfo:details];
                    [weakSelf.delegate mediaManager:weakSelf didFailWithError:error];
                }
            }
        }
        
    }];
    [task resume];
}

@end
