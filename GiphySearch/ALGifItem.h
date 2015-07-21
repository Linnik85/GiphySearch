//
//  ALGifItem.h
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ALGifItemDelegate <NSObject>

-(void) progtessLoadImageTotalBytesRead:(long long) totalBytesRead totalBytesExpectedToRead:(long long) totalBytesExpectedToRead;

-(void) getImagResponds:(NSData*) imageData;

-(void) errorResponds:(NSString*) errorDescription;


@end


@interface ALGifItem : NSObject

@property (strong, nonatomic) NSString * url;

@property (strong,nonatomic) NSData* imageData;

@property (nonatomic, weak) id < ALGifItemDelegate > delegate;


- (id) initWithServerResponse:(NSDictionary*) responseObject;

- (void) loadImageByUrl:(NSString*)url;

@end
