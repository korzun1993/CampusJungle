//
//  CCCitySelectionScreenViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCitySelectionController.h"
#import "CCCityCell.h"
#import "CCCitiesDataProvider.h"
#import "CCCity.h"
#import "CCAlertDefines.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCDefines.h"

@interface CCCitySelectionController ()<UIAlertViewDelegate>

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCCitySelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CCCitiesDataProvider *citiesProvider = [CCCitiesDataProvider new];
    citiesProvider.stateID = self.stateID;

    [self configTableWithProvider:citiesProvider cellClass:[CCCityCell class]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(addCity)];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.collegeScreenTransaction performWithObject:cellObject];
}

- (void)addCity
{
    UIAlertView *alertForCityInput = [[UIAlertView alloc] initWithTitle:@"New city" message:nil delegate:self cancelButtonTitle:CCAlertsButtons.cancelButton otherButtonTitles:CCAlertsButtons.okButton, nil];
    alertForCityInput.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *cityName = [alertForCityInput textFieldAtIndex:0];
    cityName.placeholder = @"City Name";
    [alertForCityInput show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [self.ioc_apiProvider createCity:[[alertView textFieldAtIndex:0] text] stateID:self.stateID SuccessHandler:^(NSDictionary *object) {
            
            [self.collegeScreenTransaction performWithObject:object[CCResponseKeys.item]];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dataSource.dataProvider loadItems];
}

@end
