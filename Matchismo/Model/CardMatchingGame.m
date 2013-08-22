//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matt Luker on 8/6/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic)NSMutableArray *cards;
@property (nonatomic)NSUInteger score;
@property (nonatomic)NSString *feedback;


@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    self.feedback = @"Welcome to Matchismo!";
    
    if(self){
        for(int i =0; i < cardCount; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isUnplayable){
        if(!card.isFaceUp){
            self.feedback = [NSString stringWithFormat:@"You Flipped the %@", card.contents];
            NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
            for(Card *flippedCard in self.cards){
                if(flippedCard.isFaceUp && !flippedCard.isUnplayable){
                    [flippedCards addObject:flippedCard];
                }
            }
            if([flippedCards count] < self.numberOfCardsToMatch - 1){
                
            } else {            
                int matchScore = [card match:flippedCards];
                if(matchScore){
                    card.unPlayable = YES;
                    for(Card *card in flippedCards){
                        card.unPlayable = YES;                       
                        self.feedback = [self.feedback stringByAppendingFormat:@"%@", card.contents];
                    }
                    self.feedback = [self.feedback stringByAppendingFormat:@" - Points %d", MATCH_BONUS];
                    self.score += matchScore * MATCH_BONUS;
                } else {
                    for(Card *card in flippedCards){
                        card.faceUp = NO;
                    }                    
                    self.score -= MISMATCH_PENALTY;
                    self.feedback = [self.feedback stringByAppendingFormat:@"%@  - Penalty Points %d", card.contents, MISMATCH_PENALTY];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (NSUInteger)numberOfCardsToMatch
{
    if(!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}


@end
