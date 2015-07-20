//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Bartosz Stelmaszuk on 20/07/15.
//  Copyright (c) 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacterLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

/*-(void)viewDidload
{
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName: [UIColor greenColor], NSStrokeWidthAttributeName: @-3} ];
}*/

- (void) updateUI
{
    self.colorfulCharacterLabel.text = [NSString stringWithFormat:@"%lu colorful characters",(unsigned long)[[self charactersWitchAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters",(unsigned long)[[self charactersWitchAttribute:NSStrokeWidthAttributeName] length]];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWitchAttribute:(NSString *)attrbuteName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attrbuteName atIndex:index effectiveRange:&range];
        if (value){
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    
    return characters;
}

@end
