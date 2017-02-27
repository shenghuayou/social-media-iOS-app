//
//  DetailView.h
//  ParseNews
//
//  Created by HUAGE on 6/24/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyObject.h"
#import <Parse/Parse.h>


@interface DetailView : UIViewController
{
    
    IBOutlet UILabel* DetailTitle;
    IBOutlet UIImageView* DetailImageView;
    IBOutlet UITextView* DetailContent;
    MyObject *GetObject;
    UIScrollView *MyScrollView;
    __weak IBOutlet UIBarButtonItem *Comments;
}


#pragma mark -
#pragma mark Methods
-(void)getNewObject:(id)NewObject;
@end

