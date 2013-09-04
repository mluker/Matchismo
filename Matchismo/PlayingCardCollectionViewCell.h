//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Matt Luker on 9/4/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
