class TACmodel {
  
  String phone;
  

  

  TACmodel({
    this.phone = '',
   
    
  });
 

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      
    };
  }

  static TACmodel fromJson(Map<String, dynamic> json) => TACmodel(
        phone: json['phone'],
        
      );
}

