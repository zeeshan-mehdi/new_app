

class Agency{
  String nickname;
  String about;
  String contactPerson;
  String address;
  String telephone;
  String photoUrl;

  String website;
  String email;
  String password;
  String userType ="agency";



  Agency(this.nickname, this.about, this.contactPerson, this.address, this.photoUrl,
      this.telephone,this.website,this.email,this.password);

  toJson(){
    return {
      "name":nickname,
      "about":about,
      "contactPerson":contactPerson,
      "address":address,
      "telephone":telephone,
      "photoUrl":photoUrl,
      "website":website,
      "email":email,
      "password":password,
      "userType":userType
    };
  }


}


