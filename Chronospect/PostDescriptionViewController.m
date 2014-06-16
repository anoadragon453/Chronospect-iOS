//
//  PostDescriptionViewController.m
//  
//
//  Created by Andrew Morgan on 6/3/14.
//
//

#import "PostDescriptionViewController.h"

@interface PostDescriptionViewController ()

@end

@implementation PostDescriptionViewController
@synthesize descriptionTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    descriptionTextView.text = @"Enter an event description here...";
    descriptionTextView.textColor = [UIColor lightGrayColor];
    descriptionTextView.delegate = self;
    
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    descriptionTextView.text = @"";
    descriptionTextView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(descriptionTextView.text.length == 0){
        descriptionTextView.textColor = [UIColor lightGrayColor];
        descriptionTextView.text = @"Enter an event description here...";
        [descriptionTextView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
