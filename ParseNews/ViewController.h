//
//  ViewController.h
//  ParseNews
//
//  Created by HUAGE on 6/22/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ViewController : UIViewController
{
    IBOutlet UITextField* Username;
    IBOutlet UITextField* Password;
    IBOutlet UIButton* SignUp;
    IBOutlet UIButton* Login;
    IBOutlet UIImageView* LoginImage;
    
}


-(IBAction)LoginToMain:(id)sender;

@end

