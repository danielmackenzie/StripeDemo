//  CheckoutViewController.m

#import "CheckoutViewController.h"
#import "Product.h"
#import "AppDelegate.h"

@implementation CheckoutViewController

@synthesize stripeView = _stripeView;

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil; {
  if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])){
    
  }
  return self;
}

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  _stripeView = [[STPView alloc] initWithFrame:CGRectMake(15.0f, 65.0f, 290.0f, 55.0f) andKey:@"pk_test_RbUuIcOBW8M2RRkhGHIf1wGt"];
  _stripeView.delegate = self;
  [self.view addSubview:_stripeView];
}

- (BOOL)shouldAutorotate; {
  if(self.interfaceOrientation != UIInterfaceOrientationPortrait){
    _stripeView.frame = CGRectMake(95.0f, 65.0f, 290.0f, 55.0f);
  }
  else{
    _stripeView.frame = CGRectMake(15.0f, 65.0f, 290.0f, 55.0f);
  }
  return YES;
}

#pragma mark - Methods

- (void)handleError:(NSError *)aError; {
  UIAlertView * message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:[aError localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
  [message show];
}

- (void)handleToken:(STPToken *)aToken; {
  NSLog(@"Received token %@", aToken.tokenId);
  
  AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
  int sum = 0;
  
  for(int i = 0; i < appDelegate.cartArray.count; i++){
    sum += (int)(((Product *)[appDelegate.cartArray objectAtIndex:i]).price * 100);
  }
  _successfulTransaction = NO;
  
  NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:3000/transaction/handleStripeTransaction"]];
  request.HTTPMethod = @"POST";
  NSString * body     = [NSString stringWithFormat:@"stripeToken=%@&amount=%d&name=%@", aToken.tokenId, sum, _nameTextField.text];
  request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
                           [_activityIndicator stopAnimating];
                           
                           if (error) {
                             NSLog(@"ERROR! %@ Data: %@", error, data);
                             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"The transaction encountered an error!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                             [alertView show];
                           }
                           else{
                             _successfulTransaction = YES;
                             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The transaction was successful!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                             [alertView show];
                           }
                         }];
}

- (IBAction)dismissKeyboard:(UIButton *)aButton; {
  if([_nameTextField isEditing]){
    [_nameTextField endEditing:YES];
  }
  else{
    [_stripeView endEditing:YES];
  }
}

- (IBAction)saveButtonPressed:(UIButton *)aButton; {
  [_activityIndicator startAnimating];
  [self dismissKeyboard:nil];
  [self.stripeView createToken:^(STPToken * token, NSError * error) {
    if(error){
      // Handle error
      [self handleError:error];
      [_activityIndicator stopAnimating];
    }
    else{
      // Send off token to your server
      [self handleToken:token];
    }
  }];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)aBarButtonItem; {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - STPViewDelegate Methods

- (void)stripeView:(STPView *)view withCard:(PKCard *)card isValid:(BOOL)valid; {
  
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex; {
  if(_successfulTransaction){
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    for(int i = 0; i < appDelegate.cartArray.count; i++){
      Product * product = [appDelegate.cartArray objectAtIndex:i];
      product.inCart = NO;
    }
    [appDelegate.cartArray removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
  if(textField.text.length == 1 && string.length == 0){
    _saveButton.alpha = 0.5;
    _saveButton.enabled = NO;
  }
  else if((string.length + textField.text.length) > 0){
    _saveButton.alpha = 1;
    _saveButton.enabled = YES;
  }
  else{
    _saveButton.alpha = 0.5;
    _saveButton.enabled = NO;
  }
  return YES;
}

@end