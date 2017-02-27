//
//  MyObject.m
//  ParseNews
//
//  Created by HUAGE on 6/24/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject
@synthesize MyContent,MyTitle,MyURL,MyUser;

-(id) initMyTitle:(NSString *)MTitle initMyUser:(NSString *)MUser initMyConetent:(NSString*)MContent initMyURL:(NSData*)MURL
{
    self =[super init];
    if(self)
    {
        MyUser=MUser;
        MyURL=MURL;
        MyContent=MContent;
        MyTitle=MTitle;
    }
    return self;
}
@end
