package networking;

import networking.APICall.Response;
import networking.APICall.HttpResponse;
import networking.APICall.APICall;

//this class holds user data. static class so you dont have to juggle an object around
class User {
    //authorization token for pretty much every request
    public static var auth(default, null):String = "";

    //user name and discriminator for didsplay purposes
    public static var username(default, null):String = "";
    public static var discriminator(default, null):String = "";

    //TODO: add the rest

    //Logs in the user and sets the auth token if successful.
    //Return values:
    //Response.Success("") - Succeeded and auth token is set.
    //Response.Fail("Already Done") - User already logged in. Call User.logout to log out.
    //Response.Fail("Incorrect") - Incorrect email or password.
    //Response.Fail("Captcha") - Call this function again with a captcha key
    //Response.Fail("{ticket}") - 2FA required. Call User.2fa with the code and the ticket
    //Response.Fail("Unexpected Error") - An uncaught and unexpected error occured.
    //TODO: Find out if there are other possible errors.
    //TODO: Find response code for incorrect login.
    public static function login(email:String, password:String, captcha:String):Response {
        if (auth != "") {
            return Response.Fail("Already Done");
        }
        var resp:HttpResponse = APICall.call('auth/login', "POST", null, null, {"login":email, "password":password, "captcha_key": captcha});
        return Response.Success("");
    }
}