//
//  QueryView.m
//  ParseNews
//
//  Created by HUAGE on 6/23/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "QueryView.h"
extern NSString *globalName;
int ToolBarState=0;
@interface QueryView ()

@end

@implementation QueryView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self= [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName=@"AllPost";
        self.pullToRefreshEnabled =YES;
        self.paginationEnabled=YES;
        self.objectsPerPage=10;
    }
    return self;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = tableView.visibleCells[indexPath.row];
//    UIViewController *imageVC = [UIViewController new];
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//    imageVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageVC.view.frame];
//    imageView.image = cell.imageView.image;
//    imageView.userInteractionEnabled=YES;
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouched:)];
//    [imageView addGestureRecognizer:tapGR];
//    [self presentViewController:imageVC animated:YES completion:nil];
//    
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetUserPoints];
    self.title=@"Home";
    InfoView.frame=CGRectMake(0, 0, 0, 0);
    InfoView.hidden=YES;
    Popular.width=[UIScreen mainScreen].bounds.size.width/4-30;
    Home.width=[UIScreen mainScreen].bounds.size.width/4;
    Info.width=[UIScreen mainScreen].bounds.size.width/4-50;
    Friends.width=[UIScreen mainScreen].bounds.size.width/4;
    
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [InfoView addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [Description resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)DeviceResize
{
    
}

-(IBAction)SaveData:(id)sender
{
    PFQuery *query=[PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"Username" equalTo:globalName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            [userStats setObject:Description.text forKey:@"AboutMe"];
            [userStats saveInBackground];
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have saved your description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void)GetUserPoints
{
    PFQuery *query=[PFQuery queryWithClassName:@"AllPost"];
    [query whereKey:@"PostUser" equalTo:globalName];
    NSInteger ArticlePoint=query.countObjects*5;
//    NSLog(@"globalname %@",globalName);
//    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error)
//    {
//        if (!error) {
//            self.objectCount = [NSNumber numberWithInt:count];
//            // The count request succeeded. Log the count
//            NSLog(@"Sean has played %d games", count);
//        } else {
//            NSLog(@"error");
//        }
//    }];
//    
//    NSLog(@"objectCount %@",self.objectCount);
//    
    
    PFQuery *query2=[PFQuery queryWithClassName:@"Comments"];
    [query2 whereKey:@"Name" equalTo:globalName];
    NSInteger CommentPoint=query2.countObjects;
    PFQuery *query3=[PFQuery queryWithClassName:@"View"];
    [query3 whereKey:@"ViewName" equalTo:globalName];
    NSInteger ViewPoint=query3.countObjects/5;
    NSInteger FinalPoint=ArticlePoint+CommentPoint+ViewPoint;
    NSString *MyPoint=[NSString stringWithFormat:@"%ld",(long)FinalPoint];
    PFQuery *query4=[PFQuery queryWithClassName:@"Users"];
    [query4 whereKey:@"Username" equalTo:globalName];
    [query4 getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            [userStats setObject:MyPoint forKey:@"Points"];
            [userStats saveInBackground];
        }
    }];
    
}

-(void)UserInformation
{
    
}

-(IBAction)ToolState0:(id)sender
{
   
    ToolBarState=0;
    [Home setTintColor:[UIColor grayColor]];
    [Popular setTintColor:[UIColor blueColor]];
    [Info setTintColor:[UIColor blueColor]];
    [Friends setTintColor:[UIColor blueColor]];
    self.title=@"Home";
     [self viewDidLoad];
}

-(IBAction)ToolState1:(id)sender
{
    ToolBarState=1;
    [Home setTintColor:[UIColor blueColor]];
    [Popular setTintColor:[UIColor grayColor]];
    [Info setTintColor:[UIColor blueColor]];
    [Friends setTintColor:[UIColor blueColor]];
     [self viewDidLoad];
    self.title=@"Popular";
    
}
-(IBAction)ToolState2:(id)sender
{
    ToolBarState=2;
    [Info setTintColor:[UIColor grayColor]];
    [Home setTintColor:[UIColor blueColor]];
    [Popular setTintColor:[UIColor blueColor]];
    [Friends setTintColor:[UIColor blueColor]];
    [self viewDidLoad];
    self.title=@"Info";
    PFQuery *query=[PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"Username" equalTo:globalName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            Description.text=userStats[@"AboutMe"];
        }
    }];
    
}

-(IBAction)ToolState3:(id)sender
{
    ToolBarState=3;
    [Home setTintColor:[UIColor blueColor]];
    [Popular setTintColor:[UIColor blueColor]];
    [Info setTintColor:[UIColor blueColor]];
    [Friends setTintColor:[UIColor grayColor]];
    [self viewDidLoad];
    self.title=@"Friends";
    
}

-(PFQuery*)queryForTable
{
    PFQuery *query;
    
    if (ToolBarState==0) {
        query= [PFQuery queryWithClassName:self.parseClassName];
    }
    else if (ToolBarState==1) {
        query= [PFQuery queryWithClassName:self.parseClassName];
        [query orderByDescending:@"PostView"];
    }
    else if(ToolBarState==2)
    {
        query= [PFQuery queryWithClassName:@"Users"];
        [query whereKey:@"Username" equalTo:globalName];
    }
    else if(ToolBarState==3)
    {
        query=[PFQuery queryWithClassName:@"Friends"];
        [query whereKey:@"Name" equalTo:globalName];
    }
    
    return query;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ToolBarState==0 || ToolBarState==1 ||ToolBarState==2) {
        return 145;
    }
    else
    {
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject*)object{
    static NSString *CellID;
    if (ToolBarState==0 || ToolBarState==1 ||ToolBarState==2)
    {
        CellID=@"Cell";
    }
    else
    {
        CellID=@"Cell2";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    // Configure the cell.
    
    if([UIScreen mainScreen].bounds.size.height==667)
    {
        
    }
    else if([UIScreen mainScreen].bounds.size.height==736)
    {
        
    }
    else
    {
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.detailTextLabel.font =[UIFont systemFontOfSize:11];
    }
    if (ToolBarState==0 || ToolBarState==1)
    {
        
        NSString *s = @"By:";
        s = [s stringByAppendingString:object[@"PostUser"]];
        s = [s stringByAppendingString:@"  "];
        PFQuery *queryView= [PFQuery queryWithClassName:@"View"];
        [queryView whereKey:@"ViewArticle" equalTo:object[@"PostTitle"]];
        NSInteger NumberOfView= queryView.countObjects;
        NSString *strFromInt = [NSString stringWithFormat:@"%ld",(long)NumberOfView];
        s = [s stringByAppendingString:@"view:"];
        s = [s stringByAppendingString:strFromInt];
        s = [s stringByAppendingString:@"  "];
        
        NSDate *updated = [object createdAt];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d, h:mm a"];
        NSString *d = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:updated]];
        s = [s stringByAppendingString:d];
        cell.textLabel.text=object[@"PostTitle"];
        cell.detailTextLabel.text=s;
        
        PFFile *thumbnail = object[@"PostFiles"];
        [thumbnail getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (data && !error) {
                UIImage *image = [UIImage imageWithData:data];
                cell.imageView.image=image;
            } else {
                //maybe set a default image here if there is none?
                cell.imageView.image=[UIImage imageNamed:@"NoImage.png"];
            }
        }];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        PFObject *MyViewObject=object;
        NSNumber *myNum = [NSNumber numberWithInteger:NumberOfView];
        MyViewObject[@"PostView"]=myNum;
        [MyViewObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
         {}];
    }
   
    else if (ToolBarState==2)
    {
       
        InfoView.hidden=NO;
        InfoView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [Name setText:object[@"Username"]];
        [Points setText:object[@"Points"]];
        Description.frame=CGRectMake(15, 155, [UIScreen mainScreen].bounds.size.width-35, 120);
        cell.hidden=YES;
    }
    
    else if(ToolBarState==3)
    {
        
        cell.textLabel.text=object[@"Friend"];
        cell.imageView.image=[UIImage imageNamed:@"NoImage.png"];
        InfoBG.image=[UIImage imageNamed:@"Blank.png"];
    }
    
    return cell;
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.    
    if([[segue identifier] isEqualToString:@"pushDetailView"])
    {
        NSIndexPath* index=[self.tableView indexPathForSelectedRow];
         PFObject *object1 = [self.objects objectAtIndex:index.row];
//        PFFile *file=object1[@"PostFiles"];
//        NSURL *url=[NSURL URLWithString:file.url];
        PFFile *thumbnail = object1[@"PostFiles"];
        NSData *imageData = [thumbnail getData];
        NSLog(@"Cell Number %ld",(long)index.row);
        NSString *name= object1[@"PostUser"];
         NSLog(@"%@",name);
        MyObject *ob=[[MyObject alloc]initMyTitle:object1[@"PostTitle"] initMyUser:object1[@"PostUser"] initMyConetent:object1[@"PostContent"] initMyURL:imageData];
        [self.navigationController setToolbarHidden:YES animated:YES];
        [[segue destinationViewController]getNewObject:ob];
    }
    else if ([[segue identifier] isEqualToString:@"MyAriticles"])
    {
        [segue destinationViewController];
    }
    else if ([[segue identifier] isEqualToString:@"MyComments"])
    {
        [segue destinationViewController];
    }
    else if ([[segue identifier] isEqualToString:@"PushToChat"])
    {
        [segue destinationViewController];
    }

    
    
    
}

@end
