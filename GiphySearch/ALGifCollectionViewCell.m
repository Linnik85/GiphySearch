//
//  ALGifCollectionViewCell.m
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALGifCollectionViewCell.h"
#import "FLAnimatedImage/FLAnimatedImageView.h"
#import "FLAnimatedImage/FLAnimatedImage.h"
#import "ALImageViewWithIndicator.h"


@interface ALGifCollectionViewCell ()

@property(strong,nonatomic)ALGifItem* gifItem;

@end


@implementation ALGifCollectionViewCell


#pragma mark - Invite Methode


-(void) fillWhithGif: (ALGifItem*) gifItem{
    
    self.gifItem = gifItem;
    
    self.gifItem.delegate = self;
    
    if (gifItem.imageData.length>0) {
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifItem.imageData];
        
        self.imageOutlet.animatedImage = image;
    }
    
}


#pragma mark - ALGifItemDelegate


- (void) progtessLoadImageTotalBytesRead:(long long) totalBytesRead totalBytesExpectedToRead:(long long) totalBytesExpectedToRead{
    
    [self.progressLoadOutlet setProgress:totalBytesRead totalBytesExpectedToRead:totalBytesExpectedToRead];
}


-(void) getImagResponds:(NSData*) imageData{
    
    [self.progressLoadOutlet endProgress];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    self.imageOutlet.animatedImage = image;
}


-(void) errorResponds:(NSString*) errorDescription{
    
    [self.progressLoadOutlet endProgress];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:errorDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    
    [alert show];
}


#pragma mark - Lifecycle


-(void)prepareForReuse{
    
    self.imageOutlet.animatedImage = nil;
    
    self.gifItem.delegate = nil;
    
    [self.progressLoadOutlet endProgress];
}

@end
