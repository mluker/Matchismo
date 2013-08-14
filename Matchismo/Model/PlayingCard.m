//
//  PlayingCard.m
//  Matchismo
//
//  Created by Matt Luker on 8/5/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;

    if (otherCards.count) {
        for (PlayingCard *card in otherCards) {           
            if([card.suit isEqualToString:self.suit]){
                score += 1;
            } else if (card.rank == self.rank) {
                score += 4;
            } else {
                score = 0;
                break;
            }
        }
    }
    
    return score;
}

- (NSString *) contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}
+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+ (NSUInteger)maxRank { return [self rankStrings].count-1; }
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
