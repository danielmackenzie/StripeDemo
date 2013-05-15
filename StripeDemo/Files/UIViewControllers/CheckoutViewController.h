//  CheckoutViewController.h

#import <UIKit/UIKit.h>
#import "STPView.h"

@interface CheckoutViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, STPViewDelegate> {
  BOOL                               _successfulTransaction;
  STPView                          * _stripeView;
  IBOutlet UIButton                * _saveButton;
  IBOutlet UITextField             * _nameTextField;
  IBOutlet UIBarButtonItem         * _backButton;
  IBOutlet UIActivityIndicatorView * _activityIndicator;
}

@property (nonatomic, retain) STPView * stripeView;

- (IBAction)dismissKeyboard:(UIButton *)aButton;
- (IBAction)saveButtonPressed:(UIButton *)aButton;
- (IBAction)backButtonPressed:(UIBarButtonItem *)aBarButtonItem;

@end