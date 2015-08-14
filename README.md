# ExpandableScrollViewDemo

### About
A sample project that shows how to create a collapsable UIScrollView. It only has a button that switches between two views A and B, each having some input elements, and a button to expand these views to display one more details. 

### General idea
The basic idea behind this is the following:
+ in the storyboard, link the NSLayoutConstraints for the input elements to different IBOutletCollections of the UIViewController
+ store the initial constraint values (as set up in the storyboard) in a NSMutableDictionary that maps the hash values of a constraint to its value
+ when clicking either the "switch view" or the "more" button, iterate over the IBOutletCollections of constraints and set their values to either their original value or to zero
+ in the callback method viewDidLayoutSubviews, adjust the contentSize of the UIScrollView in such a way that the bottommost element of the view is correctly displayed
