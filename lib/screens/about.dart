import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0XFF03DAC5), // add custom icons also
          ),
        ),
        backgroundColor: Colors.white,
        title: Text("Second Route"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Tasks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: '.',
                          style: TextStyle(
                              color: const Color(0XFF03DAC5),
                              fontWeight: FontWeight.bold)),
                      //TextSpan(text: ' world!'),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: RichText(
                  text: TextSpan(
                    text: 'LVL 1 (core: 1)',
                    style: TextStyle(fontSize: 24, color: Colors.black),

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Thanks for using this App',
                    style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),

                      //TextSpan(text: 'leave us '),

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),

                    //TextSpan(text: 'leave us '),

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(

                    text:'' ,
                    style: TextStyle(
                        fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold),
                    children: <TextSpan>[

                      TextSpan(text: "Your privacy is important to us. It is dea6cat's policy to respect your privacy regarding any information we may collect from you through our app, Tasks."),
                      TextSpan(text: " We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used. We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification. We don’t share any personally identifying information publicly or with third-parties, except when required to by law. You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services. Your continued use of our app will be regarded as acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, feel free to contact us. This policy is effective as of 28 January 2021."),
                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
