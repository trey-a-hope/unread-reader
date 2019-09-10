import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sms/contact.dart';
import 'package:sms/sms.dart';

import '../constants.dart';

class SMSHelper{
    static Image getThreadContactImage(SmsThread thread) {
    Photo contactPhoto = thread.contact.photo;
    if (contactPhoto == null) return null;
    Uint8List fullSize = contactPhoto.bytes;
    Image image = Image.memory(fullSize);
    return image;
  }

  static String getThreadContactName(SmsThread thread) {
    return thread.contact.fullName ?? 'NO NAME';
  }

  static int messageLimit(SmsThread thread){
    if(MESSAGES_LIMIT < thread.messages.length)
    return MESSAGES_LIMIT;
    else return thread.messages.length;
  
  }
}