//
//  CommentView.m
//  ParseNews
//
//  Created by HUAGE on 6/26/15.
//  Copyright (c) 2015 youshenghua. All rights reserved.
//

#import "CommentView.h"
extern MyObject *GlobalObject;
extern NSString *globalName;
@interface CommentView ()

@end

@implementation CommentView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self= [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName=@"Comments";
        self.pullToRefreshEnabled =YES;
        self.paginationEnabled=YES;
        self.objectsPerPage=10;
    }
    return self;
}

-(IBAction)BackToArticleAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(PFQuery*)queryForTable
{
    PFQuery *query= [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"Article" equalTo:GlobalObject.MyTitle];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

//Declare a delegate, assign your textField to the delegate and then include these methods


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject*)object2{
    static NSString *CellID=@"CommentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.detailTextLabel.text=object2[@"Comment"];
    NSString *NameTime=object2[@"Name"];
    NSDate *updated = [object2 createdAt];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, h:mm a"];
    NSString *d = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:updated]];
    NameTime=[NameTime stringByAppendingString:@"  "];
    NameTime=[NameTime stringByAppendingString:d];
    cell.textLabel.text=NameTime;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"GoDetailComment"])
    {
        NSIndexPath* index=[self.tableView indexPathForSelectedRow];
        PFObject *object3 = [self.objects objectAtIndex:index.row];
        NSString *Detail= object3[@"Comment"];
        NSString *DetailPost=object3[@"Name"];
        CommentObject *CommentDetail=[[CommentObject alloc]initComment:Detail initCommentUser:DetailPost];
        [[segue destinationViewController]getCommentObject:CommentDetail];
    }
}

@end
