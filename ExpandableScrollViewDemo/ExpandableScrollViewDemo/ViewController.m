//
//  ViewController.m
//  ExpandableScrollViewDemo
//
//  Created by apt - intern on 12/08/15.
//  Copyright (c) 2015 apt - intern. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    constraint2originalValue = [NSMutableDictionary new];
    aView = YES;
    moreView = NO;
    
    for (NSLayoutConstraint *c in self.aConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
    }
    
    for (NSLayoutConstraint *c in self.bConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
        c.constant = 0.0f; // hide elements of "b" view first as we want to show the "a" view.
    }
    
    for (NSLayoutConstraint *c in self.moreConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
        c.constant = 0.0f; // hide elements from the expanded view in the first place
    }
    
    self.bButton.hidden = YES;
    self.bottomButton.hidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    // we evaluate the button at the bottom :)
    UIButton *bottomButton = moreView ? self.bottomButton : self.expandButton;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, MAX(bottomButton.frame.origin.y + bottomButton.frame.size.height + increasedSize, self.scrollView.contentSize.height));
    
    [self.view layoutIfNeeded];
}

-(IBAction)switchView:(UIButton *)sender {
    increasedSize = 0;
    aView = !aView;
    
    increasedSize += [self updateConstraints:self.aConstraints andIncreaseView:!aView];
    increasedSize += [self updateConstraints:self.bConstraints andIncreaseView:aView];
    self.bButton.hidden = !aView;
}

-(IBAction)expand:(UIButton *)sender {
    increasedSize = 0;
    moreView = !moreView;
    
    increasedSize += [self updateConstraints:self.moreConstraints andIncreaseView:moreView];
    self.bottomButton.hidden = !moreView;
    
    NSString *title = moreView ? @"Collapse" : @"Expand";
    [self.expandButton setTitle:title forState:UIControlStateNormal];
    [self.expandButton setTitle:title forState:UIControlStateSelected];
        
    // scroll up to the expandButton when the view is expanded.
    if (moreView) {
        [self.scrollView setContentOffset:
            CGPointMake(0, self.expandButton.frame.origin.y - 50) animated:YES];
    }
}

-(float) updateConstraints:(NSArray*) constraints andIncreaseView:(BOOL) isIncreased {
    float increase = 0;
    for (NSLayoutConstraint *c in constraints) {
        NSNumber *hash = [[NSNumber alloc] initWithInt:c.hash];
        float value = [[constraint2originalValue objectForKey:hash] floatValue];
        increase = isIncreased ? increase + value : increase - value;
        c.constant = isIncreased ? value : 0.0f;
    }
    return increase;
}


@end
