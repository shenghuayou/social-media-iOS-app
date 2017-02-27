//
//  CommentObject.h
//  ParseNews
//
//  Created by HUAGE on 6/28/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentObject : NSObject
@property (nonatomic,strong) NSString * MyComment;
@property (nonatomic,strong) NSString * MyCommentUser;

-(id) initComment:(NSString *)MComment initCommentUser:(NSString *)MCommentUser;

@end
