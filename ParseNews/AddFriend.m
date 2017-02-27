//
//  AddFriend.m
//  ParseNews
//
//  Created by HUAGE on 7/1/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "AddFriend.h"
extern NSString *globalName;

@interface AddFriend ()

@end

@implementation AddFriend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)CancalFriend:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)AddMyFriend:(id)sender
{
    
    PFQuery *query=[PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"Username" equalTo:FriendName.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if(objects.count>0)
            {
                PFQuery *query2=[PFQuery queryWithClassName:@"Friends"];
                [query2 whereKey:@"Name" equalTo:globalName];
                [query2 whereKey:@"Friend" equalTo:FriendName.text];
                [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error)
                 {
                     if(objects2.count==0)
                     {
                         PFObject *obj2=[PFObject objectWithClassName:@"Friends"];
                         obj2[@"Name"]=FriendName.text;
                         obj2[@"Friend"]=globalName;
                         [obj2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error){
                         }];
                         
                         PFObject *obj=[PFObject objectWithClassName:@"Friends"];
                         obj[@"Name"]=globalName;
                         obj[@"Friend"]=FriendName.text;
                         [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
                          {
                              if (succeeded==YES) {
                                  UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Success" message:@"You Just Added 1 Friend" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                  [alert show];
                              }
                          }];
                      }
                     else
                     {
                         UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Failed" message:@"You Already have this Friend" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     }
                     
                 }];
                
            
            }
            else
            {
                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Username does no exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }];

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
