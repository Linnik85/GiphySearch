//
//  ALServerManager.h
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface ALServerManager : NSObject

+(ALServerManager*) sharedManager;


-(void) searchGifWithParams: (NSDictionary*) params
                    OnSuccess: (void(^)(NSDictionary* respondsValue)) success
                    onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) fileDownload:(NSString*) url
    progressDownload: (void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)) progressDownload
           onSuccess: (void(^)(id imgData))succes
           onFailure: (void(^)(NSError* error, NSInteger statusCode))failure;


@end
