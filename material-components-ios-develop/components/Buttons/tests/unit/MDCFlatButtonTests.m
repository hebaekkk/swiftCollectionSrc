// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <XCTest/XCTest.h>

#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"

@interface MDCFlatButtonsTests : XCTestCase
@end

@implementation MDCFlatButtonsTests

- (void)testDefaultElevationsForState {
  // Given
  MDCFlatButton *button = [MDCFlatButton appearance];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], MDCShadowElevationNone);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted], MDCShadowElevationNone);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], MDCShadowElevationNone);
  XCTAssertEqual([button elevationForState:UIControlStateSelected], MDCShadowElevationNone);
}

// TODO(#2782): Remove this test and replace it with default checks once UIAppearance is no longer
//              used for overriding MDCButton
- (void)testMDCFlatButtonDoesNotModifyInkColorInInit {
  // Given
  MDCButton *button = [[MDCButton alloc] init];
  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];

  // Then
  XCTAssertEqualObjects(flatButton.inkColor, button.inkColor);
}

@end
