//
//  ALGifModels.h
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALServerManager;

@protocol ALGifModelsDelegate <NSObject>

-(void) searchGifForTermResponds:(NSMutableArray*) gifArray;

-(void) errorResponds:(NSString*) errorDescription;


@end


@interface ALGifModels : NSObject

@property (nonatomic, weak) id < ALGifModelsDelegate > delegate;

@property(assign,nonatomic) NSUInteger limit;

@property(assign, nonatomic) NSInteger offset;

@property(strong, nonatomic) ALServerManager* serverManager;

- (void) searchGifForTerm:(NSString *) term limit:(NSUInteger) limit offset:(NSInteger) offset;

@end
