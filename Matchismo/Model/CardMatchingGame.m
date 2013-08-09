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

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
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
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.feedback = [NSString stringWithFormat:@"Matched %@ and %@ for %d points", card.contents, otherCard.contents, MATCH_BONUS];
                        otherCard.unPlayable = YES;
                        card.unPlayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.feedback = [NSString stringWithFormat:@"%@ and %@ don't mactch! %d point penalty",card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (NSUInteger)numberOfCardsToMatch
{
    if(_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}


@end
