//
//  SCImageViewWithIndicator.h
//  SmartChat
//
//  Created by Yuriy Nezhura on 25.03.15.
//  Copyright (c) 2015 Yuriy Nezhura. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ALImageViewWithIndicator : UIImageView


@property(nonatomic,assign) BOOL isRounded;

-(void) setProgress:(long long) totalBytesRead totalBytesExpectedToRead:(long long) totalBytesExpectedToRead;

-(void) endProgress;

@end
