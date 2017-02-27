//
//  DetailView.m
//  ParseNews
//
//  Created by HUAGE on 6/24/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "DetailView.h"
int ViewState;
MyObject *GlobalObject;
extern NSString *globalName;
@interface DetailView ()

@end


@implementation DetailView



- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetLabels];
    [self SetLayout];
    [self CustomerView];
    GlobalObject=GetObject;
    ViewState=0;
   // [self.navigationController setToolbarHidden:YES animated:NO];
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

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"View will Disappear");
    if (ViewState==0) {
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
    else if (ViewState==1)
    {
        ViewState=0;
    }
    
}


-(IBAction)hideTool:(id)sender
{
    ViewState=1;
    NSLog(@"Hide toll");
}
#pragma mark -
#pragma mark Methods

-(void)getNewObject:(id)NewObject
{
    GetObject=NewObject;
}

-(void)CustomerView
{
    PFObject *MyView= [PFObject objectWithClassName:@"View"];
    PFQuery *query= [PFQuery queryWithClassName:@"View"];
    [query whereKey:@"ViewName" equalTo:globalName];
    [query whereKey:@"ViewArticle" equalTo:GetObject.MyTitle];
 
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count==0)
            {
                MyView[@"ViewName"]=globalName;
                MyView[@"ViewArticle"]=GetObject.MyTitle;
                [MyView saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
                 {}];
            }
        }
    }];
    
    
    
}

-(void)SetLayout
{
    NSString *myString=GetObject.MyContent;
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
    
    // Assuming you have some NSString `myString`.
    NSUInteger matches = [regex numberOfMatchesInString:myString options:0
                                                  range:NSMakeRange(0, [myString length])];
    

    unsigned long int line;
    line=(GetObject.MyContent.length/25)+1;
    if (matches<GetObject.MyContent.length/4) {
      line=(GetObject.MyContent.length/14)+1;
    }
   // NSLog(@"Match %lu",(unsigned long)matches);
    //NSLog(@"line Number %lu",line);
    //NSLog(@"GetObject.MyContent.length %lu",(unsigned long)GetObject.MyContent.length);
    if ([UIScreen mainScreen].bounds.size.height==667)
    {
        DetailImageView.frame=CGRectMake(26, 150, 325,325);
        DetailContent.frame=CGRectMake(40, 485, 300, 33*line);
        DetailTitle.frame=CGRectMake(40, 87, 300, 60);
        MyScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, -80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+80)];
    }
    else if ([UIScreen mainScreen].bounds.size.height==736)
    {
        DetailTitle.frame=CGRectMake(58, 107, 300, 60);
        DetailContent.frame=CGRectMake(58, 555, 300,33*line);
         MyScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, -100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100)];
    }
    else
    {
      
        DetailContent.frame=CGRectMake(10, 429, 300,33*line);
        MyScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+60)];
    }
   
    int TopSize=DetailTitle.frame.size.height+DetailImageView.frame.size.height;
     MyScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,33*line+TopSize);
    [MyScrollView addSubview:DetailContent];
    [MyScrollView addSubview:DetailTitle];
    [MyScrollView addSubview:DetailImageView];
    [self.view addSubview:MyScrollView];
}
-(void)SetLabels
{
    
 
    DetailTitle.text=GetObject.MyTitle;
    DetailContent.text=GetObject.MyContent;
//    NSData *d=[NSData dataWithContentsOfURL : GetObject.MyURL];
//    UIImage *img= [UIImage imageWithData: d];
//    DetailImageView.image=img;
    UIImage *image = [UIImage imageWithData:GetObject.MyURL];
    if (image!=NULL) {
        NSString *size= [NSString stringWithFormat:@"%f", image.size.height];
        NSLog(@"%@",size);
        DetailImageView.image=image;
        DetailImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else
    {
        DetailImageView.image=[UIImage imageNamed: @"NoImage.png"];
    }
    
}



@end
