import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server

sendAnEmail(List<String> messages) async {
  String username = 'nick.langan@gmail.com'; //Your Email;
  String password = 'NICK6666'; //Your Email's password;



  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add('nick@wnjl.com') //recipent email   
    ..subject = 'Submission from ' + messages.elementAt(0) + ' :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'Name is: ' + messages.elementAt(0) + ' \n' + 
  'Email is: ' + messages.elementAt(1) + ' \n' +
  'Message is: ' + messages.elementAt(2); //body of the email

  try {
    final sendReport = await send(message, smtpServer);
     //print if the email is sent
  } on MailerException catch (e) {
     //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}