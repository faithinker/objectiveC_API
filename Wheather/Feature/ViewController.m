//
//  ViewController.m
//  Wheather
//
//  Created by jhkim on 2022/10/28.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (retain) UITableView * tableView;

@property (retain) NSMutableArray<Crypto*> * array;

@end

@implementation ViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID" forIndexPath:indexPath];
    
    [cell setup: [_array objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [_array objectAtIndex:indexPath.row].askPrice;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    [self fetchData];
    
    [self setupTableView];
    
}


-(void) fetchData {
    _array = [NSMutableArray new];
    
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://api2.binance.com/api/v3/ticker/24hr"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError * err;
        
        NSArray * arrayOFJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        for (NSDictionary * dictionary in arrayOFJSON) {
            NSLog(@"%@", dictionary[@"askPrice"]);
            
            Crypto * object = [[Crypto alloc] init:dictionary[@"askPrice"]];
            
            [self->_array addObject:object];
            

        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableView reloadData];
        });
        
    }] resume];
}

-(void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    [_tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [_tableView registerClass:CustomCell.class forCellReuseIdentifier:@"CELLID"];
}


@end



// =============================================

@interface Crypto()

@end

@implementation Crypto

-(id)init: (NSString *) initPrice {
    self = [super init];
    if (self) {
        _askPrice = initPrice;
    }
    return  self;
    
}

@end

// =============================================


@implementation CustomCell

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setup: (Crypto * )initWithData {
    self.textLabel.text = initWithData.askPrice;
}

@end


