//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Matt Luker on 8/6/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic, readonly) NSString *feedback;
@property (nonatomic) NSUInteger numberOfCardsToMatch;

@end