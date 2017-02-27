//
//  AddContentView.h
//  ParseNews
//
//  Created by HUAGE on 6/23/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface AddContentView : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     IBOutlet UIImageView* LoginImage;
    IBOutlet UIButton * Post;
    IBOutlet UITextView *PostText;
    UIImagePickerController *picker;
    UIImage *image;
    IBOutlet UIImageView *imageview;
    IBOutlet UIButton *Photo;
    BOOL CheckImage;
    IBOutlet UITextField*PostTitle;
    IBOutlet UIImageView *CroppingImage;
}

@end
