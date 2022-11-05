package networking;

//this class holds user data. static class so you dont have to juggle an object around
static class User {
    //authorization token for pretty much every request
    public static var auth(default, null):String;

    //user name and discriminator for didsplay purposes
    public static var username(default, null):String;
    public static var discriminator(default, null):String;

    //TODO: add the rest
}