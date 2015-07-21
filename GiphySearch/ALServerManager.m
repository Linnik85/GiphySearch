//
//  ALServerManager.m
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALServerManager.h"


@interface ALServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@end


@implementation ALServerManager


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]init];
    }
    return self;
}


+(ALServerManager*) sharedManager{
    
    static ALServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ALServerManager alloc]init];
    });
    
    return manager;
}


-(void) getCurrentWeather: (NSString*) cityName
                OnSuccess: (void(^)(NSDictionary* respondsValue)) success
                onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure{
    
    self.requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.requestOperationManager GET:[[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@",cityName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  
                                  NSDictionary* weatherDict = [[NSDictionary alloc]initWithDictionary:responseObject];
                                  
                                  if (success) {
                                      success(weatherDict);
                                  }
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                                  if (failure) {
                                      
                                      failure(error, operation.response.statusCode);
                                      
                                  }
                              }];

}


-(void) imageDownload:(NSString*) imageID
           onSuccess: (void(^)(id imgData))succes
           onFailure: (void(^)(NSError* error, NSInteger statusCode))failure
{
 
            self.requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString* urlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",imageID];
    
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
            AFHTTPRequestOperation *operation = [self.requestOperationManager HTTPRequestOperationWithRequest:request
                                                                                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                 {
                                                     if (succes)
                                                         
                                                     {
                                                         
                                                        succes(responseObject);
                                                         
                                                     }
                                                 }
                                                                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                 {
                                                     if (failure)
                                                     {
                                                         
                                                         failure(error, operation.response.statusCode);
                                                         
                                                     }
    
                        }
                                                 
];
                [self.requestOperationManager.operationQueue addOperation:operation];

}
                                                 
                                                 
                                                 
@end
