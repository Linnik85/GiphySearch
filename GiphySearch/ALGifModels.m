//
//  ALGifModels.m
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALGifModels.h"
#import "ALServerManager.h"
#import "ALGifItem.h"

@interface ALGifModels ()


@end


@implementation ALGifModels


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.serverManager = [ALServerManager sharedManager];
        
        self.limit = 25;
        
        self.offset = 0;

    }
    return self;
}

- (void) searchGifForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset{
    
    
    NSDictionary* params = @{@"limit": @(limit), @"offset": @(offset), @"q": term};
    
    [self.serverManager searchGifWithParams:params
                                  OnSuccess:^(NSDictionary *respondsValue) {
                                    
                                      if ([respondsValue objectForKey:@"pagination"]) {
                                          
                                          NSDictionary* paginationDict = [respondsValue objectForKey:@"pagination"];
                                          
                                          if ([paginationDict objectForKey:@"offset"]) {
                                              
                                              self.offset =[[paginationDict objectForKey:@"offset"] integerValue];
                                          }
                                          
                                          
                                      }
                                      
                                      if ([respondsValue objectForKey:@"data"]&&[[respondsValue objectForKey:@"data"]count]>0) {
                                          
                                          NSMutableArray* gifDictArray = [respondsValue objectForKey:@"data"];
                                          
                                          NSMutableArray* gifArray = [NSMutableArray array];
                                          
                                          for (NSDictionary* gifDict in gifDictArray) {
                                              
                                              if ([gifDict objectForKey:@"images"]) {
                                                  
                                                  NSDictionary* imagesDict = [gifDict objectForKey:@"images"];
                                                  
                                                  if ([imagesDict objectForKey:@"original"]) {
                                                      
                                                      NSDictionary* originalDict = [imagesDict objectForKey:@"original"];
                                                      
                                                      if ([originalDict objectForKey:@"url"]) {
                                                          
                                                          ALGifItem* gifItem = [[ALGifItem alloc]initWithServerResponse:originalDict];
                                                          
                                                          [gifItem loadImageByUrl:gifItem.url];
                                                          
                                                          [gifArray addObject:gifItem];
                                                      }
                                                  }
                                              }
                                              
                                          }
                                          
                                          if ([self.delegate respondsToSelector:@selector(searchGifForTermResponds:)]) {
                                              
                                              [self.delegate searchGifForTermResponds:gifArray];
                                          }
                                      } else {
                                          
                                          if ([self.delegate respondsToSelector:@selector(errorResponds:)]) {
                                              
                                              [self.delegate errorResponds:[NSString stringWithFormat:@"Gif with that name is not found"]
                                               ];
                                              
                                          }

                                      }
                                      
                                      
                                  }
                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                      
                                      if ([self.delegate respondsToSelector:@selector(errorResponds:)]) {
                                          
                                          [self.delegate errorResponds:[NSString stringWithFormat:@"ERROR: %@", error.localizedDescription]];
                                          
                                      }
                                      
                                  }];
    
    
}


@end
