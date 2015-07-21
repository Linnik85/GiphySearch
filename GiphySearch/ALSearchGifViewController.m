//
//  ViewController.m
//  GiphySearch
//
//  Created by Линник Александр on 14.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALSearchGifViewController.h"
#import "ALGifItem.h"
#import "ALGifModels.h"
#import "SVProgressHUD.h"
#import "ALGifCollectionViewCell.h"
#import "ALServerManager.h"


@interface ALSearchGifViewController ()<ALGifModelsDelegate, UICollectionViewDataSource, UISearchBarDelegate>

@property(strong,nonatomic) ALGifModels* gifModels;

@property(strong,nonatomic) NSMutableArray* gifs;

@property(assign,nonatomic) BOOL isLoading;

@end

@implementation ALSearchGifViewController

static NSString * const reuseIdentifier = @"gifCell";


#pragma mark - Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.searchBarOutlet.delegate = self;
    
    self.gifs = [NSMutableArray array];
    
    self.gifModels = [[ALGifModels alloc]init];
    
    self.gifModels.delegate = self;
    
    self.collectionView.alwaysBounceVertical = YES;

    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


#pragma mark - ALGifModelsDelegate


-(void) searchGifForTermResponds:(NSMutableArray*) gifArray{
    
    [self.gifs addObjectsFromArray:gifArray];
    
    [SVProgressHUD dismiss];

    _isLoading = NO;

    [self.collectionView reloadData];
    
}

-(void) errorResponds:(NSString*) errorDescription{
    
    [SVProgressHUD dismiss];

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:errorDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    
    [alert show];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.gifs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ALGifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ALGifItem* gifItem = [self.gifs objectAtIndex:indexPath.row];
    
    [cell fillWhithGif:gifItem];
    
    return cell;
}


#pragma mark - UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    [self.gifs removeAllObjects];
    
    [self.collectionView reloadData];
    
    self.gifModels.offset = 0;
   
    [self.gifModels searchGifForTerm:searchBar.text limit:self.gifModels.limit offset:self.gifModels.offset];
    
    [SVProgressHUD show];

    
}


#pragma mark - ScrollView


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat contentHeight = scrollView.contentSize.height;
    
    if (offsetY > contentHeight - scrollView.frame.size.height)
    {
        if (!_isLoading) {
            
            _isLoading = YES;
            
            [self.gifModels searchGifForTerm:self.searchBarOutlet.text limit:self.gifModels.limit offset:(self.gifModels.offset+self.gifModels.limit)];
            
        }
    }
}


#pragma mark - Actions


- (IBAction)cleanAction:(id)sender {
    
    self.searchBarOutlet.text = nil;
    
    [self.gifs removeAllObjects];
    
    [self.collectionView reloadData];
    
    self.gifModels.offset = 0;
    
}


@end
