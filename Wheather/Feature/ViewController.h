//
//  ViewController.h
//  Wheather
//
//  Created by jhkim on 2022/10/28.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

// =============================================

@interface Crypto : NSObject

-(id)init: (NSString * )initPrice;

@property (nonatomic, retain) NSString * askPrice;

@end

@interface CustomCell : UITableViewCell

-(void)setup: (Crypto * )initWithData;

@end

