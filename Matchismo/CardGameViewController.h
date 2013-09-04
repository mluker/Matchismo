//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Matt Luker on 8/2/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck; //abstract

@property (nonatomic) NSUInteger startingCardCount; //abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract
@end
