

class Application{
  String userId;
  String userName;

  String jobId;

  String profilePicUrl;

  Application(this.userId, this.userName, this.jobId, this.profilePicUrl);


  toJson(){
    return {
      "userId":userId,
      "userName":userName,
      "jobId":jobId,
      "profilePicUrl":profilePicUrl
    };
  }

}