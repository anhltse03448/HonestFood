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

#import "UserDefaults.h"

@implementation UserDefaults

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)setObject:(id)value forKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)removeObjectForKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (id)objectForKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSString *)stringForKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSInteger)integerForKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (BOOL)boolForKey:(NSString *)key
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end

