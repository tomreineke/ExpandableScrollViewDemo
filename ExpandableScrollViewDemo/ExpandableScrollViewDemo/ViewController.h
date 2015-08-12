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
@property (strong, retain) IBOutlet UIButton *expandButton;
@property (strong, retain) IBOutlet UIButton *bottomButton;

@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *aConstraints;
@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *aMoreConstraints;
@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *bConstraints;
@property (strong, retain) IBOutletCollection(NSLayoutConstraint) NSArray *bMoreConstraints;

@property (strong, retain) IBOutletCollection(UIControl) NSArray *aControls;
@property (strong, retain) IBOutletCollection(UIControl) NSArray *bControls;

@end

