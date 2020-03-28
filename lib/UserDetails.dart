class UserDetails {
  String name,email,dob,phone,uid;

  void getDetails(name,email,dob){
    this.name = name;
    this.email = email;
    this.dob = dob;
    //this.phone = phone;
  }

  toJson(){
    return {
      'Name' : name,
      'Email' : email,
      'DOB' : dob,
      'Uid' : uid,
    };
  }

  toJsonGoogle(){
    return {
      'Name' : name,
      'Email' : email,
      'Uid' : uid,
    };
  }
  toJsonDOB(){
    return {
      'DOB' : dob,
    };
  }
}