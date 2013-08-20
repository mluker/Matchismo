//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Matt Luker on 8/19/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetGameViewController

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0 : 1.0;
        
        [cardButton setAttributedTitle:[self convertContentsToAttributedString:(SetCard *)card] forState:UIControlStateNormal];
        
        if(card.isFaceUp){
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        } else {
            cardButton.alpha = 1;
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
    }
    self.scoreLabel.text =  [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", self.game.feedback];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)deal
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.game.numberOfCardsToMatch = 3;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (NSAttributedString *)convertContentsToAttributedString:(SetCard *)card
{
        NSString *symbol = @"?";
        if ([card.symbol isEqualToString:@"oval"]) symbol = @"●";
        if ([card.symbol isEqualToString:@"triangle"]) symbol = @"▲";
        if ([card.symbol isEqualToString:@"square"]) symbol = @"■";
        
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        
        if ([card.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        if ([card.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        if ([card.color isEqualToString:@"purple"])
            [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        
        if ([card.shading isEqualToString:@"solid"])
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        if ([card.shading isEqualToString:@"striped"])
            [attributes addEntriesFromDictionary:@{
                     NSStrokeWidthAttributeName : @-5,
                     NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                 NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
             }];
        if ([card.shading isEqualToString:@"open"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        
        symbol = [symbol stringByPaddingToLength:card.number withString:symbol startingAtIndex:0];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
    return attrString;
}

@end
