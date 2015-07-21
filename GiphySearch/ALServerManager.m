//
//  ALServerManager.m
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALServerManager.h"

NSString * const kGiphyPublicAPIKey = @"dc6zaTOxFJmzC";



@interface ALServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@property (strong, nonatomic) NSString* baseUrl;

@end


@implementation ALServerManager


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
       self.baseUrl = @"http://api.giphy.com/v1/gifs/search";
        
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



-(void) searchGifWithParams: (NSDictionary*) params
                    OnSuccess: (void(^)(NSDictionary* respondsValue)) success
                    onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure{
    NSMutableDictionary* currentParams = [params mutableCopy];
    
    [currentParams setObject:kGiphyPublicAPIKey forKey:@"api_key"];
    
    [self.requestOperationManager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    [self.requestOperationManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [self.requestOperationManager GET:self.baseUrl
                            parameters:currentParams
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   
                                   NSDictionary* respondsDict = [[NSDictionary alloc] initWithDictionary:responseObject];
                                   
                                   if (success) {
                                       success(respondsDict);
                                  }
                                   
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   
                                   NSLog(@"Error: %@", error);
                                   if (failure) {
                                       
                                       failure(error, operation.response.statusCode);
                                   }
                               }];
}



-(void) fileDownload:(NSString*) url
    progressDownload: (void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)) progressDownload
           onSuccess: (void(^)(id imgData))succes
           onFailure: (void(^)(NSError* error, NSInteger statusCode))failure
{
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            self.requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];

            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
               
            AFHTTPRequestOperation *operation = [self.requestOperationManager HTTPRequestOperationWithRequest:request
                                                                                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                 {
                                                     if (succes)
                                                     {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             
                                                             succes(responseObject);
                                                         });
                                                     }
                                                 }
                                                                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                 {
                                                     if (failure)
                                                     {
                                                         failure(error, operation.response.statusCode);
                                                     }
                                                 }];
            
            if(progressDownload)
            {
                [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
                 {
                     progressDownload(bytesRead, totalBytesRead, totalBytesExpectedToRead);
                 }];
            }
               
            [self.requestOperationManager.operationQueue addOperation:operation];
               
        });
}

                                                 
@end
