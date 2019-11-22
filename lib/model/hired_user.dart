

class HiredUser{
  String id;
  String nickname;
  String photoUrl;

  String jobId;

  String agencyId;

  HiredUser.empty();

  HiredUser(this.id, this.nickname, this.photoUrl, this.jobId, this.agencyId);

  toJson(){
    return {
      "id":id,
      "nickname":nickname,
      "photoUrl":photoUrl,
      "jobId":jobId,
      "agancyId":agencyId
    };
  }

  fromJson(user){
    this.id = user['id'];
    this.nickname = user['nickname'];
    this.photoUrl = user['photoUrl'];
    this.jobId = user['jobId'];
    this.agencyId = user['agencyId'];
  }

}