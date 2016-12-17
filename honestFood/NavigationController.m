//
// Copyright (c) 2016 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NavigationController.h"

@implementation NavigationController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationBar.translucent = NO;
	self.navigationBar.barTintColor = kNavigationBarColor;
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage imageNamed:@"TransparentPixel.png"];
	self.navigationBar.tintColor = [UIColor whiteColor];
	self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

-(id)initWithRootViewNibName:(NSString *)nib
{
    Class class = NSClassFromString(nib);
    
    UIViewController *viewController = [[class alloc]initWithNibName:nib bundle:nil];
    
    self = [super initWithRootViewController:viewController];
    
    return self;
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return UIStatusBarStyleLightContent;
}

@end

