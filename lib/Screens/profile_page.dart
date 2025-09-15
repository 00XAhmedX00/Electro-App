import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            
            Container(
              width: double.infinity,
              height: height * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF9C27B0),
                    Color(0xFFE040FB),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            
            Positioned(
              top: height * 0.16, 
              left: width * 0.05,
              right: width * 0.05,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text(
                      'Do You Want to Save?',
                      style: GoogleFonts.voces(
                        color: Color(0xFF9C27B0),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 10,),

                    Text('Waiting? Write Your Number Now',
                    style: GoogleFonts.voces(fontSize: 22 , fontWeight: FontWeight.bold ),
                    textAlign: TextAlign.center,   
                    ),
                    
                    SizedBox(height: 5 ,),
                    
                    Text('Share And Start Saving With Your Friends',
                      style: GoogleFonts.voces(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.blueGrey.shade400),
                    ),
                    
                    SizedBox(height: 20,),
                    
                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none, 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xFF9C27B0), width: 2),
                        ),
                      ),
                      initialCountryCode: 'EG',
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.deepPurple,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                ),

                    SizedBox(height: 20,),

                    ElevatedButton(onPressed: (){}, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Color(0xFFE040FB),
                      padding: EdgeInsets.all(20)
                    ),
                    child:Text('Start Saving Now', 
                    style:GoogleFonts.voces(color: Colors.white , fontSize: 23 , fontWeight: FontWeight.bold) ,
                    
                    ) 
                    
                    ),

                  ],
                ),
              ),
            ),

            Positioned(
              top: height * 0.65,
              left: width * 0.01,
              right: width * 0.05,
              
             
                
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.asset(
                            'assets/images/light_mode_no_bg.png',
                            width: 115,   
                            height: 110,
                            fit: BoxFit.cover, 
                          ),
                        ),
                    
                        title: Text('What Is ElectroCart' , 
                          style: GoogleFonts.voces(
                            fontSize: 20 
                          , fontStyle: FontStyle.italic 
                          , fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                    ),

                    SizedBox(height: 10,),

                     Card(
                      child: ListTile(
                         leading: ClipOval(
                          child: Container(
                            width: 115,   
                            height: 110,  
                            color: Colors.transparent, 
                            child: Icon(
                              Icons.shield_outlined,
                              size: 55, 
                             
                            ),
                          ),
                        ),
                    
                        title: Text('Refund Policy' , 
                        style: GoogleFonts.voces(
                            fontSize: 20 
                          , fontStyle: FontStyle.italic 
                          , fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                    ),

                    SizedBox(height: 10,),

                     Card(
                      child: ListTile(
                        leading: ClipOval(
                          child: Container(
                            width: 115,   
                            height: 110,  
                            color: Colors.transparent, 
                            child: Icon(
                              Icons.privacy_tip_outlined,
                              size: 55, 
                             
                            ),
                          ),
                        ),
                        
                        title: Text('Privacy Policy' , 
                        style: GoogleFonts.voces(
                            fontSize: 20 
                          , fontStyle: FontStyle.italic 
                          , fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                    ),

                     
                  ],
                ),
              )
              

          ],
        ),
      ),
    );
  }
}
