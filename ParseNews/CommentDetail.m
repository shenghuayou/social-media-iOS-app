//
//  CommentDetail.m
//  ParseNews
//
//  Created by HUAGE on 6/26/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "CommentDetail.h"
extern NSString *globalName;

@interface CommentDetail ()

@end

@implementation CommentDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DetailCommentView.text=CObject.MyComment;
    DetailName.text=CObject.MyCommentUser;
    [self.navigationController setToolbarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCommentObject:(id)CommentObject
{
    CObject=CommentObject;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
