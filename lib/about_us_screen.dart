

import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
import 'package:agp_ziauddin_virtual_clinic/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        title: Text("About Us"),
      ),
      
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                boldText("SOFTSOLS PAKISTAN", 20),
                Text(
                  "Quality | Technology | Innovation | Customer Satisfaction | Win together",
                  style: TextStyle(color: blue, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  """

SoftSols Pakistan, as a leading IT solution and service provider, provides innovative information technology - enabled solutions and services to meet the demands arising from social transformation, shaping new life styles for individuals and creating values for the society. 
Since Inception in 2007, we are offering our clients Strategic IT Consultancy Services for:
>	Corporate IT Solutions 
>	Custom Web Design & Development Services 
>	Digital Marketing Services including Content Marketing, Social Media Marketing, 
>	Email Marketing, Newsletter, Corporate and Brand Videos 
>	Native Mobile Apps Development (Android and IOS) 
>	Gamification Services (Unity 3D Games & 2D Games Development) 
>	Webinar & Web Casting Services & VR Videos  
>	Artificial Intelligence & Automation 
>	Team Launch and Product Launches 
>	Corporate Profile and Documentary 
>	Training and Consultation 
>	Event Management (Theme Setup, A/V, SMD, Printing, Transportation, Catering) 
>	Corporate Holiday Parties and Picnics  
>	3D advertising & Holographic display 
>	Team Building Activities 
>	Medical Conferences and Conventions 
>	Printing Services (Brochure, Banners, Badges, Certificates, Shields, Writing Pads, Bags) 
>	Corporate Catering Services (Hi – Tea, Lunch, Gala Dinners)
          
VISIT WWW.SOFTSOLS.PK FOR COMPLETE INFORMATION
          
           
Mr. Kashif Fareed
C.E.O.
Softsols Pakistan
ceo@softsols.pk
0301-2712507
                  """,
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
