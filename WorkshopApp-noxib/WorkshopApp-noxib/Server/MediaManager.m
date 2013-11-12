//
//  MediaManager.m
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/11/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "MediaManager.h"

#define POPULAR_MEDIA_ENDPOINT @"https://api.instagram.com/v1/media/popular?client_id="
#define INSTAGRAM_CLIENT_ID @"a19b12119e254fe78d2b75cda6cec5b9"

@implementation MediaManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)fetchPopularMedia
{
    NSString * endpoint = [NSString stringWithFormat:@"%@%@", POPULAR_MEDIA_ENDPOINT, INSTAGRAM_CLIENT_ID];
    
    NSURL *URL = [NSURL URLWithString:endpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    __weak MediaManager * weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
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
                                                            error = [weakSelf errorFromResponse:dictionary];
                                                            [weakSelf.delegate mediaManager:weakSelf didFailWithError:error];
                                                        }
                                                    }
                                                }
                                                
                                            }];
    [task resume];
}

- (NSError *)errorFromResponse:(NSDictionary *)response
{
    // We would normally check the integrity of the "response" dictionary,
    // However, in the interest of time we will assume it contains the keys "meta", "error_type", "code" and "error_message"
    
    NSString *type = [[response valueForKey:@"meta"] valueForKey:@"error_type"];
    int code = [[[response valueForKey:@"meta"] valueForKey:@"code"] intValue];
    NSString *message = [[response valueForKey:@"meta"] valueForKey:@"error_message"];
    
    NSMutableDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:message forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:type code:code userInfo:details];
    
    return error;
}

- (NSArray *)mediaFromResponse:(NSDictionary *)response
{
    // We would normally check the integrity of the "response" dictionary,
    // However, in the interest of time we will assume it contains the key "data"

    NSArray *data = [response valueForKey:@"data"];
    return data;
}

@end
