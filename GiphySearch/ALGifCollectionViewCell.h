//
//  ALGifCollectionViewCell.h
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "ALImageViewWithIndicator.h"
#import "ALGifItem.h"


@interface ALGifCollectionViewCell : UICollectionViewCell <ALGifItemDelegate>

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageOutlet;

@property (weak, nonatomic) IBOutlet ALImageViewWithIndicator *progressLoadOutlet;

-(void) fillWhithGif: (ALGifItem*) gifItem;


@end
