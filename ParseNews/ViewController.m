//
//  ViewController.m
//  ParseNews
//
//  Created by HUAGE on 6/22/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "ViewController.h"
NSString *globalName;
BOOL CheckComment;

@interface ViewController ()

@end

@implementation ViewController

- (void)showMainMenu {
    [self performSegueWithIdentifier:@"ShowMainMenu" sender:self];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setObject:globalName forKey:@"user"];
    [currentInstallation saveInBackground];
}

-(IBAction)LoginToMain:(id)sender
{

    NSString *name=Username.text;
    NSString *pass=Password.text;

    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"Username" equalTo:name];
    PFQuery *query2 = [PFQuery queryWithClassName:@"Users"];
    [query2 whereKey:@"Password" equalTo:pass];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if (objects.count==0) {
                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Username does not exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            }
            else
            {
                
                [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error2) {
                    if(!error2)
                    {
                        if(objects2.count>0)
                        {
                            [self performSelector:@selector(showMainMenu) withObject:nil afterDelay:0];
                            globalName=name;
                            [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"MyUser"];
                            [[NSUserDefaults standardUserDefaults]setObject:pass forKey:@"MyPass"];
                            
                        }
                        else
                        {
                            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Password does not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        }
                    }
                }];
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
        UIImage *ima= [UIImage imageNamed: @"BG.png"];
        [LoginImage setImage:ima];
        Login.frame=CGRectMake(130,430, 109, 50);
        SignUp.frame=CGRectMake( 130,500, 109, 40);
        Username.frame =CGRectMake( 65,277, 220, 50);
        Password.frame =CGRectMake( 65,351, 220, 50);
    }
    else if ([UIScreen mainScreen].bounds.size.height==736) {
        LoginImage.frame = CGRectMake( 0,0, 414, 736);
        UIImage *ima= [UIImage imageNamed: @"BG.png"];
        [LoginImage setImage:ima];
        Login.frame=CGRectMake(150,480, 109, 50);
        SignUp.frame=CGRectMake( 150,555, 109, 40);
        Username.frame =CGRectMake( 75,306, 220, 50);
        Password.frame =CGRectMake( 75,390, 220, 50);
    }
    [self.view sendSubviewToBack:LoginImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *u=[[NSUserDefaults standardUserDefaults] stringForKey:@"MyUser"];
    NSString *p=[[NSUserDefaults standardUserDefaults] stringForKey:@"MyPass"];
    Username.text=u;
    Password.text=p;
    // Do any additional setup after loading the view, typically from a nib.
    [self LoginScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
