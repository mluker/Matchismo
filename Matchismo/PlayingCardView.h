//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Matt Luker on 9/3/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
