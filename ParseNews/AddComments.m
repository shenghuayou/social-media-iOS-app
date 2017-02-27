//
//  AddComments.m
//  ParseNews
//
//  Created by HUAGE on 6/26/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "AddComments.h"
extern MyObject *GlobalObject;
extern NSString *globalName;
@interface AddComments ()

@end

@implementation AddComments

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)UploadData:(id)sender
{
    
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"user" equalTo:GlobalObject.MyUser];
    NSString*PushString=@"You Get a Comment in Your Article <";
    PushString=[PushString stringByAppendingString:GlobalObject.MyTitle];
    PushString=[PushString stringByAppendingString:@">"];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    [push setMessage:PushString];
    [push sendPushInBackground];
    
    PFObject *AddComment= [PFObject objectWithClassName:@"Comments"];
    AddComment[@"Article"]=GlobalObject.MyTitle;
    AddComment[@"Comment"]=MyComment.text;
    AddComment[@"Name"]=globalName;
    [AddComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
     {
         if (succeeded==YES) {
            [self dismissViewControllerAnimated:YES completion:nil];
         }
     }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // do whatever you have to do
    [MyComment resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [MyComment resignFirstResponder];
    
}

-(IBAction)BackToComments:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
