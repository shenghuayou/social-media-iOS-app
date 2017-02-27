//
//  RegisterViewController.m
//  ParseNews
//
//  Created by HUAGE on 6/22/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController


-(IBAction)RegisterAccount:(id)sender
{
    NSString *name=Username.text;
    NSString *pass=Password.text;
    
    PFObject *account= [PFObject objectWithClassName:@"Users"];
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"Username" equalTo:name];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            if (objects.count==0) {
                if ([name componentsSeparatedByString:@" "].count>1) {
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Failed" message:@"You should not have space in your username" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    account[@"Username"]=name;
                    account[@"Password"]=pass;
                    [account saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
                     {
                         if (succeeded==YES) {
                            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have registered account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                             [alert show];
                         }
                     }];
                }
            }
            else
            {
                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Username already exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }

        }
    }];
    
  
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // done button was pressed - dismiss keyboard
    [textField resignFirstResponder];
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [Username resignFirstResponder];
    [Password resignFirstResponder];
}

-(void)LoginScreen
{
    if ([UIScreen mainScreen].bounds.size.height==667) {
        LoginImage.frame = CGRectMake( 0,0, 375, 667);
        UIImage *ima= [UIImage imageNamed: @"Register.png"];
        [LoginImage setImage:ima];
        regi.frame=CGRectMake(110,430, 150, 52);
        Username.frame =CGRectMake( 65,277, 220, 50);
        Password.frame =CGRectMake( 65,351, 220, 50);
    }
    else if ([UIScreen mainScreen].bounds.size.height==736) {
        LoginImage.frame = CGRectMake( 0,0, 414, 736);
        UIImage *ima= [UIImage imageNamed: @"Register.png"];
        [LoginImage setImage:ima];
        regi.frame=CGRectMake(130,480, 150, 52);
        Username.frame =CGRectMake( 75,306, 220, 50);
        Password.frame =CGRectMake( 75,390, 220, 50);
    }
    [self.view sendSubviewToBack:LoginImage];
}


-(IBAction)BackToLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoginScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
