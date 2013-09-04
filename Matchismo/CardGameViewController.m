//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matt Luker on 8/2/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;

@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@end

@implementation CardGameViewController

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.startingCardCount
                                                        usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck { return nil;} // abstract

-(void)updateUI
{
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    self.scoreLabel.text =  [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", self.game.feedback];
}

- (IBAction)deal
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath)
    {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
    }
}

@end
