


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_hire/agency_registration/registration.dart';
import 'package:match_hire/agencydashboard/applications.dart';
import 'package:match_hire/agencydashboard/dashboard.dart';
import 'package:match_hire/agencydashboard/talent_profile.dart';
import 'package:match_hire/chat/chat.dart';
import 'package:match_hire/chat/settings.dart';
import 'package:match_hire/jobs/add_job.dart';
import 'package:match_hire/jobs/jobs.dart';
import 'package:match_hire/main.dart';
import 'package:match_hire/model/Agency.dart';
import 'package:match_hire/registration/Login.dart';
import 'package:match_hire/registration/landing.dart';
import 'package:match_hire/registration/registration_step1.dart';
import 'package:match_hire/registration/registration_step2.dart';
import 'package:match_hire/registration/registration_step3.dart';
import 'package:match_hire/jobs/job_detail.dart';

import '../registration/upload_image.dart';

class RouteGenerator{

  static String peerId;
  static String peerAvatar;

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register1':
        return MaterialPageRoute(builder: (context) => RegisterOnePage());
      case '/register2':
        return MaterialPageRoute(builder: (context) => RegisterSecondPage(user: args,));
      case '/register3':
        return MaterialPageRoute(builder: (context) => RegisterThirdPage(user: args,));
      case '/':
        return MaterialPageRoute(builder: (context) => LandingPage());
      case '/image':
        return MaterialPageRoute(builder: (context) => ImagePage(null));

      case '/detail':
        return MaterialPageRoute(builder: (context) => JobsDetailScreen(job: args,));
      case '/home':
        return MaterialPageRoute(builder: (context) => Jobs( user: args));
      case '/agency':
        return MaterialPageRoute(builder: (context) => AgencyRegisterPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (context) => AgencyDashboardPage());
      case '/applications':
        return MaterialPageRoute(builder: (context) => ApplicationsPage(args));
      case '/talentprofile':
        return MaterialPageRoute(builder: (context) => TalentProfile(args));

      case '/addjob':
        return MaterialPageRoute(builder: (context) => AddJobScreen());
      case '/chat':
        return MaterialPageRoute(builder: (context) => Chat(peerId: RouteGenerator.peerId,peerAvatar: RouteGenerator.peerAvatar,));
      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());
      default :
        return MaterialPageRoute(builder: (context) => Landing());
    }
  }



}