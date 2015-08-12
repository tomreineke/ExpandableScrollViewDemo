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
    
    // Do any additional setup after loading the view, typically from a nib.
    for (NSLayoutConstraint *c in self.aConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
    }
    
    for (NSLayoutConstraint *c in self.bConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
        c.constant = 0.0f; // hide elements of "b" view first as we want to show the "a" view.
    }
    
    for (UIControl *c in self.bControls) {
        c.hidden = YES; // UIControls from the "b" view need to be hidden this way, setting the constraint
        // is not sufficient. However we still need the height constraint on such UIControls to calculate
        // the height of the ScrollView correctly.
    }
    
    for (UIControl *c in self.aControls) {
        c.hidden = YES; // UIControls from the "a" view need to be hidden this way, setting the constraint
        // is not sufficient. However we still need the height constraint on such UIControls to calculate
        // the height of the ScrollView correctly.
    }
    
    for (NSLayoutConstraint *c in self.aMoreConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
        c.constant = 0.0f; // hide elements from the expanded view in the first place
    }
    
    for (NSLayoutConstraint *c in self.bMoreConstraints) {
        [constraint2originalValue setObject:[[NSNumber alloc] initWithFloat:c.constant] forKey:[[NSNumber alloc] initWithInt:c.hash]];
        c.constant = 0.0f; // hide elements from the expanded view in the first place
    }
 
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    // we evaluate the button at the bottom :)
    UIButton *bottomButton = moreView ? self.bottomButton : self.expandButton;
    
    NSLog(@"inc: %f, button: %f, content: %f", increasedSize, bottomButton.frame.origin.y, self.scrollView.contentSize.height);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, MAX(bottomButton.frame.origin.y + bottomButton.frame.size.height + increasedSize, self.scrollView.contentSize.height));
    
    [self.view layoutIfNeeded];
}

-(IBAction)switchView:(UIButton *)sender {
    increasedSize = 0;
    increasedSize += [self updateConstraints:self.aConstraints andIncreaseView:!aView];
    increasedSize += [self updateConstraints:self.bConstraints andIncreaseView:aView];
    if (moreView) {
        increasedSize += [self updateConstraints:self.aMoreConstraints andIncreaseView:!aView];
        increasedSize += [self updateConstraints:self.bMoreConstraints andIncreaseView:aView];
    }
    
    for (UIControl *c in self.aControls) {
        c.hidden = !moreView;
    }
    
    for (UIControl *c in self.bControls) {
        c.hidden = !moreView;
    }
    
    aView = !aView;
}

-(IBAction)expand:(UIButton *)sender {
    increasedSize = 0;
    if (aView) {
        increasedSize += [self updateConstraints:self.aMoreConstraints andIncreaseView:!moreView];
        for (UIControl *c in self.aControls) {
            c.hidden = !moreView;
        }
    } else {
        increasedSize += [self updateConstraints:self.bMoreConstraints andIncreaseView:!moreView];
        for (UIControl *c in self.bControls) {
            c.hidden = !moreView;
        }
    }
    
    NSString *title = moreView ? @"Expand" : @"Collapse";
    [self.expandButton setTitle:title forState:UIControlStateNormal];
    [self.expandButton setTitle:title forState:UIControlStateSelected];
        
    if (!moreView) { // when expanding the view scroll up until the more / less button is on top
        [self.scrollView setContentOffset:
            CGPointMake(0, self.expandButton.frame.origin.y) animated:YES];
    }
        
    moreView = !moreView;
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
