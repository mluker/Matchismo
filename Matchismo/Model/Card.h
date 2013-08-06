//
//  Card.h
//  Matchismo
//
//  Created by Matt Luker on 8/5/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString * contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unPlayable;

- (int)match:(NSArray *)otherCards;
@end
