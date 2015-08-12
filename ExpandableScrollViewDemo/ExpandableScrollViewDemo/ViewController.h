//
//  ViewController.h
//  ExpandableScrollViewDemo
//
//  Created by apt - intern on 12/08/15.
//  Copyright (c) 2015 apt - intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableDictionary *constraint2originalValue;
    BOOL aView;
    BOOL moreView;
    float increasedSize;
}


@property (strong, retain) IBOutlet UIScrollView *scrollView;
@property (strong, retain) IBOutlet UIButton *bButton;
@property (strong, retain) IBOutlet UIButton *expandButton;
@property (strong, retain) IBOutlet UIButton *bottomButton;

@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *aConstraints;
@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *moreConstraints;
@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *bConstraints;

@end

