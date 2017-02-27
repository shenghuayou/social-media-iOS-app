//
//  CommentObject.m
//  ParseNews
//
//  Created by HUAGE on 6/28/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "CommentObject.h"

@implementation CommentObject
@synthesize MyComment,MyCommentUser;

-(id) initComment:(NSString *)MComment initCommentUser:(NSString *)MCommentUser
{
    self =[super init];
    if(self)
    {
        MyCommentUser=MCommentUser;
        MyComment=MComment;
        
    }
    return self;
}

@end
