//
//  QueryView.h
//  ParseNews
//
//  Created by HUAGE on 6/23/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "MyObject.h"
#import "DetailView.h"

@interface QueryView : PFQueryTableViewController
{
    __weak IBOutlet UIImageView *InfoBG;
    NSMutableArray *MyObjectArray;
    __weak IBOutlet UIButton *SaveAbout;
    __weak IBOutlet UITextView *Description;
    __weak IBOutlet UIBarButtonItem *Info;
    __weak IBOutlet UIBarButtonItem *Popular;
    __weak IBOutlet UIBarButtonItem *Home;
    __weak IBOutlet UILabel *Name;
    __weak IBOutlet UILabel *Points;
    __weak IBOutlet UIView *InfoView;
    __weak IBOutlet UIBarButtonItem *Friends;
}
//@property (strong, nonatomic) NSNumber *objectCount;
//@property (strong, nonatomic) NSNumber *objectCount2;
//@property (strong, nonatomic) NSNumber *objectCount3;

@end
