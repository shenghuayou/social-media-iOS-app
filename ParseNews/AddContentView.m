//
//  AddContentView.m
//  ParseNews
//
//  Created by HUAGE on 6/23/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "AddContentView.h"
extern NSString *globalName;
@interface AddContentView ()

@end

@implementation AddContentView

//-(void)SelectRangeOfImage
//{
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTemplateTap:)];
//    tapGesture.numberOfTapsRequired = 1;
//    tapGesture.cancelsTouchesInView = NO;
//    imageview.userInteractionEnabled = YES;
//    [imageview addGestureRecognizer:tapGesture];
//    
//
//}
//
//-(void)handleTemplateTap:(UIGestureRecognizer *)sender
//{
//    imageview.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
//}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // do whatever you have to do
    [PostText resignFirstResponder];
    [PostTitle resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [PostText resignFirstResponder];
    [PostTitle resignFirstResponder];
 
}
//
////Use same thing with touch move methods...
//- (void) touchesMoved:(NSSet *)touches withEvent: (UIEvent *)event
//{
//    NSLog(@"touchmove");
//
//    CGPoint pt = [[touches anyObject] locationInView:self.view];
//    [CroppingImage setCenter:pt];
//    NSLog(@"croping x %f",CroppingImage.frame.origin.x);
//    NSLog(@"croping y %f",CroppingImage.frame.origin.y);
//    
//}

-(IBAction)BackToMain:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *ima= [info objectForKey:UIImagePickerControllerOriginalImage];
//    float imgFactor1 = ima.size.width / [UIScreen mainScreen].bounds.size.width;
//    float imFactor2= ima.size.height/[UIScreen mainScreen].bounds.size.width;
//    float ScreenWidth=[UIScreen mainScreen].bounds.size.width;
//    float ScreenHeigh=[UIScreen mainScreen].bounds.size.height;
    image=ima;
    CGImageRef imageRef;
    if (ima.size.height>ima.size.width) {
        imageRef= CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, ima.size.width, ima.size.width));
    }
    else
    {
        imageRef= CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, ima.size.height, ima.size.height));
    }
    
    // or use the UIImage wherever you like
    image=[UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    NSLog(@"cropData1 %f",image.size.width);
    NSLog(@"cropData2 %f",image.size.height);
    [imageview setImage:image];
    if ([UIScreen mainScreen].bounds.size.height==667)
    {
        imageview.frame= CGRectMake( 161,489, 69, 69);
    }
    else if ([UIScreen mainScreen].bounds.size.height==736)
    {
        imageview.frame= CGRectMake( 167,549, 69, 69);
    }
    else
    {
        imageview.frame= CGRectMake(126,386,69,69);
    }
   // imageview.transform = CGAffineTransformMakeScale(-1, 1);
    CheckImage=true;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)AddPhoto:(id)sender
{
    picker =[[UIImagePickerController alloc]init];
    picker.delegate =self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
}

-(IBAction)UploadData:(id)sender
{
    PFObject *MyPostData= [PFObject objectWithClassName:@"AllPost"];
    if(CheckImage==true)
    {
        PFFile*photoFile = [PFFile fileWithData: UIImageJPEGRepresentation(image, 1.0)];
        MyPostData[@"PostFiles"]=photoFile;
    }
    else
    {
        UIImage * image2=[UIImage imageNamed:@"NoImage.png"];
        PFFile*photoFile2 = [PFFile fileWithData: UIImageJPEGRepresentation(image2, 1.0)];
        MyPostData[@"PostFiles"]=photoFile2;
    }
    MyPostData[@"PostContent"]=PostText.text;
    MyPostData[@"PostTitle"]=PostTitle.text;
    MyPostData[@"PostUser"]=globalName;
    [MyPostData saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error)
     {
         if (succeeded==YES) {
             UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have posted these contents" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             PostText.text=@"";
             
         }
     }];
    
 
    
    NSString*PushString=globalName;
    PushString=[PushString stringByAppendingString:@" Just Posted New Article"];
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"global" ];
    [push setMessage:PushString];
    [push sendPushInBackground];
}

-(void)LoginScreen
{
    if ([UIScreen mainScreen].bounds.size.height==667) {
        LoginImage.frame = CGRectMake( 0,0, 375, 667);
        UIImage *ima= [UIImage imageNamed: @"Blank.png"];
        [LoginImage setImage:ima];
        Post.frame=CGRectMake(280,475,50,34);
        Photo.frame=CGRectMake(28,475,77,34);
        imageview.frame= CGRectMake( 161,489, 69, 69);
    }
    else if ([UIScreen mainScreen].bounds.size.height==736) {
        LoginImage.frame = CGRectMake( 0,0, 414, 736);
        UIImage *ima= [UIImage imageNamed: @"Blank.png"];
        [LoginImage setImage:ima];
        Post.frame=CGRectMake(320,540,50,34);
        Photo.frame=CGRectMake(32,540,77,34);
        imageview.frame= CGRectMake( 167,549, 69, 69);
        
    }
    [self.view sendSubviewToBack:LoginImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CheckImage=false;
    [self LoginScreen];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}



- (void)tapGestureRecognizer:(UIGestureRecognizer *)recognizer {
    CGPoint tappedPoint = [recognizer locationInView:self.view];
    CGFloat xCoordinate = tappedPoint.x;
    CGFloat yCoordinate = tappedPoint.y;
    NSLog(@"Touch Using UITapGestureRecognizer x : %f y : %f", xCoordinate, yCoordinate);
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
