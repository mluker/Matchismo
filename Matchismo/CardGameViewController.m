//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matt Luker on 8/2/13.
//  Copyright (c) 2013 Matt Luker. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitch;


@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[PlayingCardDeck alloc] init]];
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
        Card  *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];        
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? .3 : 1.0;
        
        if(card.isFaceUp){
            [cardButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", card.contents]] forState:UIControlStateNormal];
        } else {

            [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
        }
    }
    self.scoreLabel.text =  [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", self.game.feedback];
    self.gameModeSwitch.enabled = NO;
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
    self.gameModeSwitch.enabled = YES;
    
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)gameModeChange {
    self.game.numberOfCardsToMatch = self.gameModeSwitch.on ? 3 : 2;
}

@end
