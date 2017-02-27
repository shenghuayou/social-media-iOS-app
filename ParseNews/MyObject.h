//
//  MyObject.h
//  ParseNews
//
//  Created by HUAGE on 6/24/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject

@property (nonatomic,strong) NSString * MyTitle;
@property (nonatomic,strong) NSString * MyUser;
@property (nonatomic,strong) NSString * MyContent;
@property (nonatomic,strong) NSData * MyURL;
@property (nonatomic,strong) NSDate * MyDate;

-(id) initMyTitle:(NSString *)MTitle initMyUser:(NSString *)MUser initMyConetent:(NSString*)MContent initMyURL:(NSData*)MURL;

@end
