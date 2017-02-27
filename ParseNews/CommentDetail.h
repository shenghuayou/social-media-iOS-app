//
//  CommentDetail.h
//  ParseNews
//
//  Created by HUAGE on 6/26/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject.h"

@interface CommentDetail : UIViewController
{
    IBOutlet UILabel*DetailName;
    IBOutlet UITextView*DetailCommentView;
    CommentObject *CObject;
}
-(void)getCommentObject:(id)CommentObject;
@end
