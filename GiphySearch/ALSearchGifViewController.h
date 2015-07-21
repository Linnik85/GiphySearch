//
//  ViewController.h
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALSearchGifViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarOutlet;

- (IBAction)cleanAction:(id)sender;

@end

