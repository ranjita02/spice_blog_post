import 'package:flutter_test/flutter_test.dart';
import 'package:spice_blog_22/auth/logic/validators.dart';

void main(){
group('Auth Validation Test', () { 
  test('.validateAsEmail() on null ', () {
    expect(null.validateAsEmail (),null);
    expect('ab1323c@gmail.com'.validateAsEmail (),'Not a valid email');
    expect(''.validateAsEmail (),'Not a valid email');
    expect('abc@gmail.com'.validateAsEmail (),null);

  });

}) ;
group('Log in Password Test', () { 
  
 test('.validateAsPassword() on null', ()
 {
 expect(null.validateAsPassword(), null);
expect('u235'.validateAsPassword(),'Password must be of atleast 8 characters');
expect('drdss2543dd'.validateAsPassword(), null);
 });
});

}