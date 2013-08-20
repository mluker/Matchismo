//
//  SetCard.h
//  Matchismo
//
//  Created by Matt Luker on 8/19/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
