//
//  ALServerManager.h
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALWeatherItem.h"
#import "AFNetworking.h"


@interface ALServerManager : NSObject

+(ALServerManager*) sharedManager;


-(void) getCurrentWeather: (NSString*) cityName
                  OnSuccess: (void(^)(NSDictionary* respondsValue)) success
                  onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;


-(void) imageDownload:(NSString*) imageID
            onSuccess: (void(^)(id imgData))succes
            onFailure: (void(^)(NSError* error, NSInteger statusCode))failure;


@end
