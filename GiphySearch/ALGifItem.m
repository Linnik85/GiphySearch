//
//  ALGifItem.m
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALGifItem.h"
#import "ALServerManager.h"

@interface ALGifItem ()


@property(strong, nonatomic) ALServerManager* serverManager;

@end


@implementation ALGifItem


- (id) initWithServerResponse:(NSDictionary*) responseObject{
    
    
    self = [super init];
    
    if (self) {
        
        self.serverManager = [ALServerManager sharedManager];

        self.url = [responseObject objectForKey:@"url"];
        
    }
    
    return self;

}


- (void) loadImageByUrl:(NSString*)url {
    
    [self.serverManager fileDownload:url progressDownload:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        if ([self.delegate respondsToSelector:@selector(progtessLoadImageTotalBytesRead:totalBytesExpectedToRead:)]) {
            
            [self.delegate progtessLoadImageTotalBytesRead:totalBytesRead totalBytesExpectedToRead:totalBytesExpectedToRead];
        }

            }
                                             onSuccess:^(id imgData) {
                                                 
                                                 self.imageData = imgData;
                                                 
                                                 if ([self.delegate respondsToSelector:@selector(getImagResponds:)]) {
                                                     
                                                     [self.delegate getImagResponds:imgData];
                                                 }
        
        
                                             }
                                             onFailure:^(NSError *error, NSInteger statusCode) {
                                                 
                                                 if ([self.delegate respondsToSelector:@selector(errorResponds:)]) {
                                                     
                                                     [self.delegate errorResponds:[NSString stringWithFormat:@"ERROR: %@", error.localizedDescription]];
                                                     
                                                 }
                                                 
                                             }];

}


@end
